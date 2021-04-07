package monopoly.divers;

/** La classe qui gére le systéme de pioche/défausse
 * @author Jules
 */

import java.io.IOException;
import java.util.*;

public class TasCartes {

    private Carte[] tas;
    private Integer taille;
    
    /** Constructeur de la classe
     * @param fichier : fichier texte qui répertorie les cartes
     * @param nb_cartes : nombre de carte du paquet
     */
    public TasCartes(String fichier, Integer nb_cartes) {
        this.taille = nb_cartes;
        this.tas = new Carte[nb_cartes];
        try {
            String[] donnees = Fichier.Lecture(fichier, 16);
            for(int i = 0; i < 16; i++) {
                String[] donneeCarte = donnees[i].split("@");
                tas[i] = new Carte(Integer.parseInt(donneeCarte[0]), TypeCarte.fromString(donneeCarte[1]), Integer.parseInt(donneeCarte[2]), StringPerso.creer(donneeCarte[3]));
            }
            //mélange du paquet de cartes
            List<Carte> carteList = Arrays.asList(tas);
    		Collections.shuffle(carteList);
    		carteList.toArray(tas);    
        }
        catch(IOException e) {
            System.out.println("Partie.java IOException. " + e.getMessage());
        }
        catch(NumberFormatException e) {
            System.out.println("Partie.java FORMAT. " + e.getMessage());
        }
    }
    
    /** Obtenir le tableau contenant toutes les cartes
     * @return le tableau des cartes présentes dans le jeu : pioche + défausse
     */
    public Carte[] getTab() {
    	return this.tas;
    }
    
    /** Obetnir le nombre de cartes restantes dans la pioche
     * @return la taille de la pioche
     */
    public Integer getTaille() {
    	return this.taille;
    }
    
    /** Effectuer le mélange des cartes de la défausse lorsque la pioche est vide
     */
    private void melanger() {
    	this.taille = 16;
        List<Carte> carteList = Arrays.asList(this.tas);
		Collections.shuffle(carteList);
		carteList.toArray(this.tas);    
    }
    
    /** Piocher une carte (avec mélange préalable si la pioche est vide
     * @return la carte piochée
     */
    public Carte piocher() {
    	if (this.taille == 0) {
    		this.melanger();
    	}
    	this.taille = this.taille - 1;
    	return this.tas[this.taille];
    }
    
}
