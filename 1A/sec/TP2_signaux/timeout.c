/* Time-stamp: <02 Sep 2008 11:11 queinnec@enseeiht.fr> */

/* Exo 4.1.8, page 10 des processus.
 * timeout <temps> <cmde> <arg1> ... <argn> */

/* Rq: le fait de devoir afficher le message 'le fils a ete tue' dans
 * le main et non dans le handler complique la solution: il faut
 * introduire sigalrm_a_ete_recu.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <errno.h>
#include <sys/wait.h>


int pid_fils;
int sigalrm_a_ete_recu = 0;

void death_to_my_son (int unused)
{
    kill (pid_fils, SIGTERM);
    sigalrm_a_ete_recu = 1;
}

int main (int argc, char **argv)
{
    int status;
    int ret;
    if (argc < 3) {
        fprintf (stderr, "timeout <temps> <cmde> <arg1> ... <argn>\n");
        exit (1);
    }
    pid_fils = fork();
    switch (pid_fils) {
      case -1:
        perror ("fork");
        exit(1);
      case 0:                   /* fils: exécute le commande */
        execvp (argv[2], argv+2);
        perror ("Can't exec the command");
        exit (1);
      default:                  /* pere: attend la fin du fils */
        signal (SIGALRM, death_to_my_son);
        alarm (atoi (argv[1]));
        /* En SystemV (donc Solaris/SunOS5), wait est interrompu par le
         * signal SIGALARM et n'est pas redémarré. Il faut donc tester
         * la valeur de retour et errno pour recommencer si nécessaire.
         * En BSD (donc SunOS4), wait est automatiquement redémarré par
         * le noyau, et la boucle devient inutile. */
        do {
            ret = wait (&status);
        } while ((ret == -1) && (errno == EINTR));
        if (ret == -1) {
            perror ("bad wait");
            exit (1);
        }
        if (sigalrm_a_ete_recu)
          printf ("Le fils %d a ete tue.\n", pid_fils);
        else if (WIFEXITED (status))
          printf ("Fils %d exit %d\n", pid_fils, WEXITSTATUS (status));
        else /* WIFSIGNALED (status) */
          printf ("Fils %d killed by %d\n", pid_fils, WTERMSIG (status));
    }
    return 0;
}