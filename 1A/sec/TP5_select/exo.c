# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <ctype.h>
# include <fcntl.h>
# include <sys/types.h>
# define BUFSIZE 512

void traiter( char tampon [], char cde , int nb) {
    int i;

    /* toupper , tolower , module string .h */
    switch ( cde) {
        case 'X' :
            break;
        case 'Q' :
            exit(0);
            break ;
        case 'R' :
            tampon[nb] = '\0';
            printf("%s", tampon );
            break ;
        case 'M' :
            for (i=0; i < nb; i++) {
                tampon[i] = toupper( tampon[i]);
            }
            tampon[nb] = '\0';
            printf("%s", tampon );
            break ;
        case 'm' :
            for (i=0; i < nb; i++) {
                tampon[i] = tolower( tampon[i]);
            }
            tampon[nb] = '\0';
            printf("%s", tampon );
            break;
        default :
            printf(" ???? ");
    }
    return;
}

int main (int argc , char * argv []) {
    int p[2];
    pid_t pid;
    int d, nlus ;
    char buf[ BUFSIZE + 1];
    struct timeval timeout;
    timeout.tv_sec =2;
    char commande = 'R'; /* mode normal */
    if (argc!= 2) {
        printf(" utilisation  : %s <fichier   source >\n", argv [0]);
        exit(1);
    }
    if (pipe(p) == -1) {
        perror(" pipe ");
        exit(2);
    }
    pid = fork();
    if (pid == -1) {
        perror(" fork ");
        exit(3);
    }
    if (pid == 0) { /* fils */
        d = open (argv[1], O_RDONLY );
        if (d == -1) {
        fprintf (stderr , " Impossible  d'ouvrir  le  fichier  ");
        perror(argv[1]);
        exit(4);
        }
        close(p[0]); /* pour finir malgre tout , avec sigpipe */
        while (1) {
            while (( nlus = read (d, buf , BUFSIZE )) > 0) {
            /* read peut lire moins que le nombre d'octets demandes , en
            * particulier lorsque la fin du fichier est atteinte . */
            write (p[1] , buf , nlus );
            sleep (5);
            }
        sleep(5);
        printf ("on  recommence ...\n");
        lseek (d, ( off_t ) 0, SEEK_SET );
        }
    } else { /* pere */
        close (p[1]);
        system (" stty  -icanon   min 1");
        /* a completer */
        while ( commande != 'Q') {
            fd_set set;
            FD_ZERO(&set);
            FD_SET(0, &set);
            FD_SET(p[0],&set);
            select(p[0],&set, NULL,NULL,&timeout);
            if (FD_ISSET(0, &set)) {
                read(0,&commande,sizeof(char));
            }
            if (FD_ISSET(p[0], &set)) {
                int nb = read(p[0], buf, BUFSIZE);
                traiter(buf, commande, nb);
            }
            sleep (1);
        }
    }
    return 0;
}