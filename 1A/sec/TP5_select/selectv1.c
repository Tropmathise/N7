#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/time.h>

#define NB_DESC 256

int main(void)
{
    int            nb, p1[2], p2[2], p3[2];
    fd_set         fds;
    int            res;
    struct timeval t_out;

    if ( pipe(p1) == -1 )
        {
            fprintf(stderr,"Erreur creation premier pipe\n");
            exit(1);
        }

    if ( fork() == 0 )     /* premier fils : appel errone */
        {
            close(1);
            dup(p1[1]);
            close(p1[0]); 
            close(p1[1]);
            execl("transmet_v1","transmet_v1","1","2",NULL);
            fprintf(stderr,"probleme execution premier exec\n");
        }

    /* pere */
    close(p1[1]);
    
    if ( pipe(p2) == -1 )
        {
            fprintf(stderr,"Erreur creation deuxieme pipe\n");
            exit(2);
        }
    
    if ( fork() == 0 )     /* deuxieme fils : appel avec 10 */
        {
            close(p1[0]); 
            close(1);
            dup(p2[1]);
            close(p2[0]); 
            close(p2[1]);
            execl("transmet_v1","transmet_v1","10",NULL);
            fprintf(stderr,"probleme execution deuxieme exec\n");
        }

    /* pere */
    close(p2[1]);
 
    if ( pipe(p3) == -1 )
        {
            fprintf(stderr,"Erreur creation troisieme pipe\n");
            exit(3);
        }

    if ( fork() == 0 )    /* troisieme fils : appel avec 7 */
        {
            close(p1[0]); 
            close(p2[0]); 
            close(1);
            dup(p3[1]);
            close(p3[0]);
            close(p3[1]);
            execl("transmet_v1","transmet_v1","7",NULL);
            fprintf(stderr,"probleme execution troisieme exec\n");
        }
    close(p3[1]);

    sleep(2);

    FD_ZERO(&fds);
    FD_SET(p1[0], &fds);
    FD_SET(p2[0], &fds);
    FD_SET(p3[0], &fds);

    timerclear(&t_out);
    t_out.tv_sec=3;
    res= select(NB_DESC, &fds,NULL,NULL,&t_out);

    printf("retour de select=%d\n",res);

    if ( res >= 1 )
        {
            if ( FD_ISSET(p1[0], &fds) )
                {
                    printf("fils1 a ecrit ->");
                    read(p1[0],&nb,sizeof(int));
                    printf("%d\n",nb);
                }
            if ( FD_ISSET(p2[0], &fds) )
                {
                    printf("fils2 a ecrit ->");
                    read(p2[0],&nb,sizeof(int));
                    printf("%d\n",nb);
                }
            if ( FD_ISSET(p3[0], &fds) )
                {
                    printf("fils3 a ecrit ->");
                    read(p3[0],&nb,sizeof(int));
                    printf("%d\n",nb);
                }
        }
    else
        {
            printf("select : timeout\n");
        }

    printf("le pere a fini\n");
    exit(0);
}

/*************************************
%version1
retour de select=3
fils1 a ecrit ->-1
fils2 a ecrit ->10
fils3 a ecrit ->7
le pere a fini
*************************************/
