/* version 0.2 (PM, 13/5/19) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : select
		* tube d'écoute : accepter le(s) nouveau(x) participant(s) si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis
		* tubes (fifo) de service en entrée -> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine à la connexion d'un client de pseudo "fin"
	Protocole
	- suppose que les clients ont créé les tube d'entrée/sortie avant
		la demande de connexion, nommés par le nom du client, suffixés par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/select.h>
#include <stdbool.h>
#include <sys/stat.h>

#define MAXPARTICIPANTS 5			/* seuil au delà duquel la prise en compte de nouvelles
								 						 	   connexions sera différée */
#define TAILLE_MSG 128				/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25					/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */

typedef struct ptp { 					/* descripteur de participant */
    bool actif;
    char nom[TAILLE_NOM];
    int in;		/* tube d'entrée (C2S) */
    int out;	/* tube de sortie (S2C) */
} participant;

participant participants[MAXPARTICIPANTS];

char buf[TAILLE_RECEPTION]; 	/* tampon de messages reçus/à rediffuser */
int nbactifs = 0;

bool serveur_actif = true;	


void effacer(int i) { /* efface le descripteur pour le participant i */
    participants[i].actif = false;
    bzero(participants[i].nom, TAILLE_NOM*sizeof(char));
    participants[i].in = -1;
    participants[i].out = -1;
}



void diffuser(char *dep) { /* envoi du message référencé par dep à tous les actifs */
 	for(int i=0; i<=nbactifs; i++){
	    write(participants[i].out, dep, strlen(dep));
	}
}


void desactiver (int p) { /* traitement d'un participant déconnecté (à faire) */
	
	int i;

  /*Effacer la case p*/
  close(participants[p].in);
  close(participants[p].out);  

  effacer(p);

  /*Décalage du tableau de participants*/
  for(i=p; i<nbactifs-1; i++){
   	participants[i] = participants[i+1];
  }

  if (nbactifs > 1)
   	effacer(nbactifs - 1);

  nbactifs--;
}


void fermer_serveur (int descripteur_ecoute){  /* Gère la fermeture du serveur proprement */

	/*Diffuse un message de fermeture */
	diffuser("Fermeture du serveur.");
  	
  /*Effacer tous les participants*/
  for(int i=0; i<nbactifs;i++){
  	effacer(i);
  }

  /*Fermer le descripteur d'écoute et supprimer le tube nommé*/
  close(descripteur_ecoute);
  unlink("./ecoute");

  /*Fermer les tubes de service*/
  unlink("fin_C2S");
  unlink("fin_S2C");
}



void ajouter(char *dep) { // traite la demande de connexion du pseudo référencé par dep
/*  Si le participant est "fin", termine le serveur (et gère la terminaison proprement)
	Sinon, ajoute le participant de pseudo référencé par dep
	(à faire)
*/
	
	if (strcmp(dep, "fin") == 0) { /* Si le participant est "fin", termine le serveur*/
		serveur_actif = false;
	} else {  /* ajoute le participant de pseudo référencé par dep */
		/*Initialisation des tubes de service*/
		char dep2[TAILLE_NOM];
	  bzero(dep2, TAILLE_NOM);

	  strcpy(participants[nbactifs].nom, dep);

	  strcpy(dep2, dep);
	  strncat(dep,"_C2S",4);
	  strncat(dep2,"_S2C",4);

	  /* Ajout dans le tableau des participants*/
	  participants[nbactifs].actif = true;  
	  participants[nbactifs].in = open(dep, O_RDONLY);
	  participants[nbactifs].out = open(dep2, O_WRONLY);
	  nbactifs++;
 	}
}


void affichage_msg(int i_user, char * buffer, char * pseudo){ /* Mise en forme de l'affichage du msg sur le terminale et l'écrit dans le buffer*/
  bzero(buffer, TAILLE_RECEPTION);
  strncpy(buffer, "[", 1);
  strncat(buffer, pseudo, strlen(pseudo));
  strncat(buffer, "]", 1);
  strncat(buffer, buf, strlen(buf));

}

/*Créer un message de connexion sous la forme " [service]pseudo rejoint la conversation"
 * le résultat est écrit dans buffer*/
void affichage_msg_connexion(char * buffer){
  char buf_cpy[TAILLE_RECEPTION];
  bzero(buf_cpy, TAILLE_RECEPTION);
  
  strcpy(buf_cpy, buf);

  /* Le nom de l'utilisateur est ajouter dans le buf dans la conversation*/
  ajouter(buf);

  /*Création du msg*/
  bzero(buffer, TAILLE_RECEPTION);
  strcpy(buffer, "[service]");
  strncat(buffer,strncat(buf_cpy," rejoint la conversation", 24), strlen(buf_cpy)+24);

}

