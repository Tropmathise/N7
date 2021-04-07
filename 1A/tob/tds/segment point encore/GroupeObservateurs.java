/** GroupeObservateurs encapsule la liste des observateurs.
 * @author	Xavier Crégut
 * @navassoc * "" "*" Observateur
 * @stereotype container
 */
public class GroupeObservateurs {

	/** Les observateurs gérés. */
	private java.util.List<Observateur> observateurs;

	/** Construire une liste vide d'observateurs. */
	public GroupeObservateurs() {
		observateurs = new java.util.ArrayList<Observateur>();
	}

	public void maj(Point source, double dx, double dy) {
		for (Observateur obs : observateurs) {
			obs.maj(source, dx, dy);
		}
	}

	/** Ajouter un nouveau segment. */
	public void ajouter(Observateur unObservateur) {
		observateurs.add(unObservateur);
	}

	/** Supprimer un segment. */
	public void supprimer(Observateur unObservateur) {
		observateurs.remove(unObservateur);
	}

}
