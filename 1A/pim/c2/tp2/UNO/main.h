#ifndef MAIN_H
#define MAIN_H

#include "carte.h"
#include "jeu.h"
extern char C[4];
#include <stdbool.h>

//Définition du type t_main, capable d'enregistrer un nombre variable de cartes.
struct main {
    carte * main; //tableau des cartes dans la main. 
    int nb; //monbre de cartes
};
typedef struct main t_main;

/**
 * \brief Initialiser une main.
 * \param[in] N nombre de cartes composant la main.  Précondition : N <= (NB_CARTES - 1) div 2
 * \param[out] la_main créée
 * \return true si l'initialisation a échouée.
 */
bool init_main(t_main* la_main, int N);


/**
 * \brief Afficher une main.
 * \param[in] la_main la main a afficher
 */
void afficher_main(t_main la_main);

/**
 \brief Distribuer N cartes à chacun des deux joueurs, en alternant les joueurs.
 * \param[in out] le_jeu complet.
 *       Si la carte c est distribuée dans une main, c.presente devient faux.
 * \param[in] N nombre de cartes distribuées à chaque joueur.  Précondition : N <= (NB_CARTES - 1) div 2
 * \param[out] m1 main du joueur 1.
 * \param[out] m2 main du joueur 2.
 */
void distribuer_mains(jeu le_jeu, int N, t_main* m1, t_main* m2);

/**
 * \brief Vérifie si la carte c est présente dans la main.
 * \param[in] main main d'un joueur
 * \param[in] c carte
 * \return bool Vrai si la carte est presente dans la main, faux sinon.
*/
bool est_presente_main(t_main main, carte c);

/**
 * \brief Piocher une carte dans le jeu et l'inclure dans la main en paramètre.
 * \param[in out] le_jeu complet avec les 4 couleurs et 10 valeurs possibles.
 *                Ce jeu est mélangé.
 *                Si la carte est inclue dans une main ou est la derniere carte jouée,
 *                Alors presente vaut faux.
 * \param[in out] main main d'un joueur
 * \return carte* un pointeur sur la carte piochee dans le_jeu en paramètre. Ce pointeur vaut NULL si aucune carte ne peut être piochée.
*/
carte * piocher(jeu le_jeu, t_main* main);

#endif