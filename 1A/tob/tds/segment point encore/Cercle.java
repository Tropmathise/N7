/** Réprésentation d'un cercle construit à partir de deux points de contrôle,
  * son centre et un point de sa circonférence.  Si son centre est translaté, le
  * cercle est translaté.  Si le point de sa circonférence est translaté, le
  * rayon du cercle change.
  * @has * - "2\ncentre, circonférence" Point
 * @depend - <instantiate> - Cercle.Translater
 * @depend - <instantiate> - Cercle.Redimmensionner
  * @author	Xavier Crégut
  */
public class Cercle {
	/* On décide de stocker le rayon du cercle. */

	/** Le centre du cercle */
	private Point centre;

	/** Le rayon du cercle */
	private double rayon;

	/** Un point de la circonférence du cercle */
	private Point circonference;

	private Observateur translaterObservateur;
	private Observateur redimensionnerObservateur;

	/* Construire un cercle à partir de son centre et d'un point de sa
	 * circonférence.
	 */
	public Cercle(Point centre, Point circonference) {
		this.centre = centre;
		this.circonference = circonference;
		this.majRayon();

		// S'inscrire auprès des deux points
		this.translaterObservateur = new Translater();
		this.centre.inscrire(this.translaterObservateur);
		this.redimensionnerObservateur = new Redimmensionner();
		this.circonference.inscrire(this.redimensionnerObservateur);
	}

	/** Le destructeur. */
	public void detruire() {
		this.centre.annuler(this.translaterObservateur);
		this.circonference.annuler(this.redimensionnerObservateur);
	}

	/** Le rayon du cercle. */
	public double getRayon() {
		return this.rayon;
	}

	/** Afficher le cercle. */
	public void afficher() {
		System.out.print("Cercle(");
		this.centre.afficher();
		System.out.print(";");
		System.out.print(this.rayon);
		System.out.print(")");
	}

   /** Translater le cercle.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
		this.centre.translater(dx, dy);
		this.circonference.translater(dx, dy);
	}

	/** Le périmètre du cercle. */
	public double getPerimetre() {
		return 2 * Math.PI * this.rayon;
	}

	/** La surface du cercle. */
	public double getSurface() {
		return Math.PI * this.rayon * this.rayon;
	}

	private void majRayon() {
		this.rayon = this.centre.distance(this.circonference);
	}

	/** Translater le point de la circonférence. */
	private class Translater implements Observateur {
		public void maj(Point source, double dx, double dy) {
			circonference.translater(dx, dy);
		}
	}

	/** Redimmensionner le cercle. */
	private class Redimmensionner implements Observateur {
		public void maj(Point source, double dx, double dy) {
			majRayon();
		}
	}

}
