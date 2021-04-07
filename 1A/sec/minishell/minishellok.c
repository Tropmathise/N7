#include "readcmd.h"  /* readcmd donné*/
#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <sys/wait.h> /* wait */
#include <errno.h>    /* errno */
#include <fcntl.h>    /* gestion de fichier */
#include <sys/types.h>
#include <string.h> 
#include <errno.h>

int minishellpid;
int avant_plan;
void freecmd();

#define ROU "\x1B[31m" 
#define VER "\x1B[32m" 
#define JAU "\x1B[33m"
#define BLE "\x1B[34m"
#define BLC "\x1B[37m" 
#define RST "\x1B[0m"

/* Fonctions pour les jobs */
#define JOBMAX       10 /* jobs maximum */
/* Job states */
#define UNDEF 0 /* undefined */
#define FG 1    /* running in foreground */
#define BG 2    /* running in background */
#define ST 3    /* stopped */

struct job_struct {         /* Strucure du job */
    pid_t jobpid;           /* job PID */
    int jobid;              /* job ID [1, 2, ...] */
    int jobetat;            /* UNDEF, BG (background), FG (foreground), or S (stop) */
    char cmd[150];          /* ligne de commande */
}; 
typedef struct job_struct job_struct;

struct job_struct listedesjobs[JOBMAX];

/* Afficher le prompt */
void display_prompt(){
    char* dossier = getcwd(NULL,0);
    fprintf(stdout, BLE "%s@" RST, getenv("USER"));
    fprintf(stdout, BLC "minishell:" RST);
    fprintf(stdout, ROU "%s" RST,dossier);
    fprintf(stdout, BLC "~$ " RST);
    free(dossier);
    dossier = NULL;
}

/* RAZ d'un job */ 
void clearjob(struct job_struct *job) {
    job->jobpid = 0;
    job->jobid = 0;
    job->jobetat = UNDEF;
    strcpy(job->cmd,"");
}


/* Initialiser les jobs */
void initjob(struct job_struct *jobs) {
    for (int i = 0; i < JOBMAX; i++) {
        clearjob(jobs);
    }
}

/* Retourner l'id maximale du processus */
int maxjobid(struct job_struct *jobs) {
    int max=0;
    for (int i = 0; i < JOBMAX; i++)
	if (jobs[i].jobid > max)
	    max = jobs[i].jobid;
    return max;
}


/* ajoute le job à la liste */
void addjob(struct job_struct *jobs, pid_t pid, int etat, char** cmd) {
    //int cond=1;
    int max = maxjobid(jobs);
    if (jobs[max+1].jobpid == 0) {
        jobs[max+1].jobpid = pid;            
        jobs[max+1].jobetat = etat;
        jobs[max+1].jobid = max + 1;
        for(int j=0; cmd[j]!=0; j++){
            strcat(jobs[max+1].cmd, cmd[j]);
            strcat(jobs[max+1].cmd, " ");            
        }
        /*if(cond){
            printf("job [%d] %d '%s' ajouté à la liste des jobs.\n", jobs[max+1]->jobid, jobs[max+1]->jobpid, jobs[max+1]->cmd);
        }*/
    }
}


/* supprime le job de la liste */
void suppjob(struct job_struct *jobs, pid_t pid) {
    int max=maxjobid(jobs);
    for (int i=0; i<JOBMAX; i++){
        if(jobs[i].jobpid==pid){
            //printf("\njob de pid %d supprimé de la liste des jobs.\n", jobs[i].jobpid);
            clearjob(jobs);
            max=max-1;
        }
    }
}

/* changer l'etat d'un job */
void changeEtat(struct job_struct *jobs, pid_t pid, int etat){
    for(int i=0; i<JOBMAX; i++){
        if(jobs[i].jobpid==pid){
            jobs[i].jobetat=etat;
        }
    }
}

/* recuperer job depuis un pid */
struct job_struct getJobFromPid(struct job_struct *jobs, pid_t pid){
    struct job_struct getjob;
    for(int i=0; i<JOBMAX; i++){
        if(jobs[i].jobpid==pid){
            getjob.jobetat=jobs[i].jobetat;
            getjob.jobid=jobs[i].jobid;
            getjob.jobpid=jobs[i].jobpid;
            strcpy(getjob.cmd,jobs[i].cmd);
        }
    }
    return getjob;
}

/* recuperer id depuis un pid */
int getJobIdFromPid(struct job_struct *jobs, pid_t pid){
    struct job_struct getjob;
    for(int i=0; i<JOBMAX; i++){
        if(jobs[i].jobpid==pid){
            getjob.jobetat=jobs[i].jobetat;
            getjob.jobid=jobs[i].jobid;
            getjob.jobpid=jobs[i].jobpid;
            strcpy(getjob.cmd,jobs[i].cmd);
        }
    }
    return getjob.jobid;
}

