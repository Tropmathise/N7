#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */
#define BUFSIZE 4096

int main (int argc, char *argv[]) {

    int fichiersource, fichierdest,nb;
    char tampon[BUFSIZE];     /* buffer de lecture */
    bzero(tampon, sizeof(tampon));
    fichiersource=open(argv[1],O_RDONLY);
    if (fichiersource<0) {
        printf("Erreur ouverture %s\n", argv[1]);
        perror("Perror:");
        exit(1);
    }

    fichierdest=open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0640);
    if (fichierdest<0) {
        printf("Erreur ouverture %s\n", argv[2]);
        perror("Perror:");
        exit(1);
    }

    while((nb=read(fichiersource,tampon,BUFSIZE))>0){
        if(write(fichierdest,tampon,nb)!=nb){
            printf("Erreur en ecrivant dans %s\n", argv[2]);
            perror("Perror :");
        }
        exit(EXIT_SUCCESS);
    }
   
    close(fichierdest);
    if(close(fichierdest)<0){
        printf("Erreur de fermeture du fichier : %s\n", argv[2]);
        perror("Perror :");
    }
    close(fichiersource);
    if (close(fichiersource)<0){
        printf("Erreur de fermeture du fichier : %s\n",argv[1]);
        perror("Perror :");
    }
    exit(EXIT_SUCCESS);
}





    