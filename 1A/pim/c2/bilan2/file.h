/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.h
 * 
 *  Objectifs :
 *	.  D�finition et utilisation des modules
 *	.  Allocation dynamique de m�moire
 */
#ifndef FILE_H
#define FILE_H

#include <stdbool.h>

struct Cellule {
    char valeur;
    struct Cellule *suivante;
};
typedef struct Cellule Cellule;

struct File {
    Cellule *tete;
    Cellule *queue;
    /** Invariant :
      *	 file vide :	tete == NULL && queue == NULL
      */
};
typedef struct File File;


/**
 * Initialiser la file \a f.
 * La file est vide.
 *
 * Assure
 *	est_vide(*f);
 */
void initialiser(File *f);

/**
 * D�truire la file \a f.
 * Elle ne pourra plus �tre utilis�e (sauf � �tre de nouveau initialis�e)
 */
void detruire(File *f);

/**
 * L'�l�ment en t�te de la file.
 * N�cessite :
 *	! est_vide(f);
 */
char tete(File f);

/**
 * Ajouter dans la file \a f l'�l�ment \a v.
 *
 * N�cessite :
 *	f != NULL;
 */
void inserer(File *f, char v);

/**
 * Extraire l'�l�ment \a v en t�te de la file \a f.
 * N�cessite
 *	f != NULL;
 *	! est_vide(*f);
 */
void extraire(File *f, char *v);

/**
 * Est-ce que la file \a f  est vide ?
 */
bool est_vide(File f);

/**
 * Obtenir la longueur de la file.
 */
int longueur(File f);

#endif