/* recuperer job depuis un ID */
pid_t getJobPidFromId(struct job_struct *jobs, int id){
    struct job_struct getjob;
    for(int i=0; i<JOBMAX; i++){
        if(jobs[i].jobid==id){
            getjob.jobetat=jobs[i].jobetat;
            getjob.jobid=jobs[i].jobid;
            getjob.jobpid=jobs[i].jobpid;
            strcpy(getjob.cmd,jobs[i].cmd);
        }
    }
    return getjob.jobpid;
}

/* free la commande des jobs */
void freecommandejobs(struct job_struct *jobs) {
    for (int i=0; i<JOBMAX; i++) {
        free(jobs[i].cmd);
        strcpy(jobs[i].cmd,"");
    }
    free(jobs);
    jobs=NULL;
}

/* affiche la liste des jobs */
void listjobs(struct job_struct *jobs) {
    for (int i = 0; i < JOBMAX; i++) {
        if (jobs[i].jobpid != 0 && jobs[i].jobpid !=-1) {
            printf("[%d] (%d) ", jobs[i].jobid, jobs[i].jobpid);
            switch (jobs[i].jobetat) {
            case BG: 
                fprintf(stdout, JAU "   Running" RST);
                break;
            case FG: 
                fprintf(stdout, JAU "   Foreground" RST);
                break;
            case ST: 
                fprintf(stdout, JAU "   Stopped" RST);
                break;
            default:
                fprintf(stdout, ROU "jobs: Erreur interne: job[%d].etat=%d \n" RST, 
                i, jobs[i].jobetat);
            }
            fprintf(stdout, BLC "    %s\n" RST, jobs[i].cmd);
        }
    }
    fprintf(stdout, RST "\n");
}

/* Traitant du signal SIGCHLD */
void handler_fils (int sig_num) {
    int fils_termine, wstatus;
    do {
        fils_termine = (int) waitpid(-1, &wstatus, WNOHANG | WUNTRACED | WCONTINUED);
        if ((fils_termine == -1) && (errno != ECHILD)) {
            perror("waitpid");
            exit(EXIT_FAILURE);
        } else if (fils_termine > 0) {
            if (WIFSTOPPED(wstatus)) {
                /* traiter la suspension */
                changeEtat(listedesjobs, fils_termine,ST);
                fprintf(stdout, JAU "\nProcessus de pid " RST);
                fprintf(stdout, BLC "%d " RST, fils_termine);
                fprintf(stdout, JAU "a été suspendu.\n" RST);
                struct job_struct newjob=getJobFromPid(listedesjobs,fils_termine);
                printf("[%d]+ (%d) '%s'", newjob.jobid, newjob.jobpid, newjob.cmd);
                fprintf(stdout, JAU " Stopped" RST);
                printf("\n");
                avant_plan = 0;
            } else if (WIFCONTINUED(wstatus)) {
                /* traiter la reprise */
                changeEtat(listedesjobs,fils_termine,FG);
                fprintf(stdout, JAU "\nProcessus de pid " RST);
                fprintf(stdout, BLC "%d " RST, fils_termine);
                fprintf(stdout, JAU "a été relancé.\n" RST);
                printf("\n");
            } else if (WIFEXITED(wstatus)) {
                /* traiter exit */
                suppjob(listedesjobs,fils_termine);
                fprintf(stdout, JAU "\nProcessus de pid " RST);
                fprintf(stdout, BLC "%d " RST, fils_termine);
                fprintf(stdout, JAU "s'est arrêté. Appuyez sur Entrée pour continuer.\n" RST);
                avant_plan=0;
            } else if (WIFSIGNALED(wstatus)) {
                /* traiter signal */
                if (WTERMSIG(wstatus)) {
                    suppjob(listedesjobs,fils_termine);
                    fprintf(stdout, JAU "\nProcessus de pid " RST);
                    fprintf(stdout, BLC "%d " RST, fils_termine);
                    fprintf(stdout, JAU "tué par le minishell.\n" RST);
                    printf("\n");
                    avant_plan=0;
                }
            }
        }
    } while (fils_termine > 0);
    /* autres actions après le suivi des changements d'état */
}

/* handler pour CTRL-Z */
void handler_tstp(int sig_num) {
    if (sig_num==SIGTSTP){
        for (int i=0; i<JOBMAX; i++){
            if (listedesjobs[i].jobetat==FG){
                kill(listedesjobs[i].jobpid, SIGSTOP);
            }
        }
    }
    else{
        printf("\n");
    }
}

