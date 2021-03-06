package allumettes;

import allumettes.CoupInvalideException;
import allumettes.Jeu;

/** La stratégie tricheur consiste a prendre toutes les 
  * allumettes sauf 2, prendre la dernière et dire qu'il
  * en a pris une seule.
  * @author Thomas SADURNI
  * @version 1.0
  */

  public class StrategieTricheur implements Strategie{
      
    /** Constructeur de la classe stratégie du tricheur. */
    public StrategieTricheur(){
    }

    /** Retourne le nombre d'allumettes.
      * @param jeu Jeu
      */
    @Override
    public int getPrise(Jeu jeu){
        assert(jeu != null);
        assert(jeu.getNombreAllumettes()>0);
        while (jeu.getNombreAllumettes()>2) {
            try {
                jeu.retirer(1);
            }
            catch (CoupInvalideException e){
                System.out.println(e.getMessage());
            }
        }
        return 1;
    }
  }

