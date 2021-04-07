#include <unistd.h>
#include <stdio.h>
#include <signal.h>

void handler(int sig){
    printf("Actif %d\n", sig);
}

int main (int argc, char* argv[]){
    int i;
    for (i=1; i<32; i++){
        signal(i, handler);
    }
    for (i=0; i<5;i++){
        printf("Avant \n");
        alarm(3);
        printf("Apres \n");
        printf("Avant pause \n");
        pause();
        printf("Apres pause\n");

    }
    return 0;
}