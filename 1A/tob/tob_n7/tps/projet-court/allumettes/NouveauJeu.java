package allumettes;

/** Classe Nouveau qui implémente l'inerface Jeu.
  * @author Thomas SADURNI
  * @version 1.0 
  */
public class NouveauJeu implements Jeu {

	/** Nombre maximal d'allumettes pouvant être prises. */
    public static final int PRISE_MAX = 3;

    /** Nombre d'allumettes au début du jeu. */
    private int nb_allumettes_jeu;
    
    public NouveauJeu(int nb_allumettes){
        assert (nb_allumettes>0);
        this.nb_allumettes_jeu=nb_allumettes;
    }

	/** Obtenir le nombre d'allumettes encore en jeu.
	 * @return nombre d'allumettes encore en jeu
	 */
    public int getNombreAllumettes(){
        return this.nb_allumettes_jeu;
    }

	/** Retirer des allumettes. Le nombre d'allumettes doit être compris
	 * entre 1 et PRISE_MAX, dans la limite du nombre d'allumettes encore
	 * en jeu.
	 * @param nbPrises nombre d'allumettes prises.
	 * @throws CoupInvalideException tentative de prendre un nombre invalide d'alumettes
	 */
	public void retirer(int nbPrises) throws CoupInvalideException {
        if (nbPrises>0 && nbPrises <= NouveauJeu.PRISE_MAX && nbPrises <= this.nb_allumettes_jeu){
            this.nb_allumettes_jeu -= nbPrises;
        
        }
        else {
            throw new CoupInvalideException(nbPrises, "< 3");
        }
    }
}
