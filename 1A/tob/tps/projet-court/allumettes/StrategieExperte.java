package allumettes;
import java.util.Random;

/** La strategie experte consiste à faire gagner l'ordinateur
  * quand il le peut.
  * @author Thomas SADURNI
  * @version 1.4
  */
public class StrategieExperte implements Strategie {

    /** Un nombre aléatoire */
    private Random alea;

    public StrategieExperte() {
        this.alea = new Random();
    }

    /** Retourne le nombre d'allumettes
      * @param jeu Jeu
      * @return nombre d'allumettes
      */
    @Override
    public int getPrise(Jeu jeu) {
        assert (jeu.getNombreAllumettes() > 0);
        assert (jeu != null);
        int n = jeu.getNombreAllumettes();
        if (n % (NouveauJeu.PRISE_MAX + 1) == 1)  {
          return (1 + this.alea.nextInt(Math.min(Jeu.PRISE_MAX, n)));
        } else {
          return ((n - 1) % (Jeu.PRISE_MAX + 1));
        }
    }
}
