#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>  

// dormir durant n secondes : n fournie en argument
// sinon n=5 par défault
int main(int argc, char* argv[])
{
    int delai = 5;
    if (argc > 1 ) {
        delai = atoi(argv[1]);
    }
    printf("\n      - Processus %d va dormir durant %d secondes\n", getpid(), delai);
    sleep(delai);
	fflush(stdout);
    return 0;
}
