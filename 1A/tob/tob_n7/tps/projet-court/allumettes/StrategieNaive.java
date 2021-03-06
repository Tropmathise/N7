package allumettes;
import java.util.Random;

/** La strategie naive consiste à tirer un nombre aléatoire
  * entre 1 et 3.
  * @author Thomas SADURNI
  * @version 1.1
  */

public class StrategieNaive implements Strategie{

    /** Le nombre aléatoire */
    protected Random alea;

    public StrategieNaive() {
        this.alea = new Random();
    }

    /** Retourne le nombre d'allumettes
      * @param jeu Jeu
      */
    @Override
    public int getPrise(Jeu jeu) {
        assert(jeu != null);
        assert(jeu.getNombreAllumettes()>0);
        int n = jeu.getNombreAllumettes();
        return 1 + this.alea.nextInt(Math.min(n,NouveauJeu.PRISE_MAX));
    }
}

