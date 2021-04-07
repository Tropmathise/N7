#include <stdio.h>
#include "compteur.h"

int compteur = 0;

void re_initialiser() {
	compteur=0;
}
void incrementer() {
	compteur++;
}
int valeur() {
	return compteur;
}
