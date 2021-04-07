#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define CST 5

// Definition du type monnaie
struct Monnaie {
    float valeur;
    char devise;
};

typedef struct Monnaie Monnaie;
typedef Monnaie tab[CST];

/**
 * \brief Initialiser une monnaie 
 * \param[in out] monnaie à initialiser 
 * \param[in] valeur de la monnaie à initialiser 
 * \param[in] devise de la monnaie à initialiser 
 * \pre valeur>0
 */ 
void initialiser (Monnaie *monnaie, float valeur, char devise){
    assert (valeur>0);
    (*monnaie).valeur = valeur;
    (*monnaie).devise = devise;
}

/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in out] monnaie1: monnaie à modifier pour ajouter monnaie2
 * \param[in] monnaie2: monnaie à ajouter à monnaie1
 * \pre (*monnaie1).devise == monnaie2.devise)  les monaies doivent etre de même devise
 */ 
bool ajouter(Monnaie *monnaie1, Monnaie monnaie2){
	bool booleen = true;
    	//assert ((*monnaie1).devise == monnaie2.devise);
    	if ((*monnaie1).devise == monnaie2.devise) {
      	  	(*monnaie1).valeur+=monnaie2.valeur;
        	booleen = true;
        	//printf("%d : l'opération a été correctement efféctuée.", booleen);
    }
    	else {
        	booleen = false;
        	//printf("%d : l'opération n'a pas été effectuée, les deux devises ne sont pas les mêmes.", booleen);
    }
    	return booleen;
}

/**
 * \brief Tester Initialiser 
 * \param[]
 */ 
void tester_initialiser() {
	Monnaie m1,m2,m3,m4;
   	initialiser(&m1,5,'e');
 	initialiser(&m2,7,'e');
  	initialiser(&m3,12,'d');
    // tester si valeur négative
    // initialiser(&m4,-2,'d');
	assert(m3.valeur==12);	
	assert(m3.devise=='d');
	assert(m1.valeur==5);	
	assert(m1.devise=='e');
	assert(m2.valeur==7);	
	assert(m2.devise=='e');
}

/**
 * \brief Tester Ajouter 
 * \param[]
 */ 
void tester_ajouter() {
    	Monnaie m1,m2,m3;
    	initialiser(&m1,5,'e');
    	initialiser(&m2,7,'e');
    	initialiser(&m3,12,'d');
    	bool bool1=ajouter(&m1,m2);
    	assert (bool1);
    	bool bool2=ajouter(&m2,m3);
    	assert (! bool2);
    	bool bool3=ajouter(&m1,m3);
    	assert (! bool3);
}


int main(void) {
    // Déclarer un tableau de 5 monnaies
	tab porte_monnaie;
	float valeur;
	char devise;
	tester_ajouter();
	tester_initialiser();
    //Initialiser les monnaies
        for (int i=0; i<CST; i++){
        printf("Valeur et devise n°%d : ", i+1);
        scanf("%f %c", &valeur, &devise);
        initialiser(&porte_monnaie[i], valeur, devise);
    }
 
    // Afficher la somme de toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
	printf("Quelle monaie voulez-vous sommer? ");
	scanf(" %c", &devise);
	float sommeafficher;
	Monnaie somme;       				// initialisation de la monnaie qui servira à calculer la somme 
	initialiser(&somme, 1,devise); 			// initialisation à 1 car valeur>0
	for (int i=0; i<CST; i++){
		ajouter(&somme, porte_monnaie[i]);  	// on ajouter chaque valeur du porte monnaie, à condition que la devise soit la même
	}
	sommeafficher=somme.valeur-1;  //on retire le 1 initialisé 
	if (sommeafficher==0){
		printf("Vous n'avez pas de monnaie dans cette devise.\n");
	}
	else {
		printf("Vous avez %1.2f dans la devise %c.\n", sommeafficher, devise);
	}

    return EXIT_SUCCESS;
}
