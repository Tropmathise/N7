/* version 0.1 (PM, 12/5/19) :
	Le client de conversation
	- crée deux tubes (fifo) d'E/S, nommés par le nom du client, suffixés par _C2S/_S2C
	- demande sa connexion via le tube d'écoute du serveur (nom supposé connu),
		 en fournissant le pseudo choisi (max TAILLE_NOM caractère)
	- attend la réponse du serveur sur son tube _C2S
	- effectue une boucle : select sur clavier et S2C.
	- sort de la boucle si la saisie au clavier est "au revoir"
	Protocole
	- les échanges par les tubes se font par blocs de taille fixe TAILLE_MSG,
	- le texte émis via C2S est préfixé par "[pseudo] ", et tronqué à TAILLE_MSG caractères
Notes :
	-le  client de pseudo "fin" n'entre pas dans la boucle : il permet juste d'arrêter
		proprement la conversation.
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>

#define TAILLE_MSG 128				/* nb caractères message complet ([nom]+texte) */
#define TAILLE_NOM 25					/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */
#define NB_LIGNES 20
#define TAILLE_SAISIE 512		/* capacité du tampon pour les lignes saisies 
																 (hypothèse : pas de caractère de plus de 4 octets) */

char discussion[NB_LIGNES][TAILLE_MSG]; /* derniers messages reçus */


void afficher(int depart) { 
/* affiche les lignes de discussion[] en commençant par la plus ancienne (départ+1 % nbln)
  et en finissant par la plus récente (départ) */
    int i;
    system("clear");  /* nettoyage de l'affichage simple, à défaut d'être efficace (1) */
    printf("==============================(discussion)==============================\n");
    for (i=1; i<=NB_LIGNES; i++) {
        printf("%s\n", discussion[(depart+i)%NB_LIGNES]);
    }
    printf("------------------------------------------------------------------------\n");
}


/*Ferme les descripteurs de fichiers et les tubes utilisés */
void clean(int c2s, int s2c, int ecoute, char * tubec2s, char * tubes2c){
  close(c2s);
  close(s2c);
  close(ecoute);
  unlink(tubec2s);
  unlink(tubes2c);
}


