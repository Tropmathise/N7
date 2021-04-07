#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <sys/wait.h> /* wait */

#define DELAI 10

void handler(int signal_num) {
    printf("\n     Processus de pid %d : J'ai reçu le signal %d\n", 
            getpid(),signal_num);
    return;
}

int main() {
    sigset_t ens_sigusr1, ens_sigint;
    sigemptyset(&ens_sigint);
    sigemptyset(&ens_sigusr1);
    sigaddset(&ens_sigint, SIGINT);
    sigaddset(&ens_sigusr1, SIGUSR1);
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);
    printf("\nProcessus de pid %d : Je masque SIGINT durant %d secondes\n", getpid(), DELAI);
    /* masquer les signaux définis dans ens_signaux : SIGINT et SIGUSR1 */
    sigprocmask(SIG_BLOCK, &ens_sigusr1, NULL);
    sigprocmask(SIG_BLOCK, &ens_sigint, NULL);
    printf("Envoyez SIGINT au clavier\n");
    printf("Attendez 10 secondes\n");
    sleep(DELAI);
    printf("envoie 2 SIGUSR1 \n");
    kill(getpid(),SIGUSR1);
    kill(getpid(),SIGUSR1);
    printf("Attendez 5 secondes \n");
    sleep(5);
    printf("envoie 2 SIGUSR2 \n");
    kill(getpid(),SIGUSR2);
    kill(getpid(),SIGUSR2);
    /*demasquage de SIGUSR1*/
    printf("\nProcessus de pid %d : Je démasque SIGUSR1\n", getpid());
    sigprocmask(SIG_UNBLOCK, &ens_sigusr1, NULL);
    printf("Attendez 10 secondes\n");
    sleep(10);
    /*demasquage de SIGINT*/
    printf("\nProcessus de pid %d : Je démasque SIGINT\n", getpid());
    sigprocmask(SIG_UNBLOCK, &ens_sigint, NULL);
    printf("message de terminaison\n");
    return EXIT_SUCCESS;
}

/* Réponses aux questions 

1.1 avant codage : il y aura deux SGUSR1 et deux SIGUSR2 affichés
1.2 apres codage : il y a en realité deux SIGUSR2 et un seul SIGUSR1
2.1 avant codage : il y aura deux infos sur le signal reception de SIGUSR2 puis deux retours de signaux de SIGUSR1
2.2 apres codage : il y a en realité les deux signaux de SIGUSR2 mais qu'un seul pour SIGUSR1 car ils arrivent en meme temps apres demasqauge donc pas le temps de traiter
3.1 avant codage : le message de terminaison s'affichera apres 25 secondes
3.2 apres codage : le message de terminaison s'affiche bien apres 25 secondes que lorsque que le SIGINT n'a pas été envoyé
/*