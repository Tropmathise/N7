/** Définition d'un point.
 * @author  Xavier Crégut
 * @composed 1 "" "1 observateurs" GroupeObservateurs
 */
public class Point {
	private double x;		// abscisse
	private double y;		// ordonnée
	/** @hidden */
	private GroupeObservateurs observateurs; // à mettre à jour quand le point change

	/**  Construction d'un point à partir de son abscisse et de son ordonnée.
	  *  @param	x	abscisse
	  *  @param	y	ordonnée */
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
		this.observateurs = new GroupeObservateurs();
	}

	/** Abscisse du point. */
	public double getX() {
		return this.x;
	}

	/** Ordonnée du point. */
	public double getY() {
		return this.y;
	}

	/** Distance par rapport à un autre point.  */
	public double distance(Point autre) {
		return Math.sqrt(Math.pow(autre.x - this.x, 2)
					+ Math.pow(autre.y - this.y, 2));
	}

   /** Translater le point.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y */
	public void translater(double dx, double dy) {
		this.x += dx;
		this.y += dy;
		this.observateurs.maj(this, dx, dy);
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + this.x + "," + this.y + ")");
	}

	/** Inscrire le segment s auprès du point. */
	//@ requires s != null;
	public void inscrire(Observateur s) {
		this.observateurs.ajouter(s);
	}

	/** Annuler l'inscription d'un observateur. */
	public void annuler(Observateur s) {
		this.observateurs.supprimer(s);
	}
}
