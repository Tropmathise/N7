package editeur.commande;

import editeur.Ligne;

/** Ajouter un caractère à la fin de la ligne.
 * @author	Xavier Crégut
 * @version	1.4
 */
public class afficherLigne
	extends CommandeLigne
{

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public afficherLigne(Ligne l) {
		super(l);
	}

	public void executer() {
		System.out.println("");
        ligne.afficher();
        System.out.println("");
	}

	public boolean estExecutable() {
		return true;
	}

}
