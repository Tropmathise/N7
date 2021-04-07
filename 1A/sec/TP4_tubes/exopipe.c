#include <unistd.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

/* fermer tout les descripteurs */ 
void closeall(int p[2], int q[2]){
    close(p[0]);
    close(p[1]);
    close(q[0]);
    close(q[1]);
}

int main(){
    int pipep[2];
    int pipeq[2];

    int retour1=pipe(pipep);
    if (retour1==-1){
        printf("Erreur pipe1\n");
        exit(1);
    }

    int fils1=fork();
    if(fils1<0){
        printf("Erreur fork1\n");
        exit(1);
    }

    if (fils1==0){

        int retour2=pipe(pipeq);
        if (retour2==-1){
            printf("Erreur pipe2\n");
            exit(1);
        }

        int fils2=fork();
        if (fils2<0){
            printf("Erreur fork2\n");
            exit(1);
        }
        if (fils2==0){
            dup2(pipeq[0],0);
            closeall(pipep,pipeq);
            /* close(pipep[0]);
            close(pipep[1]);
            close(pipeq[0]);
            close(pipeq[1]); */
            execlp("wc","wc","-l",NULL);
        }
        dup2(pipep[0],0);
        dup2(pipeq[1],1);
        closeall(pipep,pipeq);
        /*close(pipep[0]);
        close(pipep[1]);
        close(pipeq[0]);
        close(pipeq[1]);*/
        execlp("grep", "grep",getenv("USER"), NULL);
    }
    dup2(pipep[1],1);
    close(pipep[0]);
    close(pipep[1]);
    execlp("who","who",NULL);
    
}