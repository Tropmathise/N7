/* Time-stamp: <17 Mar 2000 17:03 queinnec@enseeiht.fr> */

#include <stdio.h>
#include <stdarg.h>
#include <unistd.h>
#include <errno.h>

#define MSGSIZE 512

/*
 * Copie `nbbytes' octets depuis le descripteur `from' sur le descripteur `to'.
 * En cas d'échec, affiche un message explicatif.
 * Renvoie 0 si ok, -1 en cas d'erreur.
 *
 * La lecture est faite par bloc de MSGSIZE octets. L'écriture s'attend
 * à ne pas pouvoir tout écrire d'un seul coup.
 */
int copy_n_bytes (int from, int to, int nbbytes)
{
    char buf[MSGSIZE];
    char *p;
    while (nbbytes != 0) {
        int ecrit;
        int lu;
        lu = read (from, buf, ((nbbytes < MSGSIZE) ? nbbytes : MSGSIZE));
        if (lu == -1) {
            perror ("bad read");
            return -1;
        } else if (lu == 0) {
            fprintf (stderr, "EOF (connection closed)\n");
            return -1;
        }
        nbbytes -= lu;
        p = buf;
        while (lu != 0) {
            ecrit = write (to, p, lu);
            if (ecrit == -1) {
                perror ("bad write");
                return -1;
            }
            p += ecrit;
            lu -= ecrit;
        }
    }
    return 0;
}