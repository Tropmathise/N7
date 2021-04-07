package monopoly.cases;
import monopoly.divers.*;

/** Case impliquant un simple paiement
 * @author Jules
 */

public class CasePaiement extends Case {
	
	private Integer prix;
	
	/* Constucteur de la case
	 * 
	 */
    public CasePaiement(Integer id, TypeCase type, String nom, String icone, Integer prix) {
        super(id, type, nom, icone);
        this.prix = prix;
    }
	
    public Integer getPrix() {
    	return this.prix;
    }
}
