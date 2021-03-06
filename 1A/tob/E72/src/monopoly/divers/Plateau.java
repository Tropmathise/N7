/** le plateau sur lequel se déplacent les joueurs 
 * @author Theo
 * @version 1.0
*/

package monopoly.divers;

import java.io.IOException;
//import java.util.ArrayList;

import monopoly.cases.*;


public class Plateau {

    public static final Integer nbCartes = 16;
    public static final Integer nbCases = 40;
    private static final Integer nbLoyers = 6;
    private static Integer tasArgent = 0;
    private static Integer nbTours = 0;
    public static final TasCartes cartesChances = new TasCartes("res/CartesChance.txt", nbCartes);
    public static final TasCartes cartesCdC = new TasCartes("res/CartesCdC.txt", nbCartes);
    public static final Case[] cases = initCases("res/Cases.txt");



    /** Obtenir la valeur du tas amassé.
     * @return Integer tasArgent
     */
    public static Integer getTasArgent() {
        return Plateau.tasArgent;
    }

    public static void ajouterTasArgent(Integer valeur) {
        Plateau.tasArgent += valeur;
    }

    /** Obtenir le nombre de tours.
     * @return Integer nbTours
     */
    public Integer getNbTour() {
        return Plateau.nbTours;
    }

    // public static Carte[] getChances() {
    //     return Plateau.cartesChances;
    // }

    // public static Carte[] getCdC() {
    //     return Plateau.cartesCdC;
    // }

    // public static Case[] getCases() {
    //     return Plateau.cases;
    // }

    /** Modifier le tas d'argent amassé.
     * 
     * @param nvTas
     */
    public static void setTasArgent(Integer nvTas) {
        Plateau.tasArgent = nvTas;
    }

    /** Initialiser les cases du plateau.
     * @param fichier le chemin du fichier
     * @return Array de cases
     */
    private static Case[] initCases(String fichier) {
        Case[] cases = new Case[nbCases];
        try {
            String[] donnees = Fichier.Lecture(fichier, nbCases);
            for(int i = 0; i < nbCases; i++) {
                String[] donneeCase = donnees[i].split("@");

                Integer[] loyer = new Integer[nbLoyers];
                donneeCase[2] = StringPerso.creer(donneeCase[2]);
                switch (donneeCase[1]) {
                    case "PROPRIETE":
                        String[] loyerstr = donneeCase[6].split(",");
                        for (int j = 0; j < nbLoyers; j++) {
                            loyer[j] = Integer.parseInt(loyerstr[j]);
                        }
                        cases[i] = new Propriete(Integer.parseInt(donneeCase[0]), TypeCase.fromString(donneeCase[1]),
                        donneeCase[2], donneeCase[3], Integer.parseInt(donneeCase[4]), null, Integer.parseInt(donneeCase[5]), loyer);
                        break;
                    case "GARE":
                        cases[i] = new Gare(Integer.parseInt(donneeCase[0]), TypeCase.fromString(donneeCase[1]),
                        donneeCase[2], donneeCase[3], Integer.parseInt(donneeCase[4]), null);
                        break;
                    case "COMPAGNIE":
                        cases[i] = new Compagnie(Integer.parseInt(donneeCase[0]), TypeCase.fromString(donneeCase[1]), donneeCase[2], donneeCase[3], Integer.parseInt(donneeCase[4]), null);
                        break;
                    case "CDC":
                    case "CHANCE":
                    case "PRISON":
                    case "GOPRISON":
                    case "PARC":
                    case "DEPART":
                        cases[i] = new Case(Integer.parseInt(donneeCase[0]), TypeCase.fromString(donneeCase[1]),
                        donneeCase[2], donneeCase[3]);
                        break;
                    case "PAIEMENT":
                        cases[i] = new CasePaiement(Integer.parseInt(donneeCase[0]), TypeCase.fromString(donneeCase[1]),
                        donneeCase[2], donneeCase[3], Integer.parseInt(donneeCase[4]));
                        break;
                    default:
                        System.out.println("Le type de case est inconnu");
                }
                
            }
        }
        catch(IOException e) {
            System.out.println("Partie.java IOException. " + e.getMessage());
        }
        catch(NumberFormatException e) {
            System.out.println("Partie.java FORMAT. " + e.getMessage());
        }
        return cases;
    }
}