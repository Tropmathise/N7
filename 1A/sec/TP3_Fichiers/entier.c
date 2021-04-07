#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <sys/types.h>
#include <string.h>   /* opérations sur les chaines */
#include <fcntl.h>    /* opérations sur les fichiers */
#define BUFSIZE 1024

int main() {
    char fichier[] = "nombreentier.txt";
    char buffer[BUFSIZE];
    bzero(buffer, sizeof(buffer));
    int fichiersource=open(fichier, O_RDONLY);
    int fichierdest=open("temp.txt",O_WRONLY | O_CREAT | O_TRUNC, 0640);
    if (fichiersource<0) {
        printf("Erreur ouverture %s\n", fichier);
        perror("Perror:");
        exit(1);
    }
    if (fichierdest<0) {
        printf("Erreur ouverture %s\n", "temp.txt");
        perror("Perror:");
        exit(1);
    }
    //10 premiers entiers codés sur 2 bits
    for(int i=1;i<11;i++){
        read(fichiersource,buffer,2);
        printf("%s\n", buffer);
        write(fichierdest,buffer,2);
        sleep(1);
    }
    lseek(fichierdest,0,SEEK_SET);
    for (int j=1; j<3;j++){
        for (int i=1;i<11; i++){
            read(fichiersource,buffer,3);
            printf("%s\n", buffer);
            write(fichierdest,buffer,3);
            sleep(1);
        }
        lseek(fichierdest,0,SEEK_SET);
    }
    close(fichierdest);
    if(close(fichierdest)<0){
        printf("Erreur de fermeture du fichier : %s\n", "temp.txt");
        perror("Perror :");
    }
    close(fichiersource);
    if (close(fichiersource)<0){
        printf("Erreur de fermeture du fichier : %s\n",fichier);
        perror("Perror :");
    }

    exit(EXIT_SUCCESS);

}