// V0.0 - PM 12/09/18
import java.util.concurrent.atomic.AtomicLong;


interface Incrémenteur extends Runnable{
    void incr(); 
    /* Boucle d'incrémentation effectuée par un processus (thread). 
     * Le principe/objectif est de réaliser cette boucle, comportant un même nombre 
     * d'incrémentations en suivant différents schémas pour maintenir la cohérence
     * (ou pas) et de comparer ces schémas en termes de correction et d'efficacité
     */
}

public class IncrMes {

    static volatile long cptvolatile = 0L;
    static AtomicLong cptatomiclong = new AtomicLong(0);
    static final long NB_IT = 10L;			 //Nb d'itérations de la boucle externe
    static final long NB_IT_INTERNES = 100L; //Nb d'itérations de la boucle interne
    static long Attente_ms = 100L;
    static final int Attente_nano = 0;
    static Thread[] activités;          // Tableau des processus
    static Object mutex = new Object(); // pour les blocs synchronized

    static void lancer(int nbA, Incrémenteur r) {
        // Initialisation du/des compteur(s) incrémentés
        cptvolatile = 0L;
        AtomicLong cptatomiclong = new AtomicLong(0);        
        /* Création et lancement des threads. 
         * Chaque thread exécute le même code, qui est la méthode run() d'une classe 
         * implantant un Incrémenteur (autrement dit un schéma de réalisation particulier 
         * de la boucle dincrémentation)
         */
         
        for (int i = 0; i < nbA ; i++) {
            try {
                IncrMes.activités[i] = new Thread(r,"t"+i);
            }
            catch (Exception e)
            {
                System.out.println(e);
            }
            IncrMes.activités[i].start();
        }
    }

    static void finir() {
    	// Attente de la terminaison des différents threads lancés
        for (int i = 0; i < IncrMes.activités.length ; i++) {
            try {
                IncrMes.activités[i].join();
            }
            catch (InterruptedException e)
            {
                System.out.println(e);
            }
        }
    }

    public static void main(String[] args) {
        int nbActivités = 3;
        int i = 0;
        long départ, fin;

        // Chargement des paramètres saisis en ligne de commande
        if (args.length == 2) {
            try {
                nbActivités = Integer.parseInt (args[0]);
                Attente_ms = Integer.parseInt (args[1]);
            }
            catch (NumberFormatException nfx) {
                Attente_ms = 0;
            }
            if ((nbActivités < 1) || (Attente_ms < 1)) {
                System.out.println("Usage : IncrDemoSeq <Nb activités> <durée pause (ms)>,"
                                   +"avec Nb activités >= 1 et <durée pause >= 1");
                System.exit (1);
            }
        } else {
            System.out.println("Nb d'arguments ≠ 2. Exécution avec 3 activités et 100 ms de pause");
        }

        activités = new Thread[nbActivités];

        départ = System.nanoTime();
        // Boucle séquentielle : NB_IT x NB_IT_INTERNES x nbActivités itérations
        synchronized(mutex){
        for (long li = 0; li < nbActivités*IncrMes.NB_IT; li++) {
            //for (AtomicLong j = new AtomicLong(1); !j.compareAndSet(IncrMes.NB_IT_INTERNES, IncrMes.NB_IT_INTERNES); j.getAndIncrement()) { /*pour atomiclong */ 
            for (long j = 1; j<=IncrMes.NB_IT_INTERNES; j++) { /* pour volatile*/
                IncrMes.cptvolatile=IncrMes.cptvolatile+j/j; 
                //IncrMes.cptatomiclong.getAndIncrement(); 
                //System.out.println("valeur du compteur mono : "+ IncrMes.cptatomiclong.get());
                System.out.println("valeur du compteur mono : "+ IncrMes.cptvolatile);
            }
                // j/j pour tenter de déjouer les optimisations du compilateur
            }
            try {
                Thread.sleep(IncrMes.Attente_ms, IncrMes.Attente_nano);
                // sleep pour modéliser un temps de calcul sans conflit d'accès et...
                // pour tenter de déjouer les optimisations du cache
            }
            catch (InterruptedException ie)
            {
                System.out.println("InterruptedException : " + ie);
            }
        }
        fin = System.nanoTime();
        System.out.println("Durée exécution mono : " + (fin-départ)/1000000L);
        System.out.println();

        départ = System.nanoTime();
        // Lancement de nbActivités processus effectuant 
        // chacun NB_IT x NB_IT_INTERNES itérations
        lancer(nbActivités, new IncrémenteurNonSync());
        finir();
        fin = System.nanoTime();
        System.out.println("Durée exécution non synchronisée (ms): " + (fin-départ)/1000000L);
        System.out.println();
        
        // Compléter ici, en définissant et mesurant différents Incrémenteur
        // de manière analogue à ce qui est fait pour IncrémenteurNonSync
	}
}

class IncrémenteurNonSync implements Incrémenteur {
/* Exemple d'incrémenteur : 
 -la méthode incr effectue les incrémentations sans gérer les conflis d'accès au compteur
 - la méthode run() appelle incr() 
 */
    public void incr() {
        for (long i = 0L; i < IncrMes.NB_IT; i++) {
        	// boucle imbriquée pour permettre (éventuellement) de tester différents
        	// grains de synchronisation
            //for (AtomicLong j = new AtomicLong(1); !j.compareAndSet(IncrMes.NB_IT_INTERNES, IncrMes.NB_IT_INTERNES); j.getAndIncrement()) {
            //    IncrMes.cptatomiclong.getAndIncrement();
            for (long j = 1; j<=IncrMes.NB_IT_INTERNES; j++) { /* pour volatile*/
                    IncrMes.cptvolatile=IncrMes.cptvolatile+j/j;
                //System.out.println("valeur du compteur non synchro : "+ IncrMes.cptatomiclong.get());
            }
            try {
                Thread.sleep(IncrMes.Attente_ms, IncrMes.Attente_nano);
            }
            // Attente depour éviter l'utilisation du cache et modéliser
            // une partie du calcul sans conflit.
            // Vous pouvez  (éventuellement) commenter l'attente 
            // pour voir l'effet (intéressant) du mécanisme de cache,
            // ou encore modifier  la valeur de l'attente pour voir
            // l'effet du grain de l'exclusion mutuelle sur les temps
            // d'exécution
            catch (InterruptedException ie)
            {
                System.out.println("InterruptedException : " + ie);
            }
        }
    }

    public void run() {
     	// afficher éventuellement la valeur du compteur avant/après 
     	// pour vérifier la cohérence des incrémentations
        this.incr();
    }
}