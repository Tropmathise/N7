
import java.util.Scanner;

public class GameEnigme {

	enum Lieux {ENIGME, SUCCES, ECHEC};

	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		boolean erreurScanner;
		int reponse = 0;
		boolean continuer;
		int i;
		// Objets
		int Tentative = 0;
		int EnigmeTentative = 0;
		int EnigmeTentativeDeposes = 0;
		int SuccesTentative = 0;
		int SuccesTentativeDeposes = 0;
		int EchecTentative = 0;
		int EchecTentativeDeposes = 0;
		// Connaissances
		boolean Reussite = false;
		// Lieu
		Lieux localisation = Lieux.ENIGME;
		// Inventaire
		int place_inventaire = 3;
		Tentative = 3;
		place_inventaire -= 1*3;
		// Objets Lieux
		
		boolean fin = false;
		while (!fin) {
			switch (localisation) {
				case ENIGME :
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
								if (Tentative > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Tentative) + " fois l'objet Tentative, de taille 1.");
								}
								if (Reussite) {
									i++;
									System.out.println(String.valueOf(i) + ". La connaissance Reussite.");
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
								if (Tentative > 0) {
									i++;
									if (reponse == i){
										System.out.print("objet Tentative : ");
										if( true ) {
											System.out.println("Une tentative de réponse");
										}
									}
								} 
								if (Reussite) {
									i++;
									if (reponse == i){
										System.out.print("connaissance Reussite : ");
										if( true ) {
											System.out.println("Obtenue lors d'une bonne réponse");
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
							System.out.println("Lieu Enigme : \n");
							System.out.println("Description du lieu :\n");
							if( true ) {
								System.out.println("Vous vous trouvez dans la salle Énigme.");
							}
							System.out.println("\nObjets visibles :\n");
							if (EnigmeTentativeDeposes > 0){
								System.out.println(String.valueOf(EnigmeTentativeDeposes) + " objet(s) Tentative déposé(s) par vous, de taille 1");
							}
							System.out.println("\nPersonnages visibles :\n");
							if (((Tentative > 0)&&(!Reussite))){
								System.out.println("Sphinx");
							}
							System.out.println("\nChemins visibles :\n");
							i = 0;
							if (((Reussite))){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Le chemin vers la réussite");
								}
								if (true){System.out.println("Ce chemin est ouvert\n");}
								else {System.out.println("Ce chemin est fermé\n");}
							}
							if (((Tentative == 0))){
								i++;
								System.out.print("Chemin "+String.valueOf(i)+" : ");
								if( true ) {
									System.out.println("Le chemin vers la défaite");
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
							if(((Tentative > 0)&&(!Reussite))){
								i++;
								System.out.println(String.valueOf(i)+". Sphinx");
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
							if(((Tentative > 0)&&(!Reussite))){
								i++;
								if(reponse == i){
									System.out.print("\033[H\033[2J");
									System.out.flush();
									
									String choix = "";
									choix = "choixEnigme";
									continuer = true;
									while(continuer){
										switch(choix){
											case "choixEnigme":
												if( true ) {
													System.out.println("Je vais te poser une énigme. Quelle pile de linge a été lavée avec Olympe, la lessive des Dieux !");
												}
												System.out.println("\n");
												i = 0;
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Celle de gauche, elle est plus soyeuse, plus parfumée.");
													}
													System.out.println("");
												}
												if(true){
													i++;
													System.out.print(String.valueOf(i)+". ");
													if( true ) {
														System.out.println("Celle de droite, elle est plus douce, plus souple.");
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
														choix = "ChoixMauvaiseReponse";
														System.out.println("");
														Tentative -= 1;
														place_inventaire += 1*1;
														System.out.println("Vous perdez 1 objet(s) Tentative");
														System.out.println("");
														
														System.out.println("\n");
													}
												}
												if(true){
													i++;
													if(reponse == i){
														choix = "ChoixBonneReponse";
														System.out.println("");
														
														System.out.println("");
														if(true){
															if(!(Reussite)){
																Reussite = true;
																System.out.println("Vous recevez la connaissance Reussite");
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
											case "ChoixMauvaiseReponse":
												if( true ) {
													System.out.println("Mauvaise réponse");
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
											case "ChoixBonneReponse":
												if( true ) {
													System.out.println("OOOOOOOOUUIIIIII ! Il a réussi !");
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
								if (EnigmeTentativeDeposes > 0){
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(EnigmeTentativeDeposes) + " objet(s) Tentative déposé(s) par vous, de taille 1");
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
								if (EnigmeTentativeDeposes > 0){
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
											if ((reponse < 0)||(reponse > EnigmeTentativeDeposes)) {
												System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(EnigmeTentativeDeposes));
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
											Tentative += reponse;
											EnigmeTentativeDeposes -= reponse;
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
								if (Tentative > 0) {
									i++;
									System.out.println(String.valueOf(i) + ". " + String.valueOf(Tentative) + " fois l'objet Tentative, de taille 1.");
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
								if (Tentative > 0) {
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
										while((reponse < 0)||(reponse > Tentative)){
											System.out.println("Quantité invalide, veuillez donner un entier entre 0 et "+String.valueOf(Tentative));
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
											Tentative -= reponse;
											EnigmeTentativeDeposes += reponse;
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
							if (((Reussite))){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Le chemin vers la réussite");
									}
									System.out.println("");
								}
							}
							if (((Tentative == 0))){
								if (true){
									i++;
									System.out.print("Chemin "+String.valueOf(i)+" : ");
									if( true ) {
										System.out.println("Le chemin vers la défaite");
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
							if (((Reussite))){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.SUCCES;
										System.out.println("Vous arrivez dans le lieu Succes");
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
							if (((Tentative == 0))){
								if (true){
									i++;
									if(reponse == i){
										System.out.println("");
										
										System.out.println("");
										
										System.out.println("");
										localisation = Lieux.ECHEC;
										System.out.println("Vous arrivez dans le lieu Echec");
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
				case SUCCES :
					if( true ) {
						System.out.println("Bravo vous avez gagné !");
					}
					fin = true;
					break;
				case ECHEC :
					if( true ) {
						System.out.println("Bravo vous avez réussi à répondre 3 fois faux alors qu'il n'y avait que 2 choix ! Vous entrez dans le Panthéon.");
					}
					fin = true;
					break;
			}
		}
		scanner.close();
	}
}

