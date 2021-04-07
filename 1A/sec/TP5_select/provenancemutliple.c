/* Time-Stamp: <16 Oct 1997 12:42 charpov@enseeiht.fr> */
/* 8.9 */

#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define MSG1 "Je suis le fils lent, lent, lent...\n"
#define MSG2 "Je suis le fils bavard, bla bla bla...\n"

#define BUF_SIZE 64

void handler_sigpipe (int unused)
{
    fprintf (stderr, "Signal SIGPIPE\n");
    exit (3);
}

int main (int argc, char *argv[])
{
    int flent, fbavard;         /* les deux processus fils. */
    int plent[2], pbavard[2];   /* les deux tubes. */
    int vlent, vbavard, vstd;   /* indique si quels processus sont vivants. */
    int nbiter;                 /* nbre de messages affichés par chaque fils */

    if (argc > 2) {
        fprintf (stderr, "Usage: %s [nb iter]\n", argv[0]);
        exit (1);
    }

    nbiter = 10;
    if (argc == 2)
      nbiter = atoi (argv[1]);

    signal (SIGPIPE, handler_sigpipe);

    if (pipe (plent) == -1) {
        perror ("pipe");
        exit (2);
    }

    flent = fork ();
    if (flent == -1) {
        perror ("fork");
        exit (2);
    }
  
    if (flent == 0) {		/* fils lent */
        int lmsg1;
        int i;
        lmsg1 = strlen (MSG1);
        close (plent[0]);
        for (i = 0; i < nbiter; i++) {
            if (write (plent[1], MSG1, lmsg1) == -1) {
                perror ("write");
                exit (3);
            }
            sleep (5);
        }
        exit (0);
    }

    /* Père  */
    close (plent[1]);
    if (pipe (pbavard) == -1) {
        perror ("pipe");
        exit (2);
    }
    fbavard = fork ();
    if (fbavard == -1) {
        perror ("fork");
        exit (2);
    }
    if (fbavard == 0) {		/* fils bavard */
        int lmsg2;
        int i;
        lmsg2 = strlen (MSG2);
        close (plent[0]);
        close (pbavard[0]);
        for (i = 0; i < nbiter; i++) {
            if (write (pbavard[1], MSG2, lmsg2) == -1) {
                perror ("write");
                exit (3);
            }
            sleep (2);
        }
        exit (0);
    }
    /* pere */
    close (pbavard[1]);

    vlent = 1;
    vbavard = 1;
    vstd = 1;

    while (vstd || vlent || vbavard) {
        fd_set readfds;         /* l'ensemble des descripteurs à écouter. */
        int nb_a_lire;          /* combien de descr où lecteur possible.  */
        struct timeval timeout; /* délai d'attente pour le select. */
        char buf[BUF_SIZE];     /* tampon pour la recopie. */
        
        FD_ZERO (&readfds);
        if (vstd)
          FD_SET (0, &readfds);
        if (vlent)
          FD_SET (plent[0], &readfds);
        if (vbavard)
          FD_SET (pbavard[0], &readfds);

        timerclear (&timeout);
        timeout.tv_sec = 10;
  
        nb_a_lire = select (FD_SETSIZE, &readfds, NULL, NULL, &timeout);
        if (nb_a_lire == -1) {
            perror ("select");
            exit (3);
        }

        if (nb_a_lire != 0) 
          printf ("Quelque chose a lire sur %d descripteur%s...\n",
                   nb_a_lire, (nb_a_lire > 1)?"s":"");
        else
          printf ("Rien depuis 10 secondes...\n");
    
        if (vstd && FD_ISSET (0, &readfds)) {
            int r;
            r = read (0, buf, BUF_SIZE);
            if (r == -1) {
                perror ("read");
                exit (3);
            } else if (r == 0) {
                printf ("**** Mort de l'entree standard.\n");
                vstd = 0;
            } else {
                write (1, buf, r);
            }
        }

        if (vlent && FD_ISSET (plent[0], &readfds)) {
            int r;
            r = read (plent[0], buf, BUF_SIZE);
            if (r == -1) {
                perror ("read");
                exit (3);
            }
            if (r != 0) {
                write (1, buf, r);
            } else if (r == 0) {
                printf ("**** Mort du fils lent.\n");
                vlent = 0;
            } else {
                write (1, buf, r);
            }
        }
    
        if (vbavard && FD_ISSET (pbavard[0], &readfds)) {
            int r;
            r = read (pbavard[0], buf, BUF_SIZE);
            if (r == -1) {
                perror ("read");
                exit (3);
            }
            if (r != 0) {
                write (1, buf, r);
            } else if (r == 0) {
                printf ("**** Mort du fils bavard.\n");
                vbavard = 0;
            } else {
                write (1, buf, r);
            }
        }
    }
    exit (0);
}