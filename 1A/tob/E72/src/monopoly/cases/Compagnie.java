package monopoly.cases;
import monopoly.divers.*;

/** Case compagnie
 * @author Theo
 */

public class Compagnie extends CaseAchetable {


    public Compagnie(Integer id, TypeCase type, String nom, String icone, Integer prix, JoueurMonopoly joueur) {
        super(id, type, nom, icone, prix, joueur);

    }
}