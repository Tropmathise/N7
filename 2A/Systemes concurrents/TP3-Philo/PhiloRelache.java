import java.util.concurrent.Semaphore;

public class PhiloRelache implements StrategiePhilo {

    /****************************************************************/

    /* tableau de sémaphores */
    private Semaphore[] fourchettes;

    public PhiloRelache (int nbPhilosophes) {
        fourchettes = new Semaphore[nbPhilosophes];
        for (int k=0; k<nbPhilosophes; k++) {
            fourchettes[k]=new Semaphore(1);
        }
    }

    /** Le philosophe no demande les fourchettes.
     * O est puni: les philosophes prennent tous la fourchette de droite en premier
     * sauf le philophose numéroté 0
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException
    {
        boolean continuer = true;
        while(continuer){
            fourchettes[Main.FourchetteDroite(no)].acquire();
            if (!fourchettes[Main.FourchetteGauche(no)].tryAcquire()){
                fourchettes[Main.FourchetteDroite(no)].acquire();
            }
            else {
                continuer=false;
            }
        }
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
        return "Implantation Sémaphores, stratégie relache";
    }

}

