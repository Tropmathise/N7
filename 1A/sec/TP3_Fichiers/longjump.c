/* acquisition avec attente bornŽe [PM, le 09/04/13] 
 *
 * interface setjmp/longjmp, selon les implŽmentations,
 * la sauvegarde/restauration  du masque de signaux est rŽalisŽe ou pas
 *
 */

#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <setjmp.h>

int ret;
jmp_buf env;

int nbacqs = 0;

void abandon (int n)
{
	printf("acquisition abandonnŽe\n");
	longjmp(env, 1);
}

int  main()
{
    int i=0;
    signal(SIGALRM, abandon);
    printf("numero de processus %d\n", getpid()); 
    for(;;){
		ret = setjmp(env);
		if (ret==0) {
			alarm(5);
			i++;
			printf("traitement %d ; nbacqs %d", i, nbacqs); 
			sleep(i%7);
			printf("acquisition normale\n");
			nbacqs++;
		}			
	}
	return 0;
}