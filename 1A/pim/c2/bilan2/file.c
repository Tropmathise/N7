/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des op�rations de la file
*/

#include <malloc.h>
#include <assert.h>

#include "file.h"


void initialiser(File *f)
{
    f->queue=NULL;
    f->tete=NULL;
    assert(est_vide(*f));
}


void detruire(File *f)
{
    free(f->queue);
    free(f->tete);
    f->queue=NULL;
    f->tete=NULL;
}


char tete(File f)
{
    assert(! est_vide(f));
    return f.tete->valeur;
}


bool est_vide(File f)
{
    return f.tete = NULL;
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule *nv_cellule;
    nv_cellule->suivante=malloc(sizeof(suivante));
    nv_cellule->valeur=malloc(50*sizeof(char));
    nv_cellule->suivante=suivante;
    nv_cellule->valeur=valeur;
    return nv_cellule;
}


void inserer(File *f, char v)
{
    assert(f != NULL);
    Cellule *nv_cellule = cellule(v, NULL);
    f->queue=nv_cellule;
    // TODO
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));

    // TODO
}


int longueur(File f)
{
    // TODO
    return 0;
}
