
import java.util.Scanner;

public class Mini_Rpg {

	enum Lieux {ARMURERIE, PLAINE, CIMETIERE, BANQUET, HUTTE};

	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		boolean erreurScanner;
		int reponse = 0;
		boolean continuer;
		int i;
		// Objets
		int Hache = 0;
		int ArmurerieHache = 0;
		int ArmurerieHacheDeposes = 0;
		int PlaineHache = 0;
		int PlaineHacheDeposes = 0;
		int CimetiereHache = 0;
		int CimetiereHacheDeposes = 0;
		int BanquetHache = 0;
		int BanquetHacheDeposes = 0;
		int HutteHache = 0;
		int HutteHacheDeposes = 0;
		int Pioche = 0;
		int ArmureriePioche = 0;
		int ArmureriePiocheDeposes = 0;
		int PlainePioche = 0;
		int PlainePiocheDeposes = 0;
		int CimetierePioche = 0;
		int CimetierePiocheDeposes = 0;
		int BanquetPioche = 0;
		int BanquetPiocheDeposes = 0;
		int HuttePioche = 0;
		int HuttePiocheDeposes = 0;
		int Corde = 0;
		int ArmurerieCorde = 0;
		int ArmurerieCordeDeposes = 0;
		int PlaineCorde = 0;
		int PlaineCordeDeposes = 0;
		int CimetiereCorde = 0;
		int CimetiereCordeDeposes = 0;
		int BanquetCorde = 0;
		int BanquetCordeDeposes = 0;
		int HutteCorde = 0;
		int HutteCordeDeposes = 0;
		int Brindille = 0;
		int ArmurerieBrindille = 0;
		int ArmurerieBrindilleDeposes = 0;
		int PlaineBrindille = 0;
		int PlaineBrindilleDeposes = 0;
		int CimetiereBrindille = 0;
		int CimetiereBrindilleDeposes = 0;
		int BanquetBrindille = 0;
		int BanquetBrindilleDeposes = 0;
		int HutteBrindille = 0;
		int HutteBrindilleDeposes = 0;
		int Pierre = 0;
		int ArmureriePierre = 0;
		int ArmureriePierreDeposes = 0;
		int PlainePierre = 0;
		int PlainePierreDeposes = 0;
		int CimetierePierre = 0;
		int CimetierePierreDeposes = 0;
		int BanquetPierre = 0;
		int BanquetPierreDeposes = 0;
		int HuttePierre = 0;
		int HuttePierreDeposes = 0;
		int Lance_Pierre = 0;
		int ArmurerieLance_Pierre = 0;
		int ArmurerieLance_PierreDeposes = 0;
		int PlaineLance_Pierre = 0;
		int PlaineLance_PierreDeposes = 0;
		int CimetiereLance_Pierre = 0;
		int CimetiereLance_PierreDeposes = 0;
		int BanquetLance_Pierre = 0;
		int BanquetLance_PierreDeposes = 0;
		int HutteLance_Pierre = 0;
		int HutteLance_PierreDeposes = 0;
		int Plume = 0;
		int ArmureriePlume = 0;
		int ArmureriePlumeDeposes = 0;
		int PlainePlume = 0;
		int PlainePlumeDeposes = 0;
		int CimetierePlume = 0;
		int CimetierePlumeDeposes = 0;
		int BanquetPlume = 0;
		int BanquetPlumeDeposes = 0;
		int HuttePlume = 0;
		int HuttePlumeDeposes = 0;
		int Antidote = 0;
		int ArmurerieAntidote = 0;
		int ArmurerieAntidoteDeposes = 0;
		int PlaineAntidote = 0;
		int PlaineAntidoteDeposes = 0;
		int CimetiereAntidote = 0;
		int CimetiereAntidoteDeposes = 0;
		int BanquetAntidote = 0;
		int BanquetAntidoteDeposes = 0;
		int HutteAntidote = 0;
		int HutteAntidoteDeposes = 0;
		// Connaissances
		boolean Tueur_Treant = false;
		boolean Tueur_Golem = false;
		boolean Localisation_Phoenix = false;
		boolean Mort = false;
		// Lieu
		Lieux localisation = Lieux.ARMURERIE;
		// Inventaire
		int place_inventaire = 7;
		Corde = 1;
		place_inventaire -= 1*1;
		// Objets Lieux
		ArmurerieHache = 1;
		ArmureriePioche = 1;
		boolean fin = false;
		while (!fin) {
			switch (localisation) {
				case ARMURERIE :
					System.out.print("\033[H\033[2J");
					System.out.flush();
					System.out.println("Que souhaitez-vous faire?\n");
					System.out.println("1. Afficher les informations de l'inventaire.");
					System.out.println("2. Afficher les détails du lieu courant.");
					System.out.println("3. Interagir.");
					System.out.println("4. Prendre un objet.");
					System.out.println("5. Déposer un objet.");
					System.out.println("6. Emprunter un chemin");
					reponse = 0;
					erreurScanner = true;
					while(erreurScanner){
						if (scanner.hasNextInt()){
							reponse = scanner.nextInt();
						} else {
							System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
							scanner.next();
							continue;
						}
						erreurScanner = false;
					}
					while((reponse < 1)||(reponse > 6)){
						System.out.print("\033[1A");
						System.out.print("\033[2K");	
						reponse = 0;
						erreurScanner = true;
						while(erreurScanner){
							if (scanner.hasNextInt()){
								reponse = scanner.nextInt();
							} else {
								System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
								scanner.next();
								continue;
							}
							erreurScanner = false;
						}
					}
					switch (reponse) {
						case 1 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								i = 0;
								System.out.println("Vous possédez :\n");
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								if (Tueur_Treant) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Treant.");
								}
								if (Tueur_Golem) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Golem.");
								}
								if (Localisation_Phoenix) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Localisation_Phoenix.");
								}
								if (Mort) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Mort.");
								}
								System.out.println("\nPlaces restantes dans l'inventaire : "+String.valueOf(place_inventaire)+"\n");
								System.out.println("Pour plus d'informations sur un objet/connaissance, saisissez son numéro.\n");
								i++;
								System.out.println(String.valueOf(i) + ". Retour au menu");
							
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								System.out.print("\033[H\033[2J");
								System.out.flush();
								
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Hache : ");
										if( true ) {
											System.out.println("Une hache bien aiguisé pour couper du bois.");
										}
									}
								} 
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pioche : ");
										if( true ) {
											System.out.println("Une pioche pour briser des roches solides.");
										}
									}
								} 
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Corde : ");
										if( true ) {
											System.out.println("Une corde légèrement élastique.");
										}
									}
								} 
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Brindille : ");
										if( true ) {
											System.out.println("Du petit bois.");
										}
									}
								} 
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pierre : ");
										if( true ) {
											System.out.println("Un caillou bien taillé.");
										}
									}
								} 
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Lance_Pierre : ");
										if( true ) {
											System.out.println("Un lance-pierre de bonne facture, qui saura être précis.");
										}
									}
								} 
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Plume : ");
										if( true ) {
											System.out.println("La plume d'un phoénix, inutile sous sa forme actuelle. Il faut en extraire les propriétés magiques.");
										}
									}
								} 
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Antidote : ");
										if( true ) {
											System.out.println("Un antidote mystérieux.");
										}
									}
								} 
								if (Tueur_Treant) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Treant : ");
										if( true ) {
											System.out.println("Vous avez tué un tréant, c'est un haut fait !");
										}
									}
								} 
								if (Tueur_Golem) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Golem : ");
										if( true ) {
											System.out.println("Vous avez tué un golem, c'est un haut fait !");
										}
									}
								} 
								if (Localisation_Phoenix) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Localisation_Phoenix : ");
										if( true ) {
											System.out.println("Le Phoenix passe parfois par la plaine de Valtordu.");
										}
									}
								} 
								if (Mort) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Mort : ");
										if( true ) {
											System.out.println("Le décès. Pur et irrémédiable.");
										}
									}
								} 
								i++;
								if (reponse == i) {
									continuer = false;
								} else if ((reponse >= 0)&&(reponse < i)){
									System.out.println("\n1. Retour à l'inventaire");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}		
								}
							}
							break;
						case 2 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Lieu Armurerie : \n");
							System.out.println("Description du lieu :\n");
							if( true ) {
								System.out.println("Un lieu d'artisanat et de stockage d'armes.");
							}
							System.out.println("\nObjets visibles :\n");
							if (ArmurerieHache > 0){
								if (true) {
									System.out.println(String.valueOf(ArmurerieHache) + " objet(s) Hache, de taille 4");
								}
							}
							if (ArmureriePioche > 0){
								if (true) {
									System.out.println(String.valueOf(ArmureriePioche) + " objet(s) Pioche, de taille 4");
								}
							}
							if (ArmurerieHacheDeposes > 0){
								System.out.println(String.valueOf(ArmurerieHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
							}
							if (ArmureriePiocheDeposes > 0){
								System.out.println(String.valueOf(ArmureriePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
							}
							if (ArmurerieCordeDeposes > 0){
								System.out.println(String.valueOf(ArmurerieCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
							}
							if (ArmurerieBrindilleDeposes > 0){
								System.out.println(String.valueOf(ArmurerieBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
							}
							if (ArmureriePierreDeposes > 0){
								System.out.println(String.valueOf(ArmureriePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
							}
							if (ArmurerieLance_PierreDeposes > 0){
								System.out.println(String.valueOf(ArmurerieLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
							}
							if (ArmureriePlumeDeposes > 0){
								System.out.println(String.valueOf(ArmureriePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
							}
							if (ArmurerieAntidoteDeposes > 0){
								System.out.println(String.valueOf(ArmurerieAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
							}
							System.out.println("\nPersonnages visibles :\n");
							if (((!Mort))){
								System.out.println("Artisan");
							}
							System.out.println("\nChemins visibles :\n");
							i = 0;
							if (true){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Un sentier reliant l'armurerie et les plaines de Valtordu.");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							if (((Tueur_Treant))||((Tueur_Golem))){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Vous êtes un héros pour avoir défait un monstre. Vous allez pouvoir prendre un repos bien mérité ....");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							System.out.println("\n1. Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while (reponse != 1){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							break;
						case 3 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Personnages visibles :\n");
							i = 0;
							if(((!Mort))){
								i++;
								System.out.println(String.valueOf(i)+". Artisan");
							}
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if(((!Mort))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									if(((Corde == 0))||((Brindille < 2))){
										choix = "choixAbsorbe";
									}
									if(((Corde > 0)&&(Brindille > 1))){
										choix = "choixDisponible";
									}
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixAbsorbe":
												if( true ) {
													System.out.println("L'artisan est absorbé par son travail, il ne vous remarque pas.\n Non, même en faisant ces grands signes. Sa concentration est exemplaire.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixDisponible":
												if( true ) {
													System.out.println("Bonjour, je recherche des matérieux pour construire une arme de jet. Auriez-vous 1 Corde et 2 Brindilles ?");
												}
												System.out.println("\n");
												i = 0;
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Lui remettre les matériaux demandés.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Ne pas lui remettre les matériaux.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(true){
													i++;
													if(reponse == i){
														choix = "choixFabrique";
														System.out.println("");
														Corde -= 1;
														place_inventaire += 1*1;
														System.out.println("Vous perdez 1 objet(s) Corde");
														Brindille -= 2;
														place_inventaire += 2*1;
														System.out.println("Vous perdez 2 objet(s) Brindille");
														System.out.println("");
														if(true){
															if (2 * 1 <= place_inventaire ){
																Lance_Pierre += 1;
																place_inventaire -= 1*2;
																System.out.println("Vous recevez 1 objet(s) Lance_Pierre");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 1 objet(s) Lance_Pierre");
															}
														}
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixNonFabrique";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixFabrique":
												if( true ) {
													System.out.println("Merci beaucoup, je vous offre ce lance-pierre pour vous dédommager.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixNonFabrique":
												if( true ) {
													System.out.println("Ce n'est pas grave, merci quand même.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
										}
									}
									break;
								}
							}
							break;
						case 4:
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Objets ramassables :\n");
								i = 0;
								if (ArmurerieHache > 0){
									if (true) {
										i++;
										System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieHache) + " objet(s) Hache, de taille 4");
									}
								}
								if (ArmureriePioche > 0){
									if (true) {
										i++;
										System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmureriePioche) + " objet(s) Pioche, de taille 4");
									}
								}
								if (ArmurerieHacheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
								}
								if (ArmureriePiocheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmureriePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
								}
								if (ArmurerieCordeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
								}
								if (ArmurerieBrindilleDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
								}
								if (ArmureriePierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmureriePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
								}
								if (ArmurerieLance_PierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
								}
								if (ArmureriePlumeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmureriePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
								}
								if (ArmurerieAntidoteDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(ArmurerieAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous ramasser?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (ArmurerieHache > 0){
									if (true) {
										i++;
										if (reponse == i){
											System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
											System.out.println("\n0. Annuler\n");
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
											boolean continuer2 = true;
											while(continuer2){
												if ((reponse < 0)||(reponse > ArmurerieHache)) {
													System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieHache));
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												} else if ((place_inventaire - reponse*4) < 0){
													System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												} else {
													continuer2 = false;
												}
											}
											if (reponse != 0){
												Hache += reponse;
												ArmurerieHache -= reponse;
												place_inventaire -= reponse*4;
												reponse = i;
											}
										}
									}
								}
								if (ArmureriePioche > 0){
									if (true) {
										i++;
										if (reponse == i){
											System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
											System.out.println("\n0. Annuler\n");
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
											boolean continuer2 = true;
											while(continuer2){
												if ((reponse < 0)||(reponse > ArmureriePioche)) {
													System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmureriePioche));
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												} else if ((place_inventaire - reponse*4) < 0){
													System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												} else {
													continuer2 = false;
												}
											}
											if (reponse != 0){
												Pioche += reponse;
												ArmureriePioche -= reponse;
												place_inventaire -= reponse*4;
												reponse = i;
											}
										}
									}
								}
								if (ArmurerieHacheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmurerieHacheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieHacheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Hache += reponse;
											ArmurerieHacheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (ArmureriePiocheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmureriePiocheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmureriePiocheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pioche += reponse;
											ArmureriePiocheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (ArmurerieCordeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmurerieCordeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieCordeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Corde += reponse;
											ArmurerieCordeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (ArmurerieBrindilleDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmurerieBrindilleDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieBrindilleDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Brindille += reponse;
											ArmurerieBrindilleDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (ArmureriePierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmureriePierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmureriePierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pierre += reponse;
											ArmureriePierreDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (ArmurerieLance_PierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmurerieLance_PierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieLance_PierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*2) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Lance_Pierre += reponse;
											ArmurerieLance_PierreDeposes -= reponse;
											place_inventaire -= reponse*2;
											reponse = i;
										}
									}
								}
								if (ArmureriePlumeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmureriePlumeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmureriePlumeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Plume += reponse;
											ArmureriePlumeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (ArmurerieAntidoteDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > ArmurerieAntidoteDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(ArmurerieAntidoteDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Antidote += reponse;
											ArmurerieAntidoteDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Ramasser un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 5 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Vous possédez :\n");
								i = 0;
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous déposer?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Hache)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Hache));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Hache -= reponse;
											ArmurerieHacheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pioche)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pioche));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pioche -= reponse;
											ArmureriePiocheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Corde)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Corde));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Corde -= reponse;
											ArmurerieCordeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Brindille)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Brindille));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Brindille -= reponse;
											ArmurerieBrindilleDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pierre -= reponse;
											ArmureriePierreDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Lance_Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Lance_Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Lance_Pierre -= reponse;
											ArmurerieLance_PierreDeposes += reponse;
											place_inventaire += reponse*2;
											reponse = i;
										}
									}
								}
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Plume)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Plume));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Plume -= reponse;
											ArmureriePlumeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Antidote)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Antidote));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Antidote -= reponse;
											ArmurerieAntidoteDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Déposer un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 6:
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("\nChemins empruntables :\n");
							i = 0;
							if (true){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Un sentier reliant l'armurerie et les plaines de Valtordu.");
									}
									System.out.println("");
								}
							}
							if (((Tueur_Treant))||((Tueur_Golem))){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Vous êtes un héros pour avoir défait un monstre. Vous allez pouvoir prendre un repos bien mérité ....");
									}
									System.out.println("");
								}
							}
							System.out.println("\nChoisissez un chemin");
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if (true){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.PLAINE;
										System.out.println("Vous arrivez dans le lieu Plaine");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							if (((Tueur_Treant))||((Tueur_Golem))){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.BANQUET;
										System.out.println("Vous arrivez dans le lieu Banquet");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							break;
					}
					break;
				case PLAINE :
					System.out.print("\033[H\033[2J");
					System.out.flush();
					System.out.println("Que souhaitez-vous faire?\n");
					System.out.println("1. Afficher les informations de l'inventaire.");
					System.out.println("2. Afficher les détails du lieu courant.");
					System.out.println("3. Interagir.");
					System.out.println("4. Prendre un objet.");
					System.out.println("5. Déposer un objet.");
					System.out.println("6. Emprunter un chemin");
					reponse = 0;
					erreurScanner = true;
					while(erreurScanner){
						if (scanner.hasNextInt()){
							reponse = scanner.nextInt();
						} else {
							System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
							scanner.next();
							continue;
						}
						erreurScanner = false;
					}
					while((reponse < 1)||(reponse > 6)){
						System.out.print("\033[1A");
						System.out.print("\033[2K");	
						reponse = 0;
						erreurScanner = true;
						while(erreurScanner){
							if (scanner.hasNextInt()){
								reponse = scanner.nextInt();
							} else {
								System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
								scanner.next();
								continue;
							}
							erreurScanner = false;
						}
					}
					switch (reponse) {
						case 1 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								i = 0;
								System.out.println("Vous possédez :\n");
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								if (Tueur_Treant) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Treant.");
								}
								if (Tueur_Golem) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Golem.");
								}
								if (Localisation_Phoenix) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Localisation_Phoenix.");
								}
								if (Mort) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Mort.");
								}
								System.out.println("\nPlaces restantes dans l'inventaire : "+String.valueOf(place_inventaire)+"\n");
								System.out.println("Pour plus d'informations sur un objet/connaissance, saisissez son numéro.\n");
								i++;
								System.out.println(String.valueOf(i) + ". Retour au menu");
							
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								System.out.print("\033[H\033[2J");
								System.out.flush();
								
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Hache : ");
										if( true ) {
											System.out.println("Une hache bien aiguisé pour couper du bois.");
										}
									}
								} 
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pioche : ");
										if( true ) {
											System.out.println("Une pioche pour briser des roches solides.");
										}
									}
								} 
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Corde : ");
										if( true ) {
											System.out.println("Une corde légèrement élastique.");
										}
									}
								} 
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Brindille : ");
										if( true ) {
											System.out.println("Du petit bois.");
										}
									}
								} 
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pierre : ");
										if( true ) {
											System.out.println("Un caillou bien taillé.");
										}
									}
								} 
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Lance_Pierre : ");
										if( true ) {
											System.out.println("Un lance-pierre de bonne facture, qui saura être précis.");
										}
									}
								} 
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Plume : ");
										if( true ) {
											System.out.println("La plume d'un phoénix, inutile sous sa forme actuelle. Il faut en extraire les propriétés magiques.");
										}
									}
								} 
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Antidote : ");
										if( true ) {
											System.out.println("Un antidote mystérieux.");
										}
									}
								} 
								if (Tueur_Treant) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Treant : ");
										if( true ) {
											System.out.println("Vous avez tué un tréant, c'est un haut fait !");
										}
									}
								} 
								if (Tueur_Golem) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Golem : ");
										if( true ) {
											System.out.println("Vous avez tué un golem, c'est un haut fait !");
										}
									}
								} 
								if (Localisation_Phoenix) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Localisation_Phoenix : ");
										if( true ) {
											System.out.println("Le Phoenix passe parfois par la plaine de Valtordu.");
										}
									}
								} 
								if (Mort) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Mort : ");
										if( true ) {
											System.out.println("Le décès. Pur et irrémédiable.");
										}
									}
								} 
								i++;
								if (reponse == i) {
									continuer = false;
								} else if ((reponse >= 0)&&(reponse < i)){
									System.out.println("\n1. Retour à l'inventaire");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}		
								}
							}
							break;
						case 2 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Lieu Plaine : \n");
							System.out.println("Description du lieu :\n");
							if( ((!Localisation_Phoenix)) ) {
								System.out.println("Une vaste plaine, qui semblerait être l'antre de terribles monstres.");
							}
							else if( ((Localisation_Phoenix)) ) {
								System.out.println("Une vaste plaine, lieux de combat et de passage de phoénix.");
							}
							System.out.println("\nObjets visibles :\n");
							if (PlaineHacheDeposes > 0){
								System.out.println(String.valueOf(PlaineHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
							}
							if (PlainePiocheDeposes > 0){
								System.out.println(String.valueOf(PlainePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
							}
							if (PlaineCordeDeposes > 0){
								System.out.println(String.valueOf(PlaineCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
							}
							if (PlaineBrindilleDeposes > 0){
								System.out.println(String.valueOf(PlaineBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
							}
							if (PlainePierreDeposes > 0){
								System.out.println(String.valueOf(PlainePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
							}
							if (PlaineLance_PierreDeposes > 0){
								System.out.println(String.valueOf(PlaineLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
							}
							if (PlainePlumeDeposes > 0){
								System.out.println(String.valueOf(PlainePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
							}
							if (PlaineAntidoteDeposes > 0){
								System.out.println(String.valueOf(PlaineAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
							}
							System.out.println("\nPersonnages visibles :\n");
							if (((!Mort))){
								System.out.println("Treant");
							}
							if (((!Mort))){
								System.out.println("Golem");
							}
							if (((Lance_Pierre > 0)&&(!Mort))||((Localisation_Phoenix)&&(!Mort))){
								System.out.println("Poenix");
							}
							System.out.println("\nChemins visibles :\n");
							i = 0;
							if (true){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Un sentier reliant l'armurerie et les plaines de Valtordu.");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							if (true){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Un vieux panneau indique 'Orée de la forêt de Schlipak.'");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							if (((Mort))){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Un vieux portail donnant sur le cimetiere.'");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							System.out.println("\n1. Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while (reponse != 1){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							break;
						case 3 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Personnages visibles :\n");
							i = 0;
							if(((!Mort))){
								i++;
								System.out.println(String.valueOf(i)+". Treant");
							}
							if(((!Mort))){
								i++;
								System.out.println(String.valueOf(i)+". Golem");
							}
							if(((Lance_Pierre > 0)&&(!Mort))||((Localisation_Phoenix)&&(!Mort))){
								i++;
								System.out.println(String.valueOf(i)+". Poenix");
							}
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if(((!Mort))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									choix = "choixRencontreTreant";
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixRencontreTreant":
												if( true ) {
													System.out.println("Un tréant se trouve devant vous. Que faire ?");
												}
												System.out.println("\n");
												i = 0;
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre à mains nues.");
													}
													System.out.println("");
												}
												if(((Hache > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre avec la hache.");
													}
													System.out.println("");
												}
												if(((Pioche > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre avec la pioche.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Fuir.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(true){
													i++;
													if(reponse == i){
														choix = "choixMainTreant";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Mort)){
																Mort = true;
																System.out.println("Vous recevez la connaissance Mort");
															}
														}
														System.out.println("\n");
													}
												}
												if(((Hache > 0))){
													i++;
													if(reponse == i){
														choix = "choixHacheTreant";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Tueur_Treant)){
																Tueur_Treant = true;
																System.out.println("Vous recevez la connaissance Tueur_Treant");
															}
														}
														if(true){
															if (1 * 2 <= place_inventaire ){
																Brindille += 2;
																place_inventaire -= 2*1;
																System.out.println("Vous recevez 2 objet(s) Brindille");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 2 objet(s) Brindille");
															}
														}
														System.out.println("\n");
													}
												}
												if(((Pioche > 0))){
													i++;
													if(reponse == i){
														choix = "choixPiocheTreant";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixFuiteTreant";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixMainTreant":
												if( true ) {
													System.out.println("C'était une mauvaise idée. Il vous saisit par les jambes et vous jette sur 112 mètres. Ah oui, c'est vrai, ça a aussi engendré votre décès.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixHacheTreant":
												if( true ) {
													System.out.println("Vous découpez le tréant avec facilité et vous récupérer quelques brindilles de son cadavre.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixPiocheTreant":
												if( true ) {
													System.out.println("La pioche n'est pas efficace sur le tréant, mais au moins elle vous a protégé de ses coups mortels.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixFuiteTreant":
												if( true ) {
													System.out.println("Ce tréant fait quand même plus de 5 mètres, fuir est sans doute une bonne idée si l'on a pas le bon équipement.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
										}
									}
									break;
								}
							}
							if(((!Mort))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									choix = "choixRencontreGolem";
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixRencontreGolem":
												if( true ) {
													System.out.println("Un golem se trouve devant vous. Que faire ?");
												}
												System.out.println("\n");
												i = 0;
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre à mains nues.");
													}
													System.out.println("");
												}
												if(((Hache > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre avec la hache.");
													}
													System.out.println("");
												}
												if(((Pioche > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Le combattre avec la pioche.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Fuir.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(true){
													i++;
													if(reponse == i){
														choix = "choixMainGolem";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Mort)){
																Mort = true;
																System.out.println("Vous recevez la connaissance Mort");
															}
														}
														System.out.println("\n");
													}
												}
												if(((Hache > 0))){
													i++;
													if(reponse == i){
														choix = "choixHacheGolem";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
												if(((Pioche > 0))){
													i++;
													if(reponse == i){
														choix = "choixPiocheGolem";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Tueur_Golem)){
																Tueur_Golem = true;
																System.out.println("Vous recevez la connaissance Tueur_Golem");
															}
														}
														if(true){
															if (1 * 1 <= place_inventaire ){
																Pierre += 1;
																place_inventaire -= 1*1;
																System.out.println("Vous recevez 1 objet(s) Pierre");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 1 objet(s) Pierre");
															}
														}
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixFuiteGolem";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixMainGolem":
												if( true ) {
													System.out.println("C'était une mauvaise idée. Il vous saisit par les jambes et vous jette sur 112 mètres. Ah oui, c'est vrai, ça a aussi engendré votre décès.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixHacheGolem":
												if( true ) {
													System.out.println("La hache n'est pas efficace sur le golem, mais au moins elle vous a protégé de ses coups mortels.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixPiocheGolem":
												if( true ) {
													System.out.println("Vous pulvérisez le golem avec facilité et vous récupérer quelques pierres de son cadavre.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixFuiteGolem":
												if( true ) {
													System.out.println("Ce golem est un cyclope et donc plus fort que ces congénères, fuir est sans doute une bonne idée si l'on a pas le bon équipement.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
										}
									}
									break;
								}
							}
							if(((Lance_Pierre > 0)&&(!Mort))||((Localisation_Phoenix)&&(!Mort))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									choix = "choixPhoenix";
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixPhoenix":
												if( true ) {
													System.out.println("Vous voyez un phoénix voler dans le ciel.");
												}
												System.out.println("\n");
												i = 0;
												if(((Lance_Pierre > 0)&&(Pierre > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Lui tirer dessus.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Ne rien faire.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(((Lance_Pierre > 0)&&(Pierre > 0))){
													i++;
													if(reponse == i){
														choix = "choixTirer";
														System.out.println("");
														Pierre -= 1;
														place_inventaire += 1*1;
														System.out.println("Vous perdez 1 objet(s) Pierre");
														System.out.println("");
														if(true){
															if (1 * 1 <= place_inventaire ){
																Plume += 1;
																place_inventaire -= 1*1;
																System.out.println("Vous recevez 1 objet(s) Plume");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 1 objet(s) Plume");
															}
														}
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixFuitePhoenix";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixTirer":
												if( true ) {
													System.out.println("Vous tirer sur le phoenix. Une plume tombe et vous la ramassez.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixFuitePhoenix":
												if( true ) {
													System.out.println("Vous repartez.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
										}
									}
									break;
								}
							}
							break;
						case 4:
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Objets ramassables :\n");
								i = 0;
								if (PlaineHacheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlaineHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
								}
								if (PlainePiocheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlainePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
								}
								if (PlaineCordeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlaineCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
								}
								if (PlaineBrindilleDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlaineBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
								}
								if (PlainePierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlainePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
								}
								if (PlaineLance_PierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlaineLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
								}
								if (PlainePlumeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlainePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
								}
								if (PlaineAntidoteDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(PlaineAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous ramasser?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (PlaineHacheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlaineHacheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlaineHacheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Hache += reponse;
											PlaineHacheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (PlainePiocheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlainePiocheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlainePiocheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pioche += reponse;
											PlainePiocheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (PlaineCordeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlaineCordeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlaineCordeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Corde += reponse;
											PlaineCordeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (PlaineBrindilleDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlaineBrindilleDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlaineBrindilleDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Brindille += reponse;
											PlaineBrindilleDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (PlainePierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlainePierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlainePierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pierre += reponse;
											PlainePierreDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (PlaineLance_PierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlaineLance_PierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlaineLance_PierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*2) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Lance_Pierre += reponse;
											PlaineLance_PierreDeposes -= reponse;
											place_inventaire -= reponse*2;
											reponse = i;
										}
									}
								}
								if (PlainePlumeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlainePlumeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlainePlumeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Plume += reponse;
											PlainePlumeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (PlaineAntidoteDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > PlaineAntidoteDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(PlaineAntidoteDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Antidote += reponse;
											PlaineAntidoteDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Ramasser un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 5 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Vous possédez :\n");
								i = 0;
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous déposer?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Hache)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Hache));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Hache -= reponse;
											PlaineHacheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pioche)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pioche));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pioche -= reponse;
											PlainePiocheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Corde)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Corde));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Corde -= reponse;
											PlaineCordeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Brindille)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Brindille));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Brindille -= reponse;
											PlaineBrindilleDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pierre -= reponse;
											PlainePierreDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Lance_Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Lance_Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Lance_Pierre -= reponse;
											PlaineLance_PierreDeposes += reponse;
											place_inventaire += reponse*2;
											reponse = i;
										}
									}
								}
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Plume)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Plume));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Plume -= reponse;
											PlainePlumeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Antidote)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Antidote));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Antidote -= reponse;
											PlaineAntidoteDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Déposer un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 6:
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("\nChemins empruntables :\n");
							i = 0;
							if (true){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Un sentier reliant l'armurerie et les plaines de Valtordu.");
									}
									System.out.println("");
								}
							}
							if (true){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Un vieux panneau indique 'Orée de la forêt de Schlipak.'");
									}
									System.out.println("");
								}
							}
							if (((Mort))){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Un vieux portail donnant sur le cimetiere.'");
									}
									System.out.println("");
								}
							}
							System.out.println("\nChoisissez un chemin");
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if (true){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.ARMURERIE;
										System.out.println("Vous arrivez dans le lieu Armurerie");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							if (true){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.HUTTE;
										System.out.println("Vous arrivez dans le lieu Hutte");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							if (((Mort))){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.CIMETIERE;
										System.out.println("Vous arrivez dans le lieu Cimetiere");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							break;
					}
					break;
				case CIMETIERE :
					if( true ) {
						System.out.println("Un lieu de reccueillement, pour le repos des défunts.");
					}
					fin = true;
					break;
				case BANQUET :
					if( ((Antidote == 0)) ) {
						System.out.println("Un lieu de fête, pour les grands héros. Dommage que votre coupe de vin était ... empoisonnée.");
					}
					else if( ((Antidote > 0)) ) {
						System.out.println("Un lieu de fête, pour les grands héros. Dommage que votre coupe de vin était ... empoisonnée.\n Cependant, vous ne succombez pas grâce à l'antidote que vous possédez ! Félicitations !");
					}
					fin = true;
					break;
				case HUTTE :
					System.out.print("\033[H\033[2J");
					System.out.flush();
					System.out.println("Que souhaitez-vous faire?\n");
					System.out.println("1. Afficher les informations de l'inventaire.");
					System.out.println("2. Afficher les détails du lieu courant.");
					System.out.println("3. Interagir.");
					System.out.println("4. Prendre un objet.");
					System.out.println("5. Déposer un objet.");
					System.out.println("6. Emprunter un chemin");
					reponse = 0;
					erreurScanner = true;
					while(erreurScanner){
						if (scanner.hasNextInt()){
							reponse = scanner.nextInt();
						} else {
							System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
							scanner.next();
							continue;
						}
						erreurScanner = false;
					}
					while((reponse < 1)||(reponse > 6)){
						System.out.print("\033[1A");
						System.out.print("\033[2K");	
						reponse = 0;
						erreurScanner = true;
						while(erreurScanner){
							if (scanner.hasNextInt()){
								reponse = scanner.nextInt();
							} else {
								System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
								scanner.next();
								continue;
							}
							erreurScanner = false;
						}
					}
					switch (reponse) {
						case 1 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								i = 0;
								System.out.println("Vous possédez :\n");
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								if (Tueur_Treant) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Treant.");
								}
								if (Tueur_Golem) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Tueur_Golem.");
								}
								if (Localisation_Phoenix) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Localisation_Phoenix.");
								}
								if (Mort) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Mort.");
								}
								System.out.println("\nPlaces restantes dans l'inventaire : "+String.valueOf(place_inventaire)+"\n");
								System.out.println("Pour plus d'informations sur un objet/connaissance, saisissez son numéro.\n");
								i++;
								System.out.println(String.valueOf(i) + ". Retour au menu");
							
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								System.out.print("\033[H\033[2J");
								System.out.flush();
								
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Hache : ");
										if( true ) {
											System.out.println("Une hache bien aiguisé pour couper du bois.");
										}
									}
								} 
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pioche : ");
										if( true ) {
											System.out.println("Une pioche pour briser des roches solides.");
										}
									}
								} 
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Corde : ");
										if( true ) {
											System.out.println("Une corde légèrement élastique.");
										}
									}
								} 
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Brindille : ");
										if( true ) {
											System.out.println("Du petit bois.");
										}
									}
								} 
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Pierre : ");
										if( true ) {
											System.out.println("Un caillou bien taillé.");
										}
									}
								} 
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Lance_Pierre : ");
										if( true ) {
											System.out.println("Un lance-pierre de bonne facture, qui saura être précis.");
										}
									}
								} 
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Plume : ");
										if( true ) {
											System.out.println("La plume d'un phoénix, inutile sous sa forme actuelle. Il faut en extraire les propriétés magiques.");
										}
									}
								} 
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Antidote : ");
										if( true ) {
											System.out.println("Un antidote mystérieux.");
										}
									}
								} 
								if (Tueur_Treant) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Treant : ");
										if( true ) {
											System.out.println("Vous avez tué un tréant, c'est un haut fait !");
										}
									}
								} 
								if (Tueur_Golem) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Tueur_Golem : ");
										if( true ) {
											System.out.println("Vous avez tué un golem, c'est un haut fait !");
										}
									}
								} 
								if (Localisation_Phoenix) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Localisation_Phoenix : ");
										if( true ) {
											System.out.println("Le Phoenix passe parfois par la plaine de Valtordu.");
										}
									}
								} 
								if (Mort) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Mort : ");
										if( true ) {
											System.out.println("Le décès. Pur et irrémédiable.");
										}
									}
								} 
								i++;
								if (reponse == i) {
									continuer = false;
								} else if ((reponse >= 0)&&(reponse < i)){
									System.out.println("\n1. Retour à l'inventaire");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}		
								}
							}
							break;
						case 2 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Lieu Hutte : \n");
							System.out.println("Description du lieu :\n");
							if( true ) {
								System.out.println("Une hutte de sorcière se trouvant à l'orée de la forêt.");
							}
							System.out.println("\nObjets visibles :\n");
							if (HutteHacheDeposes > 0){
								System.out.println(String.valueOf(HutteHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
							}
							if (HuttePiocheDeposes > 0){
								System.out.println(String.valueOf(HuttePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
							}
							if (HutteCordeDeposes > 0){
								System.out.println(String.valueOf(HutteCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
							}
							if (HutteBrindilleDeposes > 0){
								System.out.println(String.valueOf(HutteBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
							}
							if (HuttePierreDeposes > 0){
								System.out.println(String.valueOf(HuttePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
							}
							if (HutteLance_PierreDeposes > 0){
								System.out.println(String.valueOf(HutteLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
							}
							if (HuttePlumeDeposes > 0){
								System.out.println(String.valueOf(HuttePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
							}
							if (HutteAntidoteDeposes > 0){
								System.out.println(String.valueOf(HutteAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
							}
							System.out.println("\nPersonnages visibles :\n");
							if (((!Mort))){
								System.out.println("Sorciere");
							}
							System.out.println("\nChemins visibles :\n");
							i = 0;
							if (true){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Un vieux panneau indique 'Orée de la forêt de Schlipak.'");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							System.out.println("\n1. Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while (reponse != 1){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							break;
						case 3 :
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("Personnages visibles :\n");
							i = 0;
							if(((!Mort))){
								i++;
								System.out.println(String.valueOf(i)+". Sorciere");
							}
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if(((!Mort))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									if(((!Localisation_Phoenix))){
										choix = "choixPremiereRencontre";
									}
									if(((Localisation_Phoenix))){
										choix = "choixSuiteRencontre";
									}
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixPremiereRencontre":
												if( true ) {
													System.out.println("Bonjour mon cher. Il me faudrait une plume de phoenix pour concocter cette antidote mystique.\n On en trouve au niveau de la plaine, pourriez-vous m'en rapportez une ?");
												}
												System.out.println("\n");
												i = 0;
												if(((Plume > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("J'en ai déjà sur moi, tenez.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Je vais vous en chercher. À plus tard.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(((Plume > 0))){
													i++;
													if(reponse == i){
														choix = "choixPlumeDonnee";
														System.out.println("");
														Plume -= 1;
														place_inventaire += 1*1;
														System.out.println("Vous perdez 1 objet(s) Plume");
														System.out.println("");
														if(true){
															if (1 * 1 <= place_inventaire ){
																Antidote += 1;
																place_inventaire -= 1*1;
																System.out.println("Vous recevez 1 objet(s) Antidote");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 1 objet(s) Antidote");
															}
														}
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixRecherchePhoenix";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Localisation_Phoenix)){
																Localisation_Phoenix = true;
																System.out.println("Vous recevez la connaissance Localisation_Phoenix");
															}
														}
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixSuiteRencontre":
												if( true ) {
													System.out.println("Rebonjour mon cher. Avez-vous trouvez une plume de phoenix ?");
												}
												System.out.println("\n");
												i = 0;
												if(((Plume > 0))){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("J'en ai trouvé, tenez.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Pas encore, à plus tard.");
													}
													System.out.println("");
												}
											if(false){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
												if(((Plume > 0))){
													i++;
													if(reponse == i){
														choix = "choixPlumeDonnee";
														System.out.println("");
														Plume -= 1;
														place_inventaire += 1*1;
														System.out.println("Vous perdez 1 objet(s) Plume");
														System.out.println("");
														if(true){
															if (1 * 1 <= place_inventaire ){
																Antidote += 1;
																place_inventaire -= 1*1;
																System.out.println("Vous recevez 1 objet(s) Antidote");
															} else {
																System.out.println("Votre inventaire étant trop limité, vous perdez 1 objet(s) Antidote");
															}
														}
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "choixRecherchePhoenix";
														System.out.println("");
														
														System.out.println("");
														
														System.out.println("\n");
													}
												}
											if(false){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixRecherchePhoenix":
												if( true ) {
													System.out.println("Bonne chance.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
											case "choixPlumeDonnee":
												if( true ) {
													System.out.println("Merci beaucoup. Tenez, une dose d'antidote pour vous remercier.");
												}
												System.out.println("\n");
												i = 0;
											if(true){
													i++;
													System.out.println("\n"+String.valueOf(i)+". Quitter l'interaction");
												}
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
												while((reponse < 1)||(reponse > i)){
													System.out.print("\033[1A");
													System.out.print("\033[2K");
													reponse = 0;
													erreurScanner = true;
													while(erreurScanner){
														if (scanner.hasNextInt()){
															reponse = scanner.nextInt();
														} else {
															System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
															scanner.next();
															continue;
														}
														erreurScanner = false;
													}
												}
												i = 0;
											if(true){
													i++;
													if(reponse == i){
														continuer = false;
													}
												}
											break;
										}
									}
									break;
								}
							}
							break;
						case 4:
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Objets ramassables :\n");
								i = 0;
								if (HutteHacheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HutteHacheDeposes) + " objet(s) Hache déposé(s) par vous, de taille 4");
								}
								if (HuttePiocheDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HuttePiocheDeposes) + " objet(s) Pioche déposé(s) par vous, de taille 4");
								}
								if (HutteCordeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HutteCordeDeposes) + " objet(s) Corde déposé(s) par vous, de taille 1");
								}
								if (HutteBrindilleDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HutteBrindilleDeposes) + " objet(s) Brindille déposé(s) par vous, de taille 1");
								}
								if (HuttePierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HuttePierreDeposes) + " objet(s) Pierre déposé(s) par vous, de taille 1");
								}
								if (HutteLance_PierreDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HutteLance_PierreDeposes) + " objet(s) Lance_Pierre déposé(s) par vous, de taille 2");
								}
								if (HuttePlumeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HuttePlumeDeposes) + " objet(s) Plume déposé(s) par vous, de taille 1");
								}
								if (HutteAntidoteDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(HutteAntidoteDeposes) + " objet(s) Antidote déposé(s) par vous, de taille 1");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous ramasser?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (HutteHacheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HutteHacheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HutteHacheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Hache += reponse;
											HutteHacheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (HuttePiocheDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HuttePiocheDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HuttePiocheDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*4) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pioche += reponse;
											HuttePiocheDeposes -= reponse;
											place_inventaire -= reponse*4;
											reponse = i;
										}
									}
								}
								if (HutteCordeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HutteCordeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HutteCordeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Corde += reponse;
											HutteCordeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (HutteBrindilleDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HutteBrindilleDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HutteBrindilleDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Brindille += reponse;
											HutteBrindilleDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (HuttePierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HuttePierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HuttePierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Pierre += reponse;
											HuttePierreDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (HutteLance_PierreDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HutteLance_PierreDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HutteLance_PierreDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*2) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Lance_Pierre += reponse;
											HutteLance_PierreDeposes -= reponse;
											place_inventaire -= reponse*2;
											reponse = i;
										}
									}
								}
								if (HuttePlumeDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HuttePlumeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HuttePlumeDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Plume += reponse;
											HuttePlumeDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								if (HutteAntidoteDeposes > 0){
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous ramasser?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										boolean continuer2 = true;
										while(continuer2){
											if ((reponse < 0)||(reponse > HutteAntidoteDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(HutteAntidoteDeposes));
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else if ((place_inventaire - reponse*1) < 0){
												System.out.println("Vous n'avez pas assez de place dans votre inventaire, veuillez choisir une autre quantité.");
												reponse = 0;
												erreurScanner = true;
												while(erreurScanner){
													if (scanner.hasNextInt()){
														reponse = scanner.nextInt();
													} else {
														System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
														scanner.next();
														continue;
													}
													erreurScanner = false;
												}
											} else {
												continuer2 = false;
											}
										}
										if (reponse != 0){
											Antidote += reponse;
											HutteAntidoteDeposes -= reponse;
											place_inventaire -= reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Ramasser un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 5 :
							continuer = true;
							while(continuer){
								System.out.print("\033[H\033[2J");
								System.out.flush();
								System.out.println("Vous possédez :\n");
								i = 0;
								if (Hache > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Hache) + " fois l'objet Hache, de taille 4.");
								}
								if (Pioche > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pioche) + " fois l'objet Pioche, de taille 4.");
								}
								if (Corde > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Corde) + " fois l'objet Corde, de taille 1.");
								}
								if (Brindille > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Brindille) + " fois l'objet Brindille, de taille 1.");
								}
								if (Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Pierre) + " fois l'objet Pierre, de taille 1.");
								}
								if (Lance_Pierre > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Lance_Pierre) + " fois l'objet Lance_Pierre, de taille 2.");
								}
								if (Plume > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Plume) + " fois l'objet Plume, de taille 1.");
								}
								if (Antidote > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Antidote) + " fois l'objet Antidote, de taille 1.");
								}
								i++;
								System.out.println("\nQuel objet souhaitez-vous déposer?\n");
								System.out.println(String.valueOf(i)+". Retour au menu\n");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
								while((reponse < 1)||(reponse > i)){
									System.out.print("\033[1A");
									System.out.print("\033[2K");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
								}
								i = 0;
								if (Hache > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Hache)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Hache));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Hache -= reponse;
											HutteHacheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Pioche > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pioche)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pioche));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pioche -= reponse;
											HuttePiocheDeposes += reponse;
											place_inventaire += reponse*4;
											reponse = i;
										}
									}
								}
								if (Corde > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Corde)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Corde));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Corde -= reponse;
											HutteCordeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Brindille > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Brindille)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Brindille));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Brindille -= reponse;
											HutteBrindilleDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Pierre -= reponse;
											HuttePierreDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Lance_Pierre > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Lance_Pierre)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Lance_Pierre));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Lance_Pierre -= reponse;
											HutteLance_PierreDeposes += reponse;
											place_inventaire += reponse*2;
											reponse = i;
										}
									}
								}
								if (Plume > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Plume)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Plume));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Plume -= reponse;
											HuttePlumeDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								if (Antidote > 0) {
									i++;
									if (reponse == i){
										System.out.println("\nQuelle quantité voulez-vous déposer?\n");
										System.out.println("\n0. Annuler\n");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while((reponse < 0)||(reponse > Antidote)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Antidote));
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}	
										if (reponse != 0) {
											Antidote -= reponse;
											HutteAntidoteDeposes += reponse;
											place_inventaire += reponse*1;
											reponse = i;
										}
									}
								}
								i++;
								if (reponse == i){
									continuer = false;
								} else if (reponse != 0) {
									System.out.println("\n"+String.valueOf(place_inventaire) + " place(s) disponibles dans l'inventaire\n");
									System.out.println("1. Déposer un autre objet");
									System.out.println("2. Retour au menu");
									reponse = 0;
									erreurScanner = true;
									while(erreurScanner){
										if (scanner.hasNextInt()){
											reponse = scanner.nextInt();
										} else {
											System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
											scanner.next();
											continue;
										}
										erreurScanner = false;
									}
									while((reponse < 1)||(reponse > 2)){
										System.out.print("\033[1A");
										System.out.print("\033[2K");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
									}
									if (reponse == 2){continuer = false;}
								}
							}
							break;
						case 6:
							System.out.print("\033[H\033[2J");
							System.out.flush();
							System.out.println("\nChemins empruntables :\n");
							i = 0;
							if (true){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Un vieux panneau indique 'Orée de la forêt de Schlipak.'");
									}
									System.out.println("");
								}
							}
							System.out.println("\nChoisissez un chemin");
							i++;
							System.out.println("\n"+String.valueOf(i)+". Retour au menu");
							reponse = 0;
							erreurScanner = true;
							while(erreurScanner){
								if (scanner.hasNextInt()){
									reponse = scanner.nextInt();
								} else {
									System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
									scanner.next();
									continue;
								}
								erreurScanner = false;
							}
							while((reponse < 1)||(reponse > i)){
								System.out.print("\033[1A");
								System.out.print("\033[2K");
								reponse = 0;
								erreurScanner = true;
								while(erreurScanner){
									if (scanner.hasNextInt()){
										reponse = scanner.nextInt();
									} else {
										System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
										scanner.next();
										continue;
									}
									erreurScanner = false;
								}
							}
							i = 0;
							if (true){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.PLAINE;
										System.out.println("Vous arrivez dans le lieu Plaine");
										System.out.println("\n1. Continuer");
										reponse = 0;
										erreurScanner = true;
										while(erreurScanner){
											if (scanner.hasNextInt()){
												reponse = scanner.nextInt();
											} else {
												System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
												scanner.next();
												continue;
											}
											erreurScanner = false;
										}
										while(reponse != 1){
											reponse = 0;
											erreurScanner = true;
											while(erreurScanner){
												if (scanner.hasNextInt()){
													reponse = scanner.nextInt();
												} else {
													System.out.println("Commande invalide : veuillez uniquement entrer des entiers.");
													scanner.next();
													continue;
												}
												erreurScanner = false;
											}
										}
									}
								}
							}
							break;
					}
					break;
			}
		}
		scanner.close();
	}
}

