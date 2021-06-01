import java.util.Scanner;

public class enigme {
	
	enum Lieux {ENIGME, SUCCES, ECHEC};
	
	private static void bug() {
		System.out.println("BUG : Oui, c'est un programme minimaliste, donc débrouillez-vous, j'ai la flemme de débuguer ces mauvaises réponses.");
	}

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		int reponse;
		
		int place_inventaire = 0;
		// Objets
		int Tentative = 3;
		int Tentative_Enigme = 0;
		//Connaissance
		boolean Réussite = false;
		// Lieu
		Lieux localisation = Lieux.ENIGME;
		
		boolean fin = false;
		
		while (!fin) {
			switch (localisation) {
			case ENIGME :
					System.out.println("1. Afficher les informations de l'inventaire.");
					System.out.println("2. Afficher les détails du lieu courant.");
					System.out.println("3. Interagir.");
					System.out.println("4. Prendre un objet.");
					System.out.println("5. Déposer un objet.");
					System.out.println("6. Emprunter un chemin");
					reponse = scanner.nextInt();
					switch (reponse) {
						case 1 :
							System.out.println("Vous possédez :");
							if (Tentative > 0) {
								System.out.println(String.valueOf(Tentative) + " tentative(s).");
							}
							if (Réussite) {
								System.out.println("La connaissance Réussite.");
							}
							System.out.println("Il vous reste " + String.valueOf(place_inventaire) + " place(s) d'inventaires.");
							break;
						case 2 :
							System.out.println("Vous vous trouvez dans la salle Énigme.");
							if (Tentative > 0 && !Réussite) {
								System.out.println("Vous voyez un Sphynx.");
							}
							if (Tentative_Enigme > 0) {
								System.out.println("Au sol se trouve " + String.valueOf(Tentative_Enigme) + " occurence(s) de Tentatives.");
							}
							System.out.println("On m'a dit de rester simple dans le code, j'afficherai rien d'autre. Tant pis pour les chemins.");
							break;
						case 3 :
							if (Tentative > 0 && !Réussite) {
								System.out.println("Il y a que un Sphynx, donc t'interragis avec lui. Voilà.");
								System.out.println("\nJe vais te poser une énigme. Quelle pile de linge a été lavée avec Olympe, la lessive des Dieux !");
								System.out.println("1. Celle de gauche, elle est plus soyeuse, plus parfumée.");
								System.out.println("2. Celle de droite, elle est plus douce, plus souple.");
								reponse = scanner.nextInt();
								switch (reponse) {
									case 1 :
										Tentative --;
										place_inventaire++;
										System.out.println("\nMauvaise réponse.");
										break;
									case 2 :
										Réussite = true;
										System.out.println("\nOOOOOOOOUUIIIIII ! Il a réussi !");
										System.out.println(" En effet, ce linge est plus souple, plus doux, plus blanc ! Les dieux font leur lessive avec Olympe, qui laisse le linge blanc et les mains douces, douces, douces !");
										System.out.println("\n En bref, c'est la bonne réponse.");
										break;
									default :
										bug();
										break;
								}
							}
							break;
						case 4 :
							if (Tentative_Enigme > 0) {
								System.out.println("1. Ramasser une Tentative.");
								reponse = scanner.nextInt();
								switch (reponse) {
								case 1 :
									Tentative++;
									Tentative_Enigme--;
									place_inventaire--;
									break;
								default :
									bug();
									break;
								}
							}
							else {
								System.out.println("1. Il n'y a rien. Au revoir.");
							}
							break;
						case 5 :
							if (Tentative > 0) {
								System.out.println("1. Poser une Tentative.");
								reponse = scanner.nextInt();
								switch (reponse) {
								case 1 :
									Tentative--;
									Tentative_Enigme++;
									place_inventaire++;
									break;
								default :
									bug();
									break;
								}
							}
							else {
								System.out.println("1. Tu es pauvre. Dommage.");
							}
							break;
						case 6 :
							if (Réussite) {
								System.out.println("1. Se rendre dans la salle Succès.");
								reponse = scanner.nextInt();
								switch (reponse) {
									case 1 :
										System.out.println("\nVous vous rendez dans la salle Succès.");
										localisation = Lieux.SUCCES;
										break;
									default :
										bug();
										break;
								}
							}
							if (Tentative == 0) {
								System.out.println("1. Se rendre dans la salle Échec.");
								reponse = scanner.nextInt();
								switch (reponse) {
									case 1 :
										System.out.println("\nVous vous rendez dans la salle Echec.");
										localisation = Lieux.ECHEC;
										break;
									default :
										bug();
										break;
								}
							}
							break;
						default :
							bug();
							break;
					}
				break;
				
			case SUCCES :
				System.out.println("\nBravo, vous avez fini le jeu.");
				fin = true;
				break;
				
			case ECHEC :
				System.out.println("\nDommage, vous n'avez pas battu l'énigme.");
				fin = true;
				break;
				
			default :
				bug();
				break;
			}
		}
		scanner.close();
	}
}