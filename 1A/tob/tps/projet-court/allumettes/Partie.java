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
			initJoueurs(args);

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
				+ "\n\t\t"
				+ "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

	public static void initJoueurs(String[] args) {
		String[] joueurStrategie1 = null;
		String[] joueurStrategie2 = null;
		if (args.length == 2) {
			//séparation du premier argument de la ligne de commande
			joueurStrategie1 = args[0].split("@");
			//séparation du deuxieme argument de la ligne de commande
			joueurStrategie2 = args[1].split("@");
		} else {
			joueurStrategie1 = args[1].split("@");
			joueurStrategie2 = args[2].split("@");
		}
		//initialisation du joueur 1 (nom et stratégie)
		Joueur joueur1 = new Joueur(joueurStrategie1[0],
				Joueur.getStrategie(joueurStrategie1[1]));
		//initialisation du joueur 2 (nom et stratégie)
		Joueur joueur2 = new Joueur(joueurStrategie2[0],
				Joueur.getStrategie(joueurStrategie2[1]));
		Arbitre arbitre = new Arbitre(joueur1, joueur2);
		//verification si l'arbitre est confiant ou pas
		if (args[0].equals("-confiant")) {
			arbitre.confiant = true;
		}
		//création du jeu
		NouveauJeu jeu = new NouveauJeu(13);
		arbitre.arbitrer(jeu);
	}
}
