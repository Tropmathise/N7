import java.util.concurrent.Semaphore;
import java.lang.Thread;

public class PhiloBase implements StrategiePhilo {

    /****************************************************************/

    /* tableau de sémaphores */
    private Semaphore[] fourchettes;

    public PhiloBase (int nbPhilosophes) {
        fourchettes = new Semaphore[nbPhilosophes];
        for (int k=0; k<nbPhilosophes; k++) {
            fourchettes[k]=new Semaphore(1);
        }
    }

    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException
    {
        fourchettes[Main.FourchetteDroite(no)].acquire();
        Thread.sleep(3000);
        fourchettes[Main.FourchetteGauche(no)].acquire();
    }

    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no)
    {
        fourchettes[Main.FourchetteDroite(no)].release();
        fourchettes[Main.FourchetteGauche(no)].release();
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, stratégie basique";
    }

}

