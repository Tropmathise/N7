/* version 0.2 (PM, 12/5/19) :
	La discussion est un tableau de messages, couplé en mémoire partagée.
	Un message comporte un auteur, un texte et un numéro d'ordre (croissant).
	Le numéro d'ordre permet à chaque participant de détecter si la discussion a évolué
	depuis la dernière fois qu'il l'a affichée.
	La discussion est couplée à un fichier dont le nom est fourni en premier argument
	de la commande, le second étant le pseudo du participant.
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h> /* définit mmap  */
#include <signal.h>

#define TAILLE_AUTEUR 25
#define TAILLE_TEXTE 128
#define NB_LIGNES 20

void ecrire_saisie();

/* message : numéro d'ordre, auteur (25 caractères max), texte (128 caractères max) */
struct message {
    int numero;
    char auteur[TAILLE_AUTEUR];
    char texte[TAILLE_TEXTE];
};

/* discussion (20 derniers messages) (la mémoire nécessaire est allouée via mmap(-)) */
struct message * discussion;

/* dernier message en position 0 */
int dernier0 = 0 ;

/* afficher la discussion */
void afficher() {
    int i;
    system("clear");  /* nettoyage de l'affichage simple, à défaut d'être efficace */
    printf("==============================(discussion)==============================\n");
    for (i=1; i<NB_LIGNES; i++) {
        printf("[%s] : %s\n", discussion[i].auteur, discussion[i].texte);
    }
    printf("------------------------------------------------------------------------\n");
}

/* traitant : rafraichir la discussion, s'il y a lieu, toutes les secondes */
void traitant (int sig) {
	int i, tmp;

    tmp = dernier0;
    for(i=0; i<NB_LIGNES; i++){
        if (discussion[i].numero > dernier0)
            dernier0 = discussion[i].numero;
    }

    if (dernier0 > tmp)
        afficher(dernier0);

    signal(SIGALRM, traitant);
    alarm(1);
}



int main (int argc, char *argv[]) {
  struct message m;
  int taille,fdisc;
  char qq [1];
  //FILE * fdf;

  if (argc != 3) {
    printf("usage: %s <discussion> <participant>\n", argv[0]);
    exit(1);
  }
  
  /* ouvrir et coupler discussion */
  if ((fdisc = open (argv[1], O_RDWR | O_CREAT, 0666)) == -1) {
    printf("erreur ouverture discussion\n");
    exit(2);
  }

  /*	mmap ne spécifie pas quel est le resultat d'une ecriture *apres* la fin d'un fichier
  couple (SIGBUS est une possibilite, frequente). Il faut donc fixer la taille du fichier
  destination à la taille du fichier source avant le couplage. Le plus simple serait
  d'utiliser truncate, mais ici on prefere lseek(a la taille du fichier source) + write
  d'un octet, qui sont deja connus des etudiants */

  qq[0]='x';
  taille = sizeof(struct message)*NB_LIGNES;
  lseek (fdisc, taille, SEEK_SET);
  write (fdisc, qq, 1);


 	/* TO DO : 
 			- couplage et initialisations
 			- boucle : lire une ligne au clavier, décaler la discussion d'une ligne vers le haut
       et insérer la ligne sasie en fin. 
      - Note : le rafraîchissement peut être géré par un traitant.
  */

  /* Gestion de la discussion et de la saisie des msg*/


  /*Initialiser les infos de l'utilisateur r*/
  bzero(m.auteur, TAILLE_AUTEUR);
  strncpy(m.auteur, argv[2], strlen(argv[2]));


  /* Pour avoir un accès partagé en lecture/ecriture
  on couple une zone mémoire de taille "taille" avec le fichier de la discussion*/
  discussion = mmap(NULL, taille, PROT_READ | PROT_WRITE, MAP_SHARED, fdisc, 0);

  /* --> Lecture au clavier non bloquante */
  fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);

  /*S'abonner au traitant de SIGALRM */
  signal(SIGALRM, traitant);

  /* Ecrire un msg par défaut a la connexion */
  bzero(m.texte, TAILLE_TEXTE);
  strncpy(m.texte, m.auteur, strlen(m.auteur));
  strncat(m.texte, " a rejoint la conversation", 26);
  ecrire_saisie(m.texte, "service");
  bzero(m.texte, TAILLE_TEXTE);

  alarm(1);

  while(strcmp(m.texte, "au revoir") != 0){

    /*Lire la m.texte de l'user*/
    if(read(0, m.texte, TAILLE_TEXTE) > 0){
      m.texte[strlen(m.texte)-1] = '\0';
    
    /*Ecrire le message dans la discussion*/
    ecrire_saisie(m.texte, m.auteur);
    bzero(m.texte, TAILLE_TEXTE);

    /* MAJ de le dicussion*/
    kill(getpid(), SIGALRM);
      
    }
  }


  /* ====== Deconnexion ====== */

  /*Ecrire un msg par defaut a la deconnexion */
  bzero(m.texte, TAILLE_TEXTE);
  strncpy(m.texte, m.auteur, strlen(m.auteur));
  strncat(m.texte, " a quitté la conversation", 26);
  ecrire_saisie(m.texte, "service");
  bzero(m.texte, TAILLE_TEXTE);

  /* MAJ de la discussion */
  kill(getpid(), SIGALRM);

  /*Decoupler la zone mémoire utilisée par le fichier de discussion*/
  munmap(discussion, NB_LIGNES*TAILLE_TEXTE*sizeof(char));

  /*Fermer le descripteur de fichier utilisé*/
  close(fdisc);
  exit(0);

}



/*Ecrire un message dans la discussion*/
void ecrire_saisie(char * message, char * pseudo){
  int i;

  /*Determiner le numero du message le plus récent*/
  for(i=0;i<NB_LIGNES;i++){
    if(discussion[i].numero > dernier0){
      dernier0 = discussion[i].numero;
    }
  }
  
  /*Ecrire le message avec numero = dernier0 + 1*/
  bzero(discussion[(dernier0 + 1)%NB_LIGNES].texte, TAILLE_TEXTE);
  bzero(discussion[(dernier0 + 1)%NB_LIGNES].auteur, TAILLE_AUTEUR);  
  discussion[(dernier0 + 1)% NB_LIGNES].numero = dernier0 + 1;
  strncpy(discussion[(dernier0 + 1)% NB_LIGNES].auteur, pseudo, strlen(pseudo));
  strncpy(discussion[(dernier0 + 1)% NB_LIGNES].texte, message, strlen(message));

}