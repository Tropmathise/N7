/* Time-stamp: <02 Sep 2008 10:37 queinnec@enseeiht.fr> */
/* 8.3 who | grep toto | wc -l */

/* Structure:
 *   pÃ¨re  : wc,
 *   fils 1: who,
 *   fils 2: grep.
 *
 * Le shell considÃ¨re que l'exÃ©cution d'un programme est terminÃ©e quand
 * le processus qu'il a crÃ©Ã© pour l'exÃ©cuter est terminÃ© (il affiche alors
 * le prompt et est prÃªt Ã  recevoir de nouveaux ordres). Il est donc
 * important que ce soit le dernier Ã©lÃ©ment de la chaÃ®ne qui soit exÃ©cutÃ©
 * par le processus pÃ¨re.
 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{
    int p[2], q[2];
    int n, m;

    if (argc != 2) {
        fprintf (stderr, "Mauvais nombre de parametres.\n");
        exit (2);
    }

    if (pipe (p) == -1) {
        perror ("pipe");
        exit (1);
    }

    n = fork ();
    if (n == -1) {
        perror ("fork");
        exit (1);
    }

    if (n == 0) {               /* fils 1: who|... */
        close (p[0]);
        dup2 (p[1], 1);
        close (p[1]);
        execlp ("who", "who", NULL);
        perror ("exec who");
        exit (1);

    } else {                    /* pere: ...|suite */
        close (p[1]);
        dup2 (p[0], 0);
        close (p[0]);

        if (pipe (q) == -1) {   /* suite = grep|wc */
            perror ("pipe");
            exit (1);
        }

        m = fork();
        if (m == -1) {
            perror ("fork");
            exit (1);
        }
        
        if (m == 0) {           /* fils2 : grep|... */
            close (q[0]);
            dup2 (q[1], 1);
            close (q[1]);
            execlp ("grep", "grep", argv[1], NULL);
            perror ("exec grep");
            exit (1);

        } else {                /* pere: ...|wc */
            close (q[1]);
            dup2 (q[0], 0);
            close (q[0]);
            execlp ("wc", "wc", "-l", NULL);
            perror ("exec wc");
            exit (1);
        }
    }
    /* NOTREACHED */
}