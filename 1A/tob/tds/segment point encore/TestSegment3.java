/** Programme de Test de la classe Segment.
 * @author  Xavier Crégut
 * @hidden
 */
public class TestSegment3 {
	public static void main(String[] args) {
		Point p1 = new Point(1, 2);

		for (int i = 0; i < 100; i++) {
			Segment s = new Segment(new Point(i, i), p1);
			s.detruire();
		}

		System.out.println("Translation !");
		p1.translater(10, 0);
		System.out.println("Fin !");
}	}
