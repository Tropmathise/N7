#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <unistd.h>
#include "readcmd.h"
#include "color.h"
#include "list_process.h"
#include "utils.h"
#include "handlers.h"

#include <stdbool.h>

processList process_list;
int proc_avant_plan;

void freeDynMem(processList* process_list,cmdline* command) {
    freePList(process_list);
    freecmd(command);
    free(command);
    command = NULL;
}


int main() {
    proc_avant_plan = 1;
    process_list = empty_process_list();

    signal(SIGTSTP,handler_SIGTSTP);
    signal(SIGINT,handler_SIGINT);
    signal(SIGCHLD,handler_SIGCHLD);
    sigset_t sig_set;
    sigemptyset(&sig_set);
    sigaddset(&sig_set,SIGTSTP);
    sigaddset(&sig_set,SIGINT);
    
    

    int pidFils,idFils;

    while(1){

        printPrompt();
        cmdline *command = readcmd();

        if(command->err != NULL)
            exit(1);
        
        if (command->seq[0] == NULL) {
            continue;
        }

        int i = 0;
        int old_pipe[2],new_pipe[2];
        if (pipe(old_pipe) == -1) {
            exit(EXIT_FAILURE);
        }      

        while (command->seq[i] != NULL) {

            if (strcmp(command->seq[i][0],"cd") == 0) {
                //"cd" builtin
                if (command->seq[i][1] == NULL || strcmp(command->seq[0][1],"~") == 0){
                    chdir(getenv("HOME"));
                }
                else
                {
                    chdir(command->seq[0][1]);
                }
                
            }
            else if (strcmp(command->seq[i][0],"exit") == 0){
                //"exit(code)" builtin
                if (command->seq[i][1] != NULL){
                    freeDynMem(&process_list,command);
                    exit(atoi(command->seq[0][1]));
                }
                else
                {
                    freeDynMem(&process_list,command);
                    exit(0);
                }
            } else if (strcmp(command->seq[i][0],"list") == 0){
                //"list" builtin
                printf("ID | PID  |   STATE   | COMMAND\n");
                for (int j = 0; j < process_list.size; j++) {
                    printf("%d  | %d | %s | %s",process_list.list[j]->id,process_list.list[j]->pid,printState(process_list.list[j]->state),process_list.list[j]->command);
                    printf("\n");
                }
            } else if (strcmp(command->seq[i][0],"stop") == 0){
                //"stop" builtin
                if (command->seq[i][1] != NULL){
                    int id = atoi(command->seq[i][1]);
                    pid_t pid_fils = pid_from_id(&process_list,id);
                    kill(pid_fils,SIGSTOP);
                    process_list.list[id]->state = SUSPENDED;
                }
            } else if (strcmp(command->seq[i][0],"bg") == 0){
                //"bg" builtin
                if (command->seq[i][1] != NULL){
                    int id = atoi(command->seq[i][1]);
                    pid_t pid_fils = pid_from_id(&process_list,id);
                    kill(pid_fils,SIGCONT);
                    process_list.list[id]->foreground = false;
                }
            } else if (strcmp(command->seq[i][0],"fg") == 0){
                //"fg" builtin
                if (command->seq[i][1] != NULL){
                    int id = atoi(command->seq[i][1]);
                    pid_t pid_fils = pid_from_id(&process_list,id);
                    kill(pid_fils,SIGCONT);
                    proc_avant_plan = 1;
                    while (proc_avant_plan != 0) {pause();}
                }

            } else{
                if (command->seq[i+1] != NULL) {
                    pipe(new_pipe);
                }

                pidFils = fork();
                if (pidFils == -1){
                    red();
                    printf("fork error\n");
                    resetColor();
                    exit(-1);
                }
                else if (pidFils == 0)
                {
                    //child code
                    

                    if (command->seq[i+1] != NULL) {
                        //There is a following command
                        close(new_pipe[0]);
                        dup2(new_pipe[1],1);
                        close(new_pipe[1]);
                        
                    }                   
                    if (i != 0) {
                        //There is a previous command
                        dup2(old_pipe[0],0);
                        close(old_pipe[0]);
                        close(old_pipe[1]);
                    }      
                    
                    
                    sigprocmask(SIG_BLOCK,&sig_set,NULL);
                    setUpRedirections(command->in,command->out);
                    execvp(command->seq[i][0],command->seq[i]);
                    red();
                    printf("unknown command\n");
                    resetColor();
                    freeDynMem(&process_list,command);
                    exit(EXIT_FAILURE);
                }
                else
                {
                    //father code
                    
                    if (i != 0) {
                        close(old_pipe[0]);
                        close(old_pipe[1]);
                    }
                    if (command->seq[i+1] != NULL) {
                        //current out pipe becomes
                        // following command in pipe
                        old_pipe[0] = new_pipe[0];
                        old_pipe[1] = new_pipe[1];
                    }

                    //saving child process info in process table
                    process process_fils = {0};
                    process_fils.command = mergeString(command->seq[i]);
                    
                    process_fils.id = process_list.size;
                    process_fils.pid = pidFils;
                    process_fils.state = ACTIVE;
                    

                    
                    if (command->backgrounded == NULL) {
                        process_fils.foreground = true;
                        add(&process_list,process_fils);
                        proc_avant_plan = 1;
                        
                    }
                    else {
                        process_fils.foreground = false;
                        add(&process_list,process_fils);
                        if (size_cmdline(command) == 1)
                            printf("[%d] %d\n",process_list.size-1,pidFils);
                        proc_avant_plan = 0;

                    }
                    while (proc_avant_plan != 0) {pause();}
                    free(process_fils.command);
                }
            }
            i++;
        }
        if (size_cmdline(command) > 1) {
            close(old_pipe[0]);
            close(old_pipe[1]);
        }
    }
    

}