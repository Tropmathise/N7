package allumettes;

/** Un joueur est défini par son nom et par sa Strategie.
  * @author Thomas SADURNI
  * @version 1.4
  */

public class Joueur {

    /** Nom du joueur. */
    private String nom;

    /** Stratégie du joueur. */
    private Strategie strategie;

    /** Initialisation du joeur.
      * @param nomjoueur nom du joueur
      * @param strategiejoueur stratégie du joueur
      */
    public Joueur(String nomjoueur, Strategie strategiejoueur) {
        assert (nomjoueur != null);
        assert (strategiejoueur != null);
        this.nom = nomjoueur;
        this.strategie = strategiejoueur;
    }

    /** Obtenir le nom du joueur.
     * @return nom du joueur.
     */
    public String getNom() {
        return this.nom;
    }

    /** Obtenir le nombre d'allumettes que le joueur veut prendre.
      * @return nombre d'allumettes
      */
    public int getPrise(Jeu jeu) {
        assert (jeu != null);
        assert (jeu.getNombreAllumettes() > 0);
        return this.strategie.getPrise(jeu);
    }

    /** Modifier la stratégie du joueur
      * @param nvStrategie nouvelle stratégie
      */
    public void setStrategie(Strategie nvStrategie) {
        assert (nvStrategie != null);
        this.strategie = nvStrategie;
    }

    /** Obtenir la strategie du joueur.
      * @return strategie du joueur *
      */
    public Strategie getStrategie() {
        return this.strategie;
    }

    public static Strategie getStrategie(String nomStrat) {
      String strat = nomStrat.toLowerCase();

      if (strat.equals("rapide")) {
          return new StrategieRapide();
      } else if (strat.equals("naif") || strat.equals("naive")) {
          return new StrategieNaive();
      } else if (strat.equals("expert") || strat.equals("experte")) {
          return new StrategieExperte();
      } else if (strat.equals("humain") || strat.equals("humaine")) {
          return new StrategieHumaine();
      } else if (strat.equals("tricheur") || strat.equals("tricheuse")) {
          return new StrategieTricheur();
      } else {
          throw new ConfigurationException("Strategie invalide");
      }
    }
}
