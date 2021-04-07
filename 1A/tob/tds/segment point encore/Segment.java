/** Définition d'un segment.
 * @author  Xavier Crégut
 * @has * "" "2\nextrémité1, extrémité2" Point
 * @depend - <instantiate> - Segment.MajLongueur
 */
public class Segment {
	private Point extremite1;
	private Point extremite2;
	private double longueur;
	/** @hidden */
	private Observateur majLongueur;

	/**  Construire un Segment à partir de ses deux points extremité.
	  *  @param ext1	le premier point extrémité
	  *  @param ext2	le deuxième point extrémité */
	public Segment(Point ext1, Point ext2) {
		this.extremite1 = ext1;
		this.extremite2 = ext2;
		this.majLongueur();

		// S'inscrire auprès des points extrémités
		this.majLongueur = this.new MajLongueur();	// this. peut être omis ici.
		this.extremite1.inscrire(majLongueur);
		this.extremite2.inscrire(majLongueur);
	}

	/** Longueur du segment. */
	public double getLongueur() {
		return this.longueur;
	}

	/** Translater le segment.
	  * @param dx déplacement suivant l'axe des X
	  * @param dy déplacement suivant l'axe des Y */ 
	public void translater(double dx, double dy) {
		this.extremite1.translater(dx, dy);
		this.extremite2.translater(dx, dy);
	}

	/** Afficher le segment. */
	public void afficher() {
		System.out.print("[");
		this.extremite1.afficher();
		System.out.print(";");
		this.extremite2.afficher();
		System.out.print("]");
	}

	/** Mettre à jour la longueur du segment */
	private void majLongueur() {
		// Afficher une trace quand la longueur est recalculée
		System.out.print("majLongueur() sur " + this + " : ");
		this.afficher();
		System.out.println();

		this.longueur = this.extremite1.distance(this.extremite2);
	}

	/** Détruire le segment (destructeur). */
	public void detruire() {
		this.extremite1.annuler(majLongueur);
		this.extremite2.annuler(majLongueur);
	}

	/** Observateur chargé de mettre à jour la longueur d'un segment.  */
	private class MajLongueur implements Observateur {

		// Une classe interne (non static) a directement accès aux
		// variables d'instances de la classe englobante.  Une
		// instance de MajLongueur est associé à l'instance de
		// Segment à partir de laquelle il a été créé.

		public void maj(Point source, double dx, double dy) {
			Segment.this.majLongueur(); // Segment.this. peut être omis ici.
		}
	}

}
