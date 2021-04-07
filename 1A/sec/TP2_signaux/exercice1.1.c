#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */

void handler(int signal_num) {
    printf("\n     Processus de pid %d : J'ai reçu le signal %d\n", 
            getpid(),signal_num);
    return;
}

int main(int argc, char* argv[]) {
    int i, retour;
    for (i=1; i<32; i++){
        signal(i,handler);
    }
    printf("\nJe suis le processus principal de pid %d\n", getpid());
    retour=fork();
    if (retour < 0) {   /* échec du fork */
        printf("Erreur fork\n");  /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
        exit(1);
    }
    /* fils */
    if (retour == 0) {
        execl("/bin/sleep", "/bin/sleep", "100", NULL);
        printf("\n     Processus fils, de pid %d, de pere %d.\n", 
                    getpid(), getppid());
        exit(EXIT_SUCCESS);
    }
    /* pere */
    else {
        printf("\nProcessus de pid %d a cree un fils, de pid %d \n", 
                    getpid(), retour);
    }

    for (i=1; i<13; i++){
        sleep(5);
        printf("Actif\n");
    }
    return 0;
}