package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Partie {

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			verifierNombreArguments(args);

			String[] joueur_strategie1 = null;
			String[] joueur_strategie2 = null;
			if (args.length==2){
				joueur_strategie1=args[0].split("@");
				joueur_strategie2=args[1].split("@");
			}
			
			else {
				joueur_strategie1=args[1].split("@");
				joueur_strategie2=args[2].split("@");
			}

			Joueur joueur1 = new Joueur(joueur_strategie1[0], Joueur.getStrategie(joueur_strategie1[1]));
			Joueur joueur2 = new Joueur(joueur_strategie2[0], Joueur.getStrategie(joueur_strategie2[1]));
			Arbitre arbitre = new Arbitre(joueur1, joueur2);

			if(args[0].equals("-confiant")){
				arbitre.confiant=true;
			}
			NouveauJeu jeu = new NouveauJeu(13);
			arbitre.arbitrer(jeu);

		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
