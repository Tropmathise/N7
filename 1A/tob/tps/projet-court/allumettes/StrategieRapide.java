package allumettes;

/** La strategie rapide consiste prendre le maximum
  * d'allumettes possible.
  * @author Thomas SADURNI
  * @version 1.2
  */
public class StrategieRapide implements Strategie {

    public StrategieRapide() {
    }

    /** Retourne le nombre d'allumettes
      * @param jeu Jeu
      * @return nombre d'allumettes
      */
    @Override
    public int getPrise(Jeu jeu) {
        assert (jeu != null);
        assert (jeu.getNombreAllumettes() > 0);
        return Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes());
    }
}
