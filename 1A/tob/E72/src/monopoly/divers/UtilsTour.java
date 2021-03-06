package monopoly.divers;

import java.util.ArrayList;

import monopoly.cases.*;
import monopoly.swing.*;

/** Classe de fonctions utiles à la Classe Tour 
 * @author Theo, Jules, Thomas
 */

public class UtilsTour {

    /* Faire avancer le joueur */
    public static void avancerDe(JoueurMonopoly joueur, Integer valeur) {
        System.out.println();
        System.out.println(joueur.getNom() + " veut se déplacer de " + valeur + " case(s).");
        assert(valeur > 0 && valeur <= Des.max);
        if (valeur + joueur.getPosition().id > Plateau.nbCases) {
            System.out.println(joueur.getNom() + " passe par la case départ, il reçoit " + Partie.argentTour + " euros.");
            new Annonce(joueur.getNom() + " passe par la case départ, il reçoit " + Partie.argentTour + " euros.");
            joueur.ajouterArgent(Partie.argentTour);
            joueur.setNbTourDePlateau(joueur.getNbToursPlateau() + 1);
        }
        else if (valeur + joueur.getPosition().id == 0) {
            System.out.println(joueur.getNom() + " s'arrete sur la case départ, il reçoit " + 2*Partie.argentTour + " euros.");
            new Annonce(joueur.getNom() + " s'arrete sur la case départ, il reçoit " + 2*Partie.argentTour + " euros.");
            joueur.ajouterArgent(2*Partie.argentTour);
            joueur.setNbTourDePlateau(joueur.getNbToursPlateau() + 1);
        }
        Case caseArrivee = Plateau.cases[ (joueur.getPosition().id + valeur) % Plateau.nbCases ];
        joueur.setPosition(caseArrivee);
        System.out.println(joueur.getNom() + " s'est déplacé jusqu'à " + caseArrivee.getNom() + ".");
        new Annonce(joueur.getNom()+ " avance de " + valeur + " cases.");
        try{
            resoudreEffetCase(joueur, joueur.getPosition());
        }
        catch(ImpayableException exception){
            System.out.println("impayable exception : les impots ne sont pas payables.");
        }
    }

    /* Acheter une propriété */
    public static void acheterPropriete(JoueurMonopoly joueur, Case c) throws ImpayableException {
        System.out.println();
        System.out.println(joueur.getNom() + " veut acheter " + c.getNom() + ".");
        assert(c instanceof CaseAchetable);
        if (joueur.getSolde() < ((CaseAchetable) c).getPrix()) {
            System.out.println(joueur.getNom() + " n'a pas assez d'argent pour acheter " + c.getNom() + ".");
            //new Annonce(joueur.getNom() + " n'a pas assez d'argent pour acheter " + c.getNom() + ".");
            throw new ImpayableException("pas assez d'argent");
        }
        else {
            try {
                JoueurMonopoly prop = ((CaseAchetable) c).getProp();
                System.out.println(c.getNom() + " est déjà possédée par " + prop.getNom() + ".");
                new Annonce(c.getNom() + " est déjà possédée par " + prop.getNom() + ".");
            }
            catch (NullPointerException e) {
                joueur.retirerArgent(((CaseAchetable) c).getPrix());
                joueur.ajouterTerrain(c);
                ((CaseAchetable) c).setProp(joueur);
                System.out.println(joueur.getNom() + " est le propriétaire de " + c.getNom() + ".");
                new Annonce(joueur.getNom()+ " a acheté " + joueur.getPosition().getNom());
            }
        }
    }

    /* Piocher une carte dans le tas */
    public static Carte piocherCarte(JoueurMonopoly joueur){
        System.out.println();
        System.out.println(joueur.getNom() + " veut piocher une carte.");
        // initilisation de la carte
        Carte carte_piochee = new Carte(joueur.getPosition().getId(),TypeCarte.PAYER, 0, "carte initialisée");
        // s'il le joueur est sur la case Chance 
        if (joueur.getPosition().getType() == TypeCase.CHANCE){
            carte_piochee = Plateau.cartesChances.piocher();
            System.out.println(joueur.getNom() + " a pioché une carte CHANCE.");
        }
        // s'il le joueur est sur la case Chance
        else {
            carte_piochee = Plateau.cartesCdC.piocher();
            System.out.println(joueur.getNom() + " a pioché une carte CdC.");
        }
        return carte_piochee;
    }

    /* Résoudre l'effet d'une case */
    public static void resoudreEffetCase(JoueurMonopoly joueur, Case c) throws ImpayableException {
    	switch (c.getType()) {
        case PAIEMENT : joueur.retirerArgent(((CasePaiement) c).getPrix());
            new Annonce("Vous avez été débité de "+ ((CasePaiement) c).getPrix() + " euros.");
    		break;
    	/*case CHANCE : Carte carteChance = Plateau.cartesChances.piocher();
    		carteChance.getEffet(joueur); 
    		break;
    	case CDC : Carte carteCdC = Plateau.cartesCdC.piocher();
    		carteCdC.getEffet(joueur);
    		break;*/
    	case PARC : joueur.ajouterArgent(Plateau.getTasArgent());
    		Plateau.setTasArgent(0);
    		break;
    	case DEPART : joueur.ajouterArgent(Partie.argentTour);
    		break;
    	case GOPRISON : joueur.setPosition(Plateau.cases[10]);
    		joueur.setEstEnPrison(true);
    		default : ;
    	}
    }

    /** Quelqu'un a gagné ?
     * @param joueurs la liste des joueurs
     * @return Booleen : un joueur a gagné
     */
    public static Boolean gagnantExiste(ArrayList<JoueurMonopoly> joueurs) {
        Integer compteur = 0;
        for (int i = 0; i < joueurs.size(); i++) {
            if (!joueurs.get(i).getAPerdu()) {
                compteur++;
            }
        }
        return compteur <= 1;
    }

    public static void construire(JoueurMonopoly joueur, Propriete c) throws ImpayableException{
        Integer prix = c.getPrixMaison();
        Integer solde = joueur.getSolde();
        Integer nbConstru = c.getConstruction();
        if (prix < solde && nbConstru < 5) {
            joueur.setSolde(solde - prix);
            c.setConstruction(nbConstru + 1);
        }
        else if (nbConstru >= 5) {}
        else {
            throw new ImpayableException();
        }
    }
    
}