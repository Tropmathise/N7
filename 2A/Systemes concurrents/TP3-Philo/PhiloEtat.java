import java.util.concurrent.Semaphore;
import java.lang.Thread;

public class PhiloEtat implements StrategiePhilo {

    /****************************************************************/

    /* tableau de sémaphores */
    private Semaphore[] semPhilo;
    private Semaphore mutex = new Semaphore(1);
    private EtatPhilosophe[] etatPhilo;

    public PhiloEtat (int nbPhilosophes) {
        etatPhilo = new EtatPhilosophe[nbPhilosophes];
        semPhilo = new Semaphore[nbPhilosophes];
        for (int k=0; k<nbPhilosophes; k++) {
            etatPhilo[k]= EtatPhilosophe.Pense;
        }
        for (int i=0; i<nbPhilosophes; i++){
            semPhilo[i] = new Semaphore(0);
        }
    }

    public boolean peutManger(int no){
        return etatPhilo[no] == EtatPhilosophe.Demande && etatPhilo[Main.PhiloGauche(no)]!=EtatPhilosophe.Mange && etatPhilo[Main.PhiloDroite(no)] != EtatPhilosophe.Mange;
    }
    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException
    {
        boolean continuer = true;
        while (continuer){
            mutex.acquire();
            etatPhilo[no]=EtatPhilosophe.Demande;
            if (peutManger(no)){
                etatPhilo[no]= EtatPhilosophe.Mange;
                mutex.release();
                continuer=false;
            } else {
               mutex.release();
               semPhilo[no].acquire();
            }
        }
    }

    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no) throws InterruptedException
    {
        mutex.acquire();
        etatPhilo[no]=EtatPhilosophe.Pense;
        //voisin gauche
		if (peutManger(Main.PhiloGauche(no))) {
            semPhilo[Main.PhiloGauche(no)].release();
            etatPhilo[Main.PhiloGauche(no)]=EtatPhilosophe.Mange;
		}
        //voisin droite
		if (peutManger(Main.PhiloDroite(no))) {
            semPhilo[Main.PhiloDroite(no)].release();
            etatPhilo[Main.PhiloDroite(no)]=EtatPhilosophe.Mange;
		}
		mutex.release();
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, stratégie etat philo";
    }

}

