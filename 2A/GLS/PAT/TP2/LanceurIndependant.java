import java.lang.reflect.*;
import java.util.*;

/** L'objectif est de faire un lanceur simple sans utiliser toutes les clases
  * de notre architecture JUnit.   Il permet juste de valider la compréhension
  * de l'introspection en Java.
  */
public class LanceurIndependant {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependant(String... nomsClasses) {
	    System.out.println();

		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
			try {
				System.out.print(nom + " : ");
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (Exception e) {
				System.out.println(" Problème : " + e);
				e.printStackTrace();
			}
		}

		// Afficher les erreurs
		for (Throwable e : erreurs) {
			System.out.println();
			e.printStackTrace();
		}

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n",
				nbTestsLances, nbEchecs, nbErreurs);
	}


	public int getNbTests() {
		return this.nbTestsLances;
	}


	public int getNbErreurs() {
		return this.nbErreurs;
	}


	public int getNbEchecs() {
		return this.nbEchecs;
	}


	private void testerUneClasse(String nomClasse)
		throws ClassNotFoundException, InstantiationException,
						  IllegalAccessException
	{
		// Récupérer la classe
		Class<?> classRecup = Class.forName(nomClasse);
		// Récupérer les méthodes "preparer" et "nettoyer"
		Method preparer;
		Method nettoyer;
		try {
			preparer = classRecup.getMethod("preparer");
		} catch (NoSuchMethodException e) {
			System.out.print("Pas de methode au nom preparer\n");
			preparer=null;
		}
		try {
			nettoyer = classRecup.getMethod("nettoyer");
		} catch (NoSuchMethodException e) {
			System.out.print("Pas de methode au nom nettoyer\n");
			nettoyer = null;
		}

		// Instancier l'objet qui sera le récepteur des tests
		Object objet = classRecup.newInstance();

		// Exécuter les méthods de test

		Method[] methodesTest = classRecup.getMethods();
		for (Method methode : methodesTest){
			if (methode.getName().startsWith("test")){
				this.nbTestsLances++;
				try {
					if(preparer != null){
						try{
							preparer.invoke(objet);
						} catch (InvocationTargetException e){
							System.out.print("Invocation exception : preparer");
							e.getCause();
						} catch (IllegalAccessException e){
							System.out.print("Access exception : preparer");
						}
					}
					try{
						methode.invoke(objet);
					} catch (InvocationTargetException e){
						System.out.print("Invocation exception : methode test");
						e.getCause();
					} catch (IllegalAccessException e){
						System.out.print("Access exception : methode test");
					}
					if (nettoyer != null){
						try{
							nettoyer.invoke(objet);
							System.out.println("test");
						}catch (InvocationTargetException e){
							System.out.print("Invocation exception : nettoyer");
							e.getCause();
						}catch (IllegalAccessException e){
							System.out.print("Access exception : nettoyer");
						}
					}
				} catch (Echec e){
					this.nbEchecs++;
					System.out.println("Echec");
				} catch(Throwable e){
					this.nbErreurs++;
					this.erreurs.add(e);
				}
			}
		}
	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
	}

}
