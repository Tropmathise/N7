import org.junit.*;
import static org.junit.Assert.*;
import java.awt.Color;

/** Programme de test de la classe Cercle.
  * @author	Thomas Sadurni
  */

public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.00001;

	// Les points du sujet
	private Point A, B, C, D, E;

	// Les cercles du sujet
	private Cercle C1, C2;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 2);
		B = new Point(2, 1);
		C = new Point(4, 1);
		D = new Point(8, 1);
		E = new Point(8, 4);

		// Construire les cercles
		C1 = new Cercle(A, 2.5);
		C2 = new Cercle(new Point(6, 1), 2);
		C2.setCouleur(Color.yellow);
	}

	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test //test E12 : prenons deux points comme test
	public void testE12() {
		Cercle Cercle3 = new Cercle(new Point(1, 1), new Point (1, 3));
		memesCoordonnees("E12", new Point(1, 2), Cercle3.getCentre());
		assertEquals("E12 : les rayons ne sont pas les mêmes.", 1, Cercle3.getRayon(), EPSILON);
		assertEquals("E12 : les diamètres ne sont pas les mêmes.", 2, Cercle3.getDiametre(), EPSILON);
        assertEquals("E12 : les couleurs ne sont pas les mêmes.", Color.blue, Cercle3.getCouleur());
		//assertTrue("E12", Cercle3.contient(C));
		//assertTrue("E12", Cercle3.contient(D));
		//assertFalse("E12", Cercle3.contient(E));
		System.out.println("Tous les tests passent, la condition E12 est bien vérifiée.");
	}

	@Test //test E13 : prenons les points C et D comme test
	public void testE13() {
		Cercle Cercle4 = new Cercle(C, D, Color.yellow);
        memesCoordonnees("E13", new Point(6, 1), Cercle4.getCentre());
		assertEquals("E13 : les couleurs ne sont pas les mêmes.", Color.yellow, Cercle4.getCouleur());
		assertEquals("E13 : les rayons ne sont pas les mêmes.", 2, Cercle4.getRayon(), EPSILON);
		assertEquals("E13 : les diamètres ne sont pas les mêmes.", 4, Cercle4.getDiametre(), EPSILON);
		//assertTrue("E13", Cercle4.contient(C));
		//assertTrue("E13", Cercle4.contient(D));
		//assertFalse("E13", Cercle4.contient(E));
		System.out.println("Tous les tests passent, la condition E13 est bien vérifiée.");
	}

	@Test //test E14 : prenons deux nouveaux points comme test
	public void testE14() {
		Cercle Cercle5 = Cercle.creerCercle(D, E);
		memesCoordonnees("E14", new Point(8, 1), Cercle5.getCentre());
        assertEquals("E14 : les couleurs ne sont pas les mêmes.", Color.blue, Cercle5.getCouleur());
		assertEquals("E14 : les rayons ne sont pas les mêmes.", 3, Cercle5.getRayon(), EPSILON);
		assertEquals("E14 : les diamètres ne sont pas les mêmes.", 6, Cercle5.getDiametre(), EPSILON);
		//assertTrue("E14", Cercle5.contient(E));
		//assertTrue("E14", Cercle5.contient(D));
		//assertFalse("E14", Cercle5.contient(C));
		System.out.println("Tous les tests passent, la condition E14 est bien vérifiée.");
	}
}
