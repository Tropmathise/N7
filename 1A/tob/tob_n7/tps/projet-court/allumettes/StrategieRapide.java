package allumettes;

/** La strategie rapide consiste prendre le maximum 
  * d'allumettes possible.
  * @author Thomas SADURNI
  * @version 1.1
  */
public class StrategieRapide implements Strategie {

    public StrategieRapide(){
    }

    /** Retourne le nombre d'allumettes
      * @param jeu Jeu
      */
    @Override
    public int getPrise(Jeu jeu){
        assert(jeu != null);
        assert(jeu.getNombreAllumettes()>0);
        if (jeu.getNombreAllumettes()<2){
            return 1;
        }
        else if (jeu.getNombreAllumettes()<3){
            return 2;
        }
        return 3;
    }
}