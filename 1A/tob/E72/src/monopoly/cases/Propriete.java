package monopoly.cases;
import monopoly.divers.*;

public class Propriete extends CaseAchetable {

    private Integer construction;
    private final Integer prixMaison;
    private final Integer[] loyer;

    public Propriete(Integer id, TypeCase type, String nom, String icone, Integer prix, JoueurMonopoly joueur, Integer prixMaison, Integer[] loyer) {
        super(id, type, nom, icone, prix, joueur);
        this.construction = 0;
        this.prixMaison = prixMaison;
        this.loyer = loyer;
    }

    /** Obtenir les constructions d'une case
     * @return construction 
     */
    public Integer getConstruction() {
        return this.construction;
    }

    /** Obtenir le loyer de la case
     * @return loyer
     */
    public Integer getLoyer() {
        Integer construction = this.getConstruction();
        return this.loyer[construction];
    }

    /** Definir les constructions d'une case :
     * 0 loyer nu
     * 1 : 1 maison
     * 2 : 2 maison
     * ...
     * 5 : hotel
     * @param constr
     */
    public void setConstruction(Integer constr){
        this.construction = constr;
    }

    /** Obtenir le prix d'une maison.
     * @return Integer le prix d'une maison
     */
    public Integer getPrixMaison() {
        return this.prixMaison;
    }
}