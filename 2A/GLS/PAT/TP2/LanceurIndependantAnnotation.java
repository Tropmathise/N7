import java.lang.reflect.*;
import java.util.*;
import java.lang.annotation.*;

public class LanceurIndependantAnnotation {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private int nbIgnores;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependantAnnotation(String... nomsClasses) {
		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
			try {
				System.out.print(nom + " : ");
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (Exception e) {
				System.out.println(" ProblÃ¨me : " + e);
				System.out.println(e);
			}
		}

		// Afficher les erreurs
		for (Throwable e : erreurs) {
			System.out.println();
			if (e != null) {
				e.printStackTrace();
			}
		}

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancÃ©s dont %d Ã©checs et %d erreurs, %d ignorÃ©s.\n",
				nbTestsLances, nbEchecs, nbErreurs, nbIgnores);
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


	/** Retourne les mÃ©thodes publiques et les annotations associÃ©es qui ont le type d'annotation spÃ©cifiÃ©.
	  * @param c la classe oÃ¹ chercher la mÃ©thode
	  * @param annotationType l'annotation recherchÃ©e
	  * @return ...
	  */
	static private <T extends Annotation> Map<Method, T> getMethodesAnnotees(Class<?> c, Class<? extends T> annotationType) {
		Map<Method, T> methods = new HashMap<>();
		for (Method m: c.getMethods()) {
			/*
			T[] annotations = m.getAnnotationsByType(annotationType);
			if (annotations.length != 0) {
				methods.put(m, annotations[0]);	// Il n'y en a qu'une.
				assert annotations.length == 1;
			}
			*/
			T annotation = m.getAnnotation(annotationType);	// Il n'y en a qu'une.
			if (annotation != null) {
				methods.put(m, annotation);
			}
		}
		return methods;
	}

	static private <T extends Annotation> Method getMethodeAnnotee(Class<?> c, Class<? extends T> annotationType) {
		Map<Method, T> methods = getMethodesAnnotees(c,
				annotationType);
		Iterator<Method> it = methods.keySet().iterator();
		if (it.hasNext()) {
			return it.next();
		} else {
			return null;
		}
	}



	private void executerUnTest(Object recepteur, Method preparer, Method nettoyer,
			Method tester) throws IllegalAccessException, InvocationTargetException
	{
		try {
			if (preparer != null) {
				preparer.invoke(recepteur);
			}
			tester.invoke(recepteur);
		} finally {
			if (nettoyer != null) {
				nettoyer.invoke(recepteur);
			}
		}
		// XXX : Si une exception se produit lors de l'exÃ©cution des mÃ©thodes
		// preparer(), tester() ou nettoyer() sont encaptsulÃ©e dans
		// InvocationTargetException.  On pourrait la rÃ©cupÃ©rer dans e et faire
		// un throw e.getCause().  Mais il faurait alors dans la signature
		// mettre un throws Throwable.
	}


	private void executerUnTestAvecException(Object recepteur, Method preparer, Method nettoyer,Method tester, Class<?> expected) throws IllegalAccessException, InvocationTargetException
	{
			try {
				if (preparer != null) {
					preparer.invoke(recepteur);
				}
				String message = null;	// OK
				try {
					tester.invoke(recepteur);
					message = "No exception but " + expected.getName() + " expected";
				} catch (InvocationTargetException e) {
					if (e.getCause().getClass().equals(expected)) {
						// OK
					} else {
						message = "expected exception: " + expected.getName() + " != raised exception: " + e.getCause().getClass().getName();
					}
				}
				if (message != null) {
					throw new InvocationTargetException(new Echec(message));
				}
			} finally {
				if (nettoyer != null) {
					nettoyer.invoke(recepteur);
				}
			}
	}


	private void testerUneClasse(String nomClasse)
		throws ClassNotFoundException, InstantiationException,
						  IllegalAccessException
	{

		// RÃ©cupÃ©rer la classe
		Class<?> classe = Class.forName(nomClasse);

		// RÃ©cupÃ©rer les mÃ©thodes "preparer" et "nettoyer"
		Method preparer = getMethodeAnnotee(classe, Avant.class);
		Method nettoyer = getMethodeAnnotee(classe, Apres.class);

		// Instancier l'objet qui sera le rÃ©cepteur des tests
		Object objet = classe.newInstance();
			// On sait qu'il doit y avoir un constucteur par dÃ©faut.
			// Sinon, il faudrait rÃ©cupÃ©rer un constructeur et appliquer
			// newInstance dessus.

		// ExÃ©cuter les mÃ©thods de test
		for (Map.Entry<Method, UnTest> ma : getMethodesAnnotees(classe, UnTest.class).entrySet()) {
			Method m = ma.getKey();
			UnTest a = ma.getValue();
			if (m.getParameterTypes().length == 0
					&& ! Modifier.isStatic(m.getModifiers()))
			{
				boolean echec = true;
				try {
					nbTestsLances++;
					if (a.enabled()) {
						if (a.expected() == UnTest.NoException.class) {
							executerUnTest(objet, preparer, nettoyer, m);
						} else {
							// System.out.println("Not implemented yet!");
							executerUnTestAvecException(objet, preparer, nettoyer, m, a.expected());
						}
					} else {
						System.out.print('-');
						this.nbIgnores++;
					}
					echec = false;
				} catch (InvocationTargetException e) {
					// L'exception qui s'est vraiment produite lors de l'appel
					// des mÃ©thodes preparer(), tester() ou nettoyer() est
					// associÃ©e Ã  InvocationTargetException.  On la retrouve en
					// faisant getCause().
					if (e.getCause() instanceof Echec) {
						nbEchecs++;
					} else {
						nbErreurs++;
					}
					erreurs.add(e.getCause());
				} catch (Throwable e) {
					nbErreurs++;
					erreurs.add(e.getCause());
				} finally {
					if (echec) {
						System.out.print('F');
					} else {
						System.out.print('.');
					}
				}
			}
			else {
				throw new RuntimeException("Une mÃ©thode de test doit Ãªtre d'instance et sans paramÃ¨tre : " + m);
			}
		}
	}

	public static void main(String... args) {
		LanceurIndependantAnnotation lanceur = new LanceurIndependantAnnotation(args);
	}

}
