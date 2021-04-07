/** Les des permettent au joueur de savoir de combien de case il va
 * se dépacer. 
 * @author Thomas
 * @version 1.0
 */

package monopoly.divers;
import java.util.Random;

public class Des {

    public static final Integer max = 12;

    /* Premier Dé */ 
    private Integer de1;

    /* Deuxieme Dé */
    private Integer de2;

    /* nombre aleatoire */
    private Random alea = new Random();
    
    /* Constructeur du type Des
     * Il faut lancer les dés avec la procédure lancerDes pour avoir des dés aléatoires
     */
    public Des() {
    	this.de1 = 1 + this.alea.nextInt(6);
        this.de2 = 1 + this.alea.nextInt(6);
    }

    /*
     * Renvoie le dé numéro 1
     */
    public Integer getDe1() {
    	return this.de1;
    }
    
    /*
     * Renvoie le dé numéro 2
     */
    public Integer getDe2() {
    	return this.de2;
    }

    /* Renvoie la somme des deux des */
    public Integer getDes(){
        return (this.de1 + this.de2);
    } 
}