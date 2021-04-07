/** Un observateur est un objet qui souhaite être averti par la source auprès
 * de laquelle il s'inscrit.
 * @author	Xavier Crégut
 */
interface Observateur {

	/** Mettre à jour l'observateur.  Cette méthode est appelée chaque fois
	  * que l'objet observé change.
	  * @param source le point qui a été transltaté
	  * @param dx déplacement suivant l'axe des X
	  * @param dy déplacement suivant l'axe des Y
	  */
	void maj(Point source, double dx, double dy);
}