void affichage_msg_deconnexion(int i, char * buffer){
  /*Création du msg*/
  bzero(buffer, TAILLE_RECEPTION);
  strcpy(buffer, "[service]");
  strncat(buffer,strncat(participants[i].nom," quitte la conversation", 26), strlen(participants[i].nom)+26);

}



int main (int argc, char *argv[]) {
  int i, res;
  int ecoute;					/* descripteur d'écoute */
  fd_set readfds; 		/* ensemble de descripteurs écoutés par le select */
  //char * buf0; 				/* pour parcourir le contenu du tampon de réception */
  //char bufDemandes [TAILLE_NOM*sizeof(char)*MAXPARTICIPANTS]; /* tampon requêtes de connexion. Inutile de lire plus de MAXPARTICIPANTS requêtes */

  char pre_message[TAILLE_RECEPTION], pseudo[TAILLE_RECEPTION]; 

  /* création (puis ouverture) du tube d'écoute */
  mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
  ecoute=open("./ecoute",O_RDONLY);

  for (i=0; i<= MAXPARTICIPANTS; i++) {
   	effacer(i);
  }


  while ((serveur_actif) ) {

    printf("Participants actifs : %d\n",nbactifs);

	 /* boucle du serveur : traiter les requêtes en attente 
				 * sur le tube d'écoute : lorsqu'il y a moins de MAXPARTICIPANTS actifs.
				 	ajouter de nouveaux participants et les tubes d'entrée.			  
				 * sur les tubes de service : lire les messages sur les tubes c2s, et les diffuser.
				   Note : tous les messages comportent TAILLE_MSG caractères, et les constantes
           sont fixées pour qu'il n'y ait pas de message tronqué, ce qui serait  pénible 
           à gérer. Enfin, on ne traite pas plus de TAILLE_RECEPTION/TAILLE_MSG*sizeof(char)
           à chaque fois.
           - dans le cas où la terminaison d'un participant est détectée, gérer sa déconnexion
			(à faire) */
	


	 /* boucle du serveur : traiter les requetes en attente */
	 /* --> Sur le tube d'ecoute et les tubes d'entree */

	 /* Initialisation de l'ensemble de descripteurs*/
	FD_ZERO(&readfds);


	if(nbactifs < MAXPARTICIPANTS){ //Ajoute le descripteur d'écoute s'il reste de la place dans le salon
		FD_SET(ecoute, &readfds);
	}
	
	 /* Ajouter tous les descripteurs associés à des participants actifs */
	for(i=0; i<nbactifs; i++){
	   if (participants[i].actif){
			FD_SET(participants[i].in, &readfds);
	  }
	}


	 /* Données à lire sur les tubes nommés ? */
	res = select(NBDESC, &readfds, NULL, NULL, NULL);
	printf("retour de select=%d\n",res);
	if (res < 0){
		perror("select()");
	   	exit(1);
	} else {

	   for(i=0; i<nbactifs; i++){
	      
	    if(FD_ISSET(participants[i].in, &readfds)){ // Données à lire en provenance des clients ?

	      /* Lire le message provenant du participant i*/
	      bzero(buf, TAILLE_RECEPTION);
	      bzero(pseudo, TAILLE_RECEPTION);
	      strncpy(pseudo, participants[i].nom, strlen(participants[i].nom));
	      //nlus = read(participants[i].in, buf, TAILLE_MSG);


	      if (strcmp(buf,"au revoir")==0){ /*Déconnecter le participant i */
					
					/*affichage_msg_deconnexion(i,pre_message);
					diffuser(pre_message); */
					desactiver(i);
					
				}			
				
				/*Diffuser le message à tous les participants */
				affichage_msg(i, pre_message, pseudo);
				diffuser(pre_message);  
	    }
	  
	   }  

	 	 /* Du nouveau sur le tube ecoute ? Nouveau User ? */
		 if (FD_ISSET(ecoute, &readfds)){ 

	     /* Lire les données sur ecoute*/
	     if (nbactifs <= MAXPARTICIPANTS){
	       /*Ajouter le participant à la conversation et diffuser le message de connexion */
	       /* --> Lecture du pseudo de l'utilisateur */
	       bzero(buf, TAILLE_RECEPTION);
	       read(ecoute, buf, TAILLE_RECEPTION);

	       if (strcmp(buf, "fin") != 0){ //Si ce n'est pas l'utilisateur 'fin', créer et diffuser le message de connexion
					 affichage_msg_connexion(pre_message);
					 diffuser(pre_message);
	       	} else {
						 serveur_actif = false;
					 }
	      }
	 	  }
		}
	}
    
	 fermer_serveur(ecoute);
	 exit(0);
}