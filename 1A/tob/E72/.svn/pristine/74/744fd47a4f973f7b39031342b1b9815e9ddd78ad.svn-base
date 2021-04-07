package monopoly.cases;

import monopoly.divers.*;

public class CaseAchetable extends Case {

    private Integer prix;
    protected Boolean estAchetee;
    protected JoueurMonopoly proprietaire;

    public CaseAchetable(Integer id, TypeCase type, String nom, String icone, Integer prix, JoueurMonopoly joueur) {
        super(id, type, nom, icone);
        this.prix = prix;
        estAchetee = false;
        proprietaire = joueur;
    }

    /** Obtenir le prix de la case
	 * @return prix
	 */
    public Integer getPrix() {
        return this.prix;
    }

    /** Obtenir la valeur d'hypotheque de la case
     * @return hypotheque
     */
    public Integer getHypotheque() {
        return prix/2;
    }

    public String getNomProp() {
        return StringPerso.creer("Propriétaire : " + this.proprietaire.getNom());
    }

    public Boolean getEstAchetee() {
    	return this.estAchetee;
    }
    
    public JoueurMonopoly getProp() {
        return this.proprietaire;
    }

    public void setEstAchetee(Boolean bool) {
    	this.estAchetee = bool;
    }
    
    public void setProp(JoueurMonopoly j) {
        this.proprietaire = j;
    }
    
}