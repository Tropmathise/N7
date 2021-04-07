/** Programme de test du Cercle.
  * @author	Xavier Crégut
  */
public class TestCercle {

	public static void main(String[] args) {
		Point centre = new Point(0, 0);
		Point circonference = new Point(5, 0);
		Cercle cercle = new Cercle(centre, circonference);
		System.out.print("cercle = "); cercle.afficher(); System.out.println();
		centre.translater(0, 5);
		System.out.print("cercle = "); cercle.afficher(); System.out.println();
		circonference.translater(5, 0);
		System.out.print("cercle = "); cercle.afficher(); System.out.println();
		cercle.detruire();
	}
}
