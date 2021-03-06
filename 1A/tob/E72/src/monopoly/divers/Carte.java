package monopoly.divers;

/** Les cartes du jeu 
 * @author Thomas, Jules
 * @version 1.5
*/

public class Carte {

    private Integer id;
    private TypeCarte type;
    private Integer valeur;
    private String message;

    /** constructeur de la carte avec son nom et son effet
     * @param id son id
     * @param type son type
     * @param valeur sa valeur
     * @param message son message
     */
    public Carte(Integer id, TypeCarte type, Integer valeur, String message) {
        this.id = id;
        this.type = type;
        this.valeur = valeur;
        this.message = message;
    }

    /** Obtenir l'id de la carte 
     * @return id
     */
    public Integer getId() {
        return this.id;
    }

    /** Obtenir le type de la carte 
     * @return type
     */
    public TypeCarte getType() {
        return this.type;
    }

    /** Obtenir la valeur de la carte 
     * @return valeur
     */
    public Integer getValeur() {
        return this.valeur;
    }

    /** Obtenir le message de la carte 
     * @return message
     */
    public String getMessage() {
        return StringPerso.creer(this.message);
    }

    /** Obtenir l'effet que génère la carte sur le joueur la tirant.
     */
    public void getEffet(JoueurMonopoly joueur) throws ImpayableException {
        switch (this.type) {
            case PAYER:
            	//Retirer #valeur argent au joueur
                joueur.retirerArgent(this.valeur);
                Plateau.ajouterTasArgent(this.valeur);
                break;
            case RECEVOIR:
                // Ajouter #valeur argent au joueur
            	joueur.ajouterArgent(this.valeur);
                break;
            case MOUVEMENT:  
            	Integer adresse = joueur.getPosition().getId() + valeur;
            	// Gestion des gains d'argent
            	if (adresse == Plateau.nbCases) { //ce n'est jamais censé arrivé mais dans le doute on traite quand méme le cas, cela permet de mettre de nouvelles cartes si on le souhaite
            		joueur.ajouterArgent(2*Partie.argentTour);
            	} else if (adresse > Plateau.nbCases) {
            		joueur.ajouterArgent(Partie.argentTour);
            	}
            	// Bouger le joueur de #valeur cases en avant
            	joueur.setPosition(Plateau.cases[(joueur.getPosition().getId() + valeur) % Plateau.nbCases]);
            	//résoudre l'effet de la case
                break;
            case TELEPORTATION:
            	// Gestion des gains d'argent
            	if (valeur == 0) {
            		joueur.ajouterArgent(2*Partie.argentTour);
            	} else if (joueur.getPosition().getId() > valeur) {
            		joueur.ajouterArgent(Partie.argentTour);
            	}
                // Bouger le joueur sur la case
            	joueur.setPosition(Plateau.cases[this.valeur]);
                break;
            	//résoudre l'effet de la case
            case GOPRISON:
            	joueur.setPosition(Plateau.cases[this.valeur]);
            	joueur.setEstEnPrison(true);
            case SORTIEPRISON:
            	joueur.setNbCarteSortieDePrison(joueur.getNbCarteSortieDePrison()+1);
            default:
                System.out.println("Erreur : Type de carte inconnu (Carte.java)");
        }
    }
}