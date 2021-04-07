package monopoly.cases;

import monopoly.divers.*;

public class Gare extends CaseAchetable {

    public Gare(Integer id, TypeCase type, String nom, String icone, Integer prix, JoueurMonopoly joueur) {
        super(id, type, nom, icone, prix, joueur);
    }

    /** Obtenir le loyer de la case.
     * @return loyer
     */
    public Integer getLoyer() {
    	return 25*2^(this.proprietaire.getNbGares()-1);
    }
}