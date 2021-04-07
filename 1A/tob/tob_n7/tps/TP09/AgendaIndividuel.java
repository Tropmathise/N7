/**
 * Définition d'un agenda individuel.
 */
public class AgendaIndividuel extends AgendaAbstrait {

	private String[] rendezVous;	// le texte des rendezVous


	/**
	 * Créer un agenda vide (avec aucun rendez-vous).
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom nul ou vide
	 */
	public AgendaIndividuel(String nom) throws IllegalArgumentException{
		super(nom);
		this.rendezVous = new String[Agenda.CRENEAU_MAX + 1];
			// On gaspille une case (la première qui ne sera jamais utilisée)
			// mais on évite de nombreux « creneau - 1 »
	}


	@Override
	public void enregistrer(int creneau, String rdv) throws CreneauInvalideException, OccupeException {
		verifierCreneauValide(creneau);
        	if (this.rendezVous[creneau]!=null) /*|| this.rendezVous[creneau]!=""*/ {
			throw new OccupeException("rdv dejà pris");
		}
		if (rdv == "" || rdv ==null) {
			throw new IllegalArgumentException("pas de rdv écrit");

		}
		this.rendezVous[creneau] = rdv;
	}


	@Override
	public boolean annuler(int creneau) throws CreneauInvalideException{
		verifierCreneauValide(creneau);
		boolean modifie = this.rendezVous[creneau] != null;
		this.rendezVous[creneau] = null;
		return modifie;
	}


	@Override
	public String getRendezVous(int creneau) throws CreneauInvalideException, LibreException{
		verifierCreneauValide(creneau);
        	if (this.rendezVous[creneau] == null || this.rendezVous[creneau]==""){
        		throw new LibreException("pas de rdv"); }
		return this.rendezVous[creneau];
	}


}
