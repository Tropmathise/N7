/** Programme de Test de la classe Segment.
 * @author  Xavier Crégut
 * @hidden
 */
public class TestSegment2 {
	public static void main(String[] args) {
		Point p1 = new Point(0, 0);
		Point p2 = new Point(5, 0);
		Point p3 = new Point(10, 0);
		Segment s1 = new Segment(p1, p2);
		Segment s2 = new Segment(p2, p3);

		System.out.print("p2 = ");  p2.afficher();  System.out.println();
		System.out.print("s1 = ");  s1.afficher();   System.out.println();
		System.out.println("longueur de s1 = " + s1.getLongueur());
		System.out.print("s2 = ");  s2.afficher();   System.out.println();
		System.out.println("longueur de s2 = " + s2.getLongueur());

		p2.translater(-2, 0);

		System.out.print("p2 = ");  p2.afficher();  System.out.println();
		System.out.print("s1 = ");  s1.afficher();   System.out.println();
		System.out.println("longueur de s1 = " + s1.getLongueur());
		System.out.print("s2 = ");  s2.afficher();   System.out.println();
		System.out.println("longueur de s2 = " + s2.getLongueur());
	}
}