/* handler pour CTRL-C */
void handler_int(int sig_num){
    if (sig_num==SIGINT){
        for (int i=0; i<JOBMAX; i++){
            if (listedesjobs[i].jobetat==FG){
                kill(listedesjobs[i].jobpid, SIGKILL);
            }
        }
    }
}

void stop(pid_t pid, struct job_struct *jobs){
    for (int i=0; i<JOBMAX; i++){
        if (jobs[i].jobpid==pid){
            kill(pid,SIGSTOP);
            changeEtat(listedesjobs,pid,ST);
        }
    }
}

void tuer(pid_t pid, struct job_struct *jobs){
    for (int i=0; i<JOBMAX; i++){
        if (jobs[i].jobpid==pid){
            kill(pid,SIGKILL);
        }
    }
}

//pas utile dans le main
void bg(pid_t pid, struct job_struct *jobs){
    for (int i=0; i<JOBMAX; i++){
        if (jobs[i].jobpid==pid){
            kill(pid,SIGCONT);
            jobs[i].jobetat=BG;
        }
    }
}

//pas utile dans le main
void fg(pid_t pid, struct job_struct *jobs){
    for (int i=0; i<JOBMAX; i++){
        if (jobs[i].jobpid==pid){
            kill(pid,SIGCONT);
            jobs[i].jobetat=ST;
            avant_plan=1;
        }
    }
}

void redirection(char *in, char* out) {
    if (in != NULL && access(in,R_OK) != -1) {
        freopen(in,"r",stdin);
    }
    if (out != NULL && (access(out,W_OK) != -1 || errno == ENOENT)) {
        freopen(out,"w",stdout);
    }
}

void freeall(struct job_struct *jobs, struct cmdline *commande){
    freecommandejobs(listedesjobs);
    freecmd(commande);
    free(commande);
    commande=NULL;
}

