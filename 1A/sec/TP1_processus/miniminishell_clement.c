#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main() {
    char buf[30];
    int pidFils,idFils,codeTerm;

    while(1){
        printf("[%s@miniminishell]$ ",getenv("USER"));
        scanf("\%s",buf);

        pidFils = fork();
        if (pidFils == -1){
            printf("erreur lors de la création du fils");
            exit(-1);
        }
        else if (pidFils == 0)
        {
            char * args[] = {buf,NULL};
            execvp(buf,args);
            printf("Commande inconnue\n");
            exit(EXIT_FAILURE);
        }
        else
        {
            idFils = wait(&codeTerm);
            if(idFils == -1) {
               printf("erreur !\n");
            }
            else
            {
                if (WIFEXITED(codeTerm)) {
                    printf("\nLa commande s'est arrêtée avec le code %d\n",WEXITSTATUS(codeTerm));
                    
                }
                else
                {
                    printf("\nla commande a été tuée avec le code %d\n",WTERMSIG(codeTerm));
                }
                
            }
        
        }
    }
    

}