int main (int argc, char *argv[]) {
  int nlus;
  //char *buf0;						/* pour parcourir le contenu reçu d'un tube */

  int ecoute, S2C, C2S;		/* descripteurs tubes de service*/
  int curseur = 0;				/* position (affichage) dernière ligne reçue et affichée */

  fd_set readfds;					/* ensemble de descripteurs écoutés par le select */

  char tubeC2S[TAILLE_NOM+5]; /* chemin tube de service client -> serveur = pseudo_c2s */
  char tubeS2C[TAILLE_NOM+5]; /* chemin tube de service serveur -> client = pseudo_s2c */
  char pseudo[TAILLE_NOM];
  char message[TAILLE_MSG];
  char saisie[TAILLE_SAISIE];	/* tampon recevant la ligne saisie au clavier */
	//char buf[TAILLE_RECEPTION];	/* tampon recevant les messages du tube s2c */

  if (!((argc == 2) && (strlen(argv[1]) < TAILLE_NOM*sizeof(char)))) {
    printf("utilisation : %s <pseudo>\n", argv[0]);
    printf("Le pseudo ne doit pas dépasser 25 caractères\n");
    exit(1);
  }


  /* ouverture du tube d'écoute */
  ecoute = open("./ecoute",O_WRONLY);
  if (ecoute==-1) {
    printf("Le serveur doit être lance, et depuis le meme repertoire que le client\n");
    exit(2);
  }

  /* Création des tubes de service */
  bzero(tubeC2S, TAILLE_NOM + 5);
  bzero(tubeS2C, TAILLE_NOM + 5);

  /* Création des tubes nommés*/
  strcpy(pseudo, argv[1]);

  strncpy(tubeC2S, pseudo, strlen(pseudo));
  strncpy(tubeS2C, pseudo, strlen(pseudo));

  strncat(tubeC2S, "_C2S", 4);
  strncat(tubeS2C, "_S2C", 4);    

  mkfifo(tubeS2C,S_IRUSR|S_IWUSR); //le client écrit dans ce tube
  mkfifo(tubeC2S,S_IRUSR|S_IWUSR);  //le client lit dans ce tube


  /* Demande de connexion : Ecriture du pseudo dans le tube d'écoute */
  write(ecoute, pseudo, strlen(pseudo));

    	
  if (strcmp(pseudo,"fin")!=0) { /* "console fin" provoque la terminaison du serveur */

    C2S = open(tubeC2S, O_WRONLY);
    S2C = open(tubeS2C, O_RDONLY);

        /* initialisations (à faire) */
        /* ouverture des tubes de service seulement ici  car il faut que la connexion 
          au serveur ait eu lieu pour qu'il puisse effectuer l'ouverture des tubes de service
          de son côté, et ainsi permettre au client d'ouvrir les tubes sans être bloqué */

    bzero(saisie, TAILLE_SAISIE);
    bzero(message, TAILLE_MSG);

    while (strcmp(saisie,"au revoir")!=0) {
              /* boucle principale (à faire) :
                  * récupérer les messages reçus éventuels, puis les afficher.
                  - tous les messages comportent TAILLE_MSG caractères, et les constantes
                    sont fixées pour qu'il n'y ait pas de message tronqué, ce qui serait
                    pénible à gérer.
                  - lors de l'affichage, penser à effacer les lignes avant de les affecter
                    pour éviter l'affichages de caractères parasites si l'ancienne ligne est
                    plus longue que la nouvelle.
                  * récupérer la ligne saisie éventuelle, puis l'envoyer
              */
      /*Initialiser et remplir l'ensemble de descripteurs */
          
      FD_ZERO(&readfds);
      FD_SET(0, &readfds);
      FD_SET(S2C, &readfds);

      /*Vérifier si il y a des données à lire sur les descripteurs*/
      nlus = select(NBDESC,&readfds,NULL, NULL, NULL);
      if (nlus < 0){
        perror("select");
        exit(3);
      } else {

        if (FD_ISSET(S2C, &readfds)) {

          /*Récupération et affichage des donnees du serveur*/
          read(S2C, message, TAILLE_MSG);

          /* MAJ et affichage de la discussion*/
          strcpy(discussion[(curseur+1)%NB_LIGNES], message);
          curseur++;
          afficher(curseur);

          /* Fin ? */
          if(strcmp(message, "Fermeture du serveur.") == 0){
            clean(C2S, S2C, ecoute, tubeC2S, tubeS2C);
            exit(0);
          }
          bzero(message, TAILLE_MSG);
        }

        if (FD_ISSET(0, &readfds)){

        /*Lecture du clavier et écriture dans le tube C2S*/
        bzero(saisie, TAILLE_MSG);
        read(0, saisie, TAILLE_MSG);
        saisie[strlen(saisie)-1]= '\0';

        if(strcmp(saisie, "au revoir") !=0 )
          write(C2S, saisie, TAILLE_MSG);
        }

      }
    }

  }

  /* Nettoyage des tubes de service (à faire) */
  if(strcmp(saisie, "au revoir") == 0){
    write(C2S, "au revoir", TAILLE_MSG);
    clean(C2S, S2C, ecoute, tubeC2S, tubeS2C);
  }

  printf("Fin client\n");
  exit (0);

}

/* Note
 * (1) :	Pour éviter un appel de system() à chaque affichage, une solution serait,
					à l'initialisation du main(), d'appeler system("clear > nettoie"), pour récupérer
					la séquence spécifique au terminal du client permettant d'effacer l'affichage, 
          puis d'ouvrir nettoie en écriture, pour en écrire le contenu à chaque affichage.
          Cependant, le surcoût n'est pas vraiment critique ici pour l'application.
          Le principe (donné dans le sujet) est que tous les processus ouvrent les tubes
          dans le même ordre, pour éviter un interblocage (méthode des classes ordonnées).
 */