/* Programme Principal */
int main() {
    minishellpid=getpid();
    int pidFils;
    avant_plan=1;
    initjob(listedesjobs);
    sigset_t ens_sigint, ens_sigtstp;
    sigemptyset(&ens_sigint);
    sigemptyset(&ens_sigtstp);
    sigaddset(&ens_sigint, SIGINT);
    sigaddset(&ens_sigtstp, SIGTSTP);
    signal(SIGTSTP, handler_tstp);
    signal(SIGINT, handler_int);
    signal(SIGCHLD, handler_fils);
    while(1){
        struct cmdline *l;
        display_prompt();
        l=readcmd();

        /* calcule la taille de la commande */
        int taille = 0;
	    while (l->seq[taille] != NULL) {
		    taille++;
	    }

        /* afficher la commande tapé dans le shell */
        for (int i=0; l->seq[i]!=0; i++){
            char **cmd = l->seq[i];
            printf("commande[%d]: ", i);
            for(int j=0; cmd[j]!=0; j++){
                printf("(%s) ", cmd[j]);
            }
            printf("\n");
        }

        /* si erreur de commande */
        if (l->err != NULL) {
            printf("erreur commande");
            exit(1);
        }

        /* si rien est entré : on ne fait rien */
        if (l->seq[0]==NULL){
            continue;
        }

        /* pipe */
        int token = 0;
        int pipep[2];
        int pipeq[2];
        if (pipe(pipep)==-1){
            fprintf(stdout, ROU "Erreur pipe\n" RST);
            exit(1);
        }

        while(l->seq[token] != NULL){

            /* Commande cd */
            if (strcmp(l->seq[token][0], "cd")==0){
                if(l->seq[token][1]==NULL || strcmp(l->seq[token][1], "~")==0){
                    chdir(getenv("HOME"));
                }
                else {
                    int dossier=chdir(l->seq[token][1]);
                    if (dossier<0){
                        fprintf(stdout, JAU "Le dossier n'existe pas. \n" RST);
                    }
                }
            }

            /* Commande stop */
            else if ((strcmp(l->seq[token][0], "stop")==0)){
                if(l->seq[token][1]==NULL){
                    printf("\n");
                    printf("Vous devez mettre en parametre le pid du processus.\n");
                    printf("Un exemple : 'stop 452'\n");
                    printf("Voici la liste des processus :\n");
                    listjobs(listedesjobs);
                }
                else {
                    int x = atoi(l->seq[token][1]);
                    stop(x, listedesjobs);
                    fprintf(stdout, JAU "Le processus %d est stoppé\n" RST, x);
                    continue;
                }
            }

            /* Commande fg */
            else if ((strcmp(l->seq[token][0], "fg")==0)){
                if(l->seq[token][1]==NULL){
                    printf("\n");
                    printf("Vous devez mettre en paramètre le pid du processus.\n");
                    printf("Un exemple : 'fg 763'.\n");
                    printf("Vous pouvez aussi mettre l'ID du processus avec un %% avant.\n");
                    printf("Un exemple : fg %% 2.\n");
                    printf("\n");
                    printf("Voici la liste des processus :\n");
                    listjobs(listedesjobs);
                }
                
                else if ((strcmp(l->seq[token][1], "%")==0)){
                    int id = atoi(l->seq[token][2]);
                    pid_t pidfg = getJobPidFromId(listedesjobs, id);
                    fprintf(stdout, JAU "Poursuite de %d\n" RST, pidfg);
                    kill(pidfg, SIGCONT);
                    avant_plan=1;
                    while(avant_plan != 0){
                        pause();
                    }
                }
        
                else {
                    int x = atoi(l->seq[token][1]);
                    fprintf(stdout, JAU "Poursuite de %d.\n" RST, x);
                    kill(x,SIGCONT);
                    avant_plan=1;
                    while(avant_plan != 0){
                        pause();
                    }
                }
            }

            /* Commande bg */
            else if ((strcmp(l->seq[token][0], "bg")==0)){
                if(l->seq[token][1]==NULL){
                    printf("\n");
                    printf("Vous devez mettre en paramètre le pid du processus.\n");
                    printf("Un exemple : 'bg 763'\n");
                    printf("Vous pouvez aussi mettre l'ID du processus avec un %% avant.\n");
                    printf("Un exemple : bg %% 2.\n");
                    printf("\n");
                    printf("Voici la liste des processus :\n");
                    listjobs(listedesjobs);
                }

                else if ((strcmp(l->seq[token][1], "%")==0)){
                    int y = atoi(l->seq[token][2]);
                    pid_t pidbg = getJobPidFromId(listedesjobs, y);
                    fprintf(stdout, JAU "BG de %d\n" RST, pidbg);
                    bg(pidbg, listedesjobs);
                }
                else {
                    int x = atoi(l->seq[token][1]);
                    fprintf(stdout, JAU "BG de %d\n" RST, x);
                    bg(x, listedesjobs);
                }
            }

            /* Commande exit */
            else if (strcmp(l->seq[token][0],"exit")==0 || strcmp(l->seq[token][0],"EXIT")==0){
                kill(0, SIGTERM);
                freeall(listedesjobs, l);
                exit(EXIT_SUCCESS);
            }

            /* Commande jobs ou list */
            else if (strcmp(l->seq[token][0],"jobs")==0 || strcmp(l->seq[token][0],"list")==0){
                listjobs(listedesjobs);
            }

            else {

                if (l->seq[token+1] != NULL) {
                    pipe(pipeq);
                }
                pidFils = fork();
                
                if (pidFils == -1) {
                    fprintf(stdout, ROU "erreur lors de la création du fils." RST);
                    exit(-1);
                }
                else if (pidFils == 0) {

                    if (l->seq[token+1] != NULL) {
                        close(pipeq[0]);
                        dup2(pipeq[1],1);
                        close(pipeq[1]);
                    }

                    if (token!=0) {
                        dup2(pipep[0],0);
                        close(pipep[0]);
                        close(pipep[1]);
                    }

                    sigprocmask(SIG_BLOCK, &ens_sigint, NULL);
                    sigprocmask(SIG_BLOCK, &ens_sigtstp, NULL);
                    redirection(l->in, l->out);
                    execvp(l->seq[token][0],l->seq[token]);
                    fprintf(stdout , ROU "Commande non reconnue.\n" RST);
                    freeall(listedesjobs, l);
                    exit(EXIT_FAILURE);
                }
                else {

                    if (token != 0){
                        close(pipep[0]);
                        close(pipep[1]);
                    }

                    if (l->seq[token+1] != NULL){
                        pipep[0]=pipeq[0];
                        pipep[1]=pipeq[1];
                    }

                    fprintf(stdout, JAU "Processus de pid " RST);
                    fprintf(stdout, BLC "%d " RST, pidFils);
                    fprintf(stdout, JAU "commence en " RST);
                    fprintf(stdout, VER "%s.\n" RST, l->backgrounded ? "tâche de fond" : "avant plan");
                    fprintf(stdout,RST "\n");

                    int etat = UNDEF;
                    if (l->backgrounded==NULL) {
                        etat=FG;
                        avant_plan=1;
                    }
                    else {
                        etat=BG;
                        avant_plan=0;
                    }
                    addjob(listedesjobs, pidFils, etat, l->seq[0]);
                    while(avant_plan!=0){
                        pause();
                    }
                }
                
            }
            token++;
        }
        if (taille>1){
            close(pipep[0]);
            close(pipep[1]);
        }
    }
}