package allumettes;

import java.rmi.server.Operation;

import allumettes.CoupInvalideException;
import allumettes.NouveauJeu;
import allumettes.OperationInterditeException;

/** Interdire au joueur de modifier le jeu, 
 *  donc le nombre d'allumettes prises.
 * @author Thomas SADURNI
 * @version 1.0
 */

 public class ProcurationJeu implements Jeu{

    protected Jeu jeu;

    public ProcurationJeu(Jeu jeu){
        assert(jeu !=null);
        this.jeu=jeu;
    }

    public int getNombreAllumettes(){
        return this.jeu.getNombreAllumettes();
    }

    public void retirer(int nbPrises) throws OperationInterditeException {
        throw new OperationInterditeException();
    }
 }
