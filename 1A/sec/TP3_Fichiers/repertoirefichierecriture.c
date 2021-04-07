/* Time-stamp: <02 Sep 2008 10:40 queinnec@enseeiht.fr> */

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>           /* pour mkdir */
#include <sys/wait.h>           /* pour wait */

#define NMAX 1000

int main()
{
    int n1, n2, n3;
    char *dirw;
    
    /* création du répertoire de travail */
    dirw = "RESTMP";
    if (mkdir (dirw, 0766) == -1) {
        perror ("mkdir");
        exit (1);
    }
    
    /* création de 2 fils */
    n1=fork();
    if (n1 == -1) {
        perror ("fork1");
        exit(2);
    }
    
    /* un processus fils1 a été créé */
    if (n1 != 0) {  /* processus père */
        n2=fork();
        if (n2 == -1) {
            perror ("fork2");
            exit(2);
        }
        if (n2 != 0) { /* processus père */
            int retw1, retw2;
            /* attente de la fin des fils */
            printf("attente de la fin des fils\n");
            retw1 = wait (NULL);
            printf("fin du processus %d\n", retw1);
            retw2 = wait (NULL);
            printf("fin du processus %d\n", retw2);
            printf("creation du processus nettoyeur \n");
            /* création d'un processus nettoyeur. */
            n3=fork();
            if (n3 == -1) {
                perror ("fork3");
                exit(2);
            }
            if (n3 != 0) { /* processus père */
                /* attente fin du processus nettoyeur */
                wait (NULL);
                printf("fin du processus nettoyeur\n");
                /* destruction du répertoire de travail */
                if (rmdir(dirw) == -1)
                  perror ("rmdir");
            } else {
                /* processus nettoyeur */
                execlp ("sh", "sh", "-c", "/bin/rm RESTMP/*", NULL);
            }
        } else { /*  processus fils 2 */
            int fd;
            printf("--> getpid dans processus fils 2 = %d\n", (int) getpid());
            if (chdir (dirw) == -1) {
                perror ("chdir1");
                exit (3);
            }
            fd = open ("bidon2a", O_RDWR | O_CREAT | O_TRUNC, 0666);
            if (fd == -1) {
                perror ("bidon2a");
                exit(3);
            }
            write(fd, "fils 2", 6);
            sleep(2);
            close(fd);
        }
    } else { /*  processus fils 1 */
        int fd;
        printf("--> getpid dans processus fils 1 = %d\n", (int) getpid());
        if (chdir (dirw) == -1) {
            perror ("chdir1");
            exit (3);
        }
        fd = open ("bidon1a", O_RDWR | O_CREAT | O_TRUNC, 0666);
        if (fd == -1) {
            perror ("bidon1a");
            exit(3);
        }
        write (fd, "fils 1", 6);
        sleep(2);
        close(fd);
    }
    return 0;
}