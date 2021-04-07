/** La case sur lequel un joueur tombe
 * @author Thomas
 * @version 1.0
 */

package monopoly.divers;

public class Case {

    /* Les attributs d'une case */

    protected Integer id;
    protected TypeCase type;
    protected String nom;
    private String icone;

    /** Constructeur de la case */
    public Case(Integer id, TypeCase type, String nom, String icone) {
        this.id = id;
        this.type = type;
        this.nom = StringPerso.creer(nom);
        this.icone = StringPerso.creer(icone);
    }

    /** Obtenir l'id de la case
     * @return id de la case
     */
    public Integer getId() {
        return this.id;
    }

    /** Obtenir le nom de la case
	 * @return nom de la case
	 */
	public String getNom() {
		return StringPerso.creer(this.nom);
    }

    /** Obtenir le type de la case.
     * @return type de la case
     */
    public TypeCase getType() {
        return this.type;
    }

    /** Obtenir le nom du propriétaire.
     * @return un message indiquant que la case ne peut pas avoir de propriétaire
     */
    public String getNomProp() {
        return StringPerso.creer("Case impossible à acheter.");
    }

    /** Obtenir le nom du fichier de l'icone de la case. Le fichier est dans le dossier res
     * @return nom du fichier
     */
    public String getFichierIcone() {
    	return this.icone;
    }

}
