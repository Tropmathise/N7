package allumettes;

/** Interdire au joueur de modifier le jeu,
 *  donc le nombre d'allumettes prises.
 * @author Thomas SADURNI
 * @version 1.1
 */

 public class ProcurationJeu implements Jeu {

    private Jeu jeu;

    public ProcurationJeu(Jeu jeu) {
        assert (jeu != null);
        this.jeu = jeu;
    }

    public int getNombreAllumettes() {
        return this.jeu.getNombreAllumettes();
    }

    public void retirer(int nbPrises) throws OperationInterditeException {
        throw new OperationInterditeException();
    }
 }
