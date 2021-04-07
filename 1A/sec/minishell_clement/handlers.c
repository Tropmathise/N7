#include "handlers.h"

void handler_SIGTSTP(int sig_num) {
    for (int i = 0; i< process_list.size; i++) {
        if (process_list.list[i]->foreground == true) {
            kill(process_list.list[i]->pid,SIGSTOP);
        }
    }
}

void handler_SIGINT(int sig_num) {
    for (int i = 0; i< process_list.size; i++) {
        if (process_list.list[i]->foreground == true) {
            kill(process_list.list[i]->pid,SIGKILL);
        }
    }
}

void handler_SIGCHLD(int sig_num) {
   int etat_fils;
   pid_t pid_fils;

    do {
        pid_fils = (int) waitpid(-1, &etat_fils, WNOHANG | WCONTINUED | WUNTRACED );
        if ((pid_fils == -1) && (errno != ECHILD)) {
            perror("waitpid");
            exit(EXIT_FAILURE);
        } else if (pid_fils > 0) {
            
            if (WIFSTOPPED(etat_fils)) {
                /* traiter la suspension */
                process_list.list[id_from_pid(&process_list,pid_fils)]->state = SUSPENDED;
                yellow();
                printf("suspended %s\n",process_list.list[id_from_pid(&process_list,pid_fils)]->command);
                resetColor();
                proc_avant_plan = 0;
            } else if (WIFCONTINUED(etat_fils)) {
                /* traiter la reprise */
                process_list.list[id_from_pid(&process_list,pid_fils)]->state = ACTIVE;
            } else if (WIFEXITED(etat_fils)) {
                delete_pid(&process_list,pid_fils);
                proc_avant_plan = 0;
            } else if (WIFSIGNALED(etat_fils)) {
                if (WTERMSIG(etat_fils))  {
                    //le fils a reçu sigkill
                    magenta();
                    printf("minishell : killed %s\n",process_list.list[id_from_pid(&process_list,pid_fils)]->command);
                    resetColor();
                    delete_pid(&process_list,pid_fils);
                    proc_avant_plan = 0;
                }
            }     
        }
    } while (pid_fils > 0);
    /* autres actions après le suivi des changements d'état */
    
}
