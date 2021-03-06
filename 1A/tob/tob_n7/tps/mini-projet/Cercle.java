import java.awt.Color;

/** Un cercle est une courbe plane fermée constituée des points
  * situés à égale distance d’un point nommé centre.
  * La valeur de cette distance est appelée rayon du cercle.
  * On appelle diamètre la distance entre deux points diamétralement opposés.
  * La valeur du diamètre est donc le double de la valeur du rayon.
  * @author 	Thomas SADURNI
  */

public class Cercle implements Mesurable2D {
    /** Centre du cercle. */
    private Point centre;

    /** Rayon du cercle. */
    private double rayon;

    /** Couleur du cercle. */
    private Color couleur;

    /** Constante PI. */
	public static final double PI = Math.PI;

    /** Construire un cercle bleu à partir de son centre et de son rayon. (E11)
     * @param vC centre du centre
     * @param vr rayon du cercle
     */
    public Cercle(Point vC, double vr) {
        assert (vC != null);
        assert (vr > 0);
        this.centre = new Point(vC.getX(), vC.getY());
        this.rayon = vr;
        this.couleur = Color.blue;
    }

    /** Construire un cercle bleu à partir de deux points diamétralement opposés. (E12)
     * @param p1 premier point
     * @param p2 deuxieme point
     */
    public Cercle(Point p1, Point p2) {
        assert (p1 != null);
        assert (p2 != null);
        assert (p1.distance(p2) > 0);
        this.couleur = Color.blue;
	    double abscisse = (p1.getX() + p2.getX()) / 2;
	    double ordonnee = (p1.getY() + p2.getY()) / 2;
	    this.centre = new Point(abscisse, ordonnee);
        this.rayon = p1.distance(p2) / 2;
    }

    /** Construire un cercle à partir de deux points diametralement opposés.
     * et de sa couleur. (E13)
     * @param p1 premier point
     * @param p2 premier point
     * @param vcouleur Couleur
     */
    public Cercle(Point p1, Point p2, Color vcouleur) {
	    this(p1, p2);
        assert (vcouleur != null);
        this.couleur = vcouleur;
    }

    /** Translater le cercle. (E1)
     * @param dx déplacement du centre suivant l'axe des X.
     * @param dy déplacement du centre suivant l'axe des Y.
     */
    public void translater(double dx, double dy) {
        this.centre.translater(dx, dy);
    }

    /** Obtenir le centre du cercle. (E2)
     * @return coordonnée du centre
     */
    public Point getCentre() {
        Point centrebis = new Point(this.centre.getX(), this.centre.getY());
        return centrebis;
    }

    /** Obtenir le rayon du cercle. (E3)
     * @return rayon du cerle
     */
    public double getRayon() {
        return this.rayon;
    }

    /** Obtenir le diamètre du cercle. (E4)
     * @return diamètre du cercle
     */
    public double getDiametre() {
        return 2 * this.rayon;
    }

    /** Savoir si un point est à l'intérieur du cercle. (E5)
     * @param p point p
     * @return booleen
     */
    public boolean contient(Point p) {
        assert (p != null);
        return (this.centre.distance(p) <= this.rayon);
    }

	/** Obtenir le périmetre du cercle. (E6)
	 * @return périmètre du cercle
	 */
	public double perimetre() {
		return 2 * PI * this.rayon;
	}

	/** Obtenir l'aire du cercle. (E6)
	 * @return périmètre du cercle
	 */
	public double aire() {
		return PI * this.rayon * this.rayon;
	}

    /** Obtenir la couleur du cercle. (E9)
     * @return couleur du cercle
     */
    public Color getCouleur() {
        return this.couleur;
    }

    /** Changer la couleur du cercle. (E10)
     * @param nouvelleCouleur nouvelle couleur
     */
    public void setCouleur(Color nouvelleCouleur) {
        assert (nouvelleCouleur != null);
        this.couleur = nouvelleCouleur;
    }

	/** Création de la méthode de classe pour créer un cercle
	 *  à partir de deux points : le centre P1 et un deuxime
	 *  qui définirera sa circonférence (les deux points
	 *  forment un rayon du cercle).
	 * @param p1 centre du cercle
	 * @param p2 point qui définit sa circonférence
     * @return cercle3 cercle créé
	 */
	public static Cercle creerCercle(Point p1, Point p2) {
        assert (p1 != null);
        assert (p2 != null);
		return new Cercle(p1, p1.distance(p2));
	}

    /** Afficher le cercle. (E15)
     * @return chaîne chaine de caractère qui renvoie le cercle
	 */
	public String toString() {
		return "C" + this.rayon + "@" + this.centre;
	}

    /** Changer le rayon d'un cercle. (E16)
     * @param nouveauRayon nouveau rayon
     */
    public void setRayon(double nouveauRayon) {
        assert (nouveauRayon > 0);
        this.rayon = nouveauRayon;
    }

    /** Changer le diametre d'un cercle. (E17)
     * @param nouveauDiametre nouveau diametre
     */
    public void setDiametre(double nouveauDiametre) {
        assert (nouveauDiametre > 0);
        this.rayon = nouveauDiametre / 2;
    }
}
