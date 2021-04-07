#ifndef CARTE_H
#define CARTE_H

#define NB_VALEURS 10
#define NB_CARTES (4*NB_VALEURS)
extern char C[4];
#include <stdbool.h>

//Définition du type enseigne
enum couleur {JAUNE, ROUGE, VERT, BLEU};
typedef enum couleur couleur;


//Définition du type carte
struct carte {
    couleur couleur;
    int valeur; // Invariant : valeur >= 0 && valeur < NB_VALEURS
    bool presente; // la carte est-elle presente dans le jeu ?
};
typedef struct carte carte;

//Définition du type jeu complet pour enregistrer NB_CARTES cartes.
typedef carte jeu[NB_CARTES];

/**
 * \brief Initialiser une carte avec une couleur et une valeur. 
 * \param[in] c couleur de la carte
 * \param[in] v valeur de la carte
 * \param[in] ej booléen presente
 * \param[out] la_carte 
 */
void init_carte(carte* la_carte, couleur c, int v, bool pr);

/**
 * \brief Vérifie si la valeur de la carte est conforme à l'invariant.
 * \param[in] c la carte
 * \return bool vrai si la valeur est conforme, faux sinon.
 */
 bool est_conforme(carte c);

 /**
 * \brief Copie les valeurs de la carte src dans la carte dest.
 * \param[in] src carte à copier
 * \param[out] dest carte destination de la copie 
 */
void copier_carte(carte* dest, carte src);

/**
 * \brief Afficher une carte.
 * \param[in] cte carte à afficher
 */
void afficher_carte(carte cte);

/**
 * \brief Vérifie si les cartes c1 et c2 on la même couleur et la même valeur.
 * \param[in] c1 carte
 * \param[in] c2 carte
 * \return bool Vrai si les deux cartes ont même valeur et couleur.
*/
bool est_egale(carte c1, carte c2);

#endif