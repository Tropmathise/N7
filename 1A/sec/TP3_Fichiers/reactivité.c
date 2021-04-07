/* acquisition avec attente bornŽe [PM, le 11/03/15] 
 *
 * version pro : attente alŽatoire + dŽlai paramŽtrŽ (timers) + tirage alŽatoire
 *
 */

#include <signal.h>
#include <stdlib.h>     /* pour random */
#include <stdio.h>
#include <unistd.h>
#include <setjmp.h>
#include <sys/time.h>   /* pour le gŽnŽrateur alŽatoire et les timers*/

#define EOL '\n'

jmp_buf env;
struct itimerval duree, raz;

int nbacqs = 0;
int nbTests = 0;
int nbMicros = 0;
int errone = 0;

void perdu (int n) {
	printf("trop tard !\n");
	errone++;
	siglongjmp(env, 2);
}

int  main(int argc, char*argv[]) {
	int nb=0;
	int rep;
	int ret;
	if (argc == 3) { 
		sscanf(argv[1], "%d", &nbTests);
		sscanf(argv[2], "%d", &nbMicros);
	}
	if (nbTests*nbMicros <= 0) {
		printf("usage : %s nbTests delai (en microsec) \n", argv[0]);
		printf("execution avec les valeurs par defaut \n");
		nbTests = 10;
		nbMicros=2000000;
	}
	printf("execution de %d tests ; temps de reponse : %d microsec \n", nbTests, nbMicros);		
	srandom (time(NULL));
	duree.it_value.tv_sec = nbMicros/1000000;
	duree.it_value.tv_usec = nbMicros%1000000;
	duree.it_interval.tv_sec = 0;
	duree.it_interval.tv_usec = 0;
	raz.it_value.tv_sec = 0;
	raz.it_value.tv_usec = 0;
	raz.it_interval.tv_sec = 0;
	raz.it_interval.tv_usec = 0;

	
    signal(SIGALRM, perdu);
    for(int i=0;i<nbTests;i++) {
		/*  dŽsarmer l'horloge avant la mise en sommeil pour Žviter
		 *	qu'un SIGALRM antŽrieur  ne soit transmis durant le sleep
		 */
		setitimer(ITIMER_REAL, &raz, NULL); 
		sleep((random()%5)+1);
		ret = sigsetjmp(env,1); //1 (­0) -> sauvegarder le masque de signaux
		if (ret==0) {
			nb = random()%10;
			rep=nb+1;
			printf("Go ! (%d) -> %d\n", i, nb); 
			setitimer(ITIMER_REAL, &duree, NULL);  /* armement du timer temps-reel */
			while (((ret=scanf("%d",&rep)) != 1)||(nb!=rep)) { //le court circuit est dans la norme
				errone++;
				if (ret != 1) while (getchar()!=EOL) { /* purger le tampon d'entrŽe */;}
			} 
			printf("bravo !\n");
			nbacqs++;
		}			
	} 
	printf("C'est fini ! Score : %d/%d [%d hors delai]", nbacqs, nbTests, errone); 
	return 0;
}