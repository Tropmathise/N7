#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/* Afficher le pgcd de deux entiers strictement positifs. */
int main() {
    // Déclaration et initialisation de deux entiers
    int a = 105,b = 35;   
    
    // Déterminer le pgcd de a et b
    int na = a, nb = b;  // gain de place ! À éviter !
    while (na != nb) {	// na et nb différents
        // Soustraire au plus grand le plus petit
        if (na > nb) {
            na = na - nb;
        } else  {
            nb = nb - na;
        }
    }
    int pgcd = na;     // le pgcd de a et b
    
    // Afficher le pgcd
    printf("Le pgcd de %d et %d est %d\n", a, b , pgcd);
    return EXIT_SUCCESS;
}
