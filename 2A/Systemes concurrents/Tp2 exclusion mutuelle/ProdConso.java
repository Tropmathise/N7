// v0.1, 25/09/20 (PM)

class TamponBorné{
/* Pour simplifier la mise en œuvre du test, on se limite ici à un tampon d'entiers */
    private int taille; 			// nombre de cases du tampon
    private int nbOccupé = 0; // nombre d'items présents dans le tampon (vide initialement)
    private int queue = 0; 		// queue de file (tampon circulaire), insertions
    private int tête = 0; 		// tête de file (tampon circulaire), extractions

    private int trace = 0;// utile uniquement pour faciliter le test :
													// on va considérer qu'on dépose les valeurs successives de trace...

    private int[] tampon;

    public TamponBorné(int t) {
        taille = t;
        tampon = new int [taille];
    }

    public synchronized void déposer() { // pour le test, les valeurs déposées sont prédéfinies
        while (nbOccupé==taille){
            try {
                this.wait();
            }
            catch(InterruptedException e){

            }
        }

        // dépôt
        tampon[queue] = trace++; 			// tampon[queue] = i;
        queue = (queue + 1) % taille;
        nbOccupé++;

        // affichage pour le test uniquement
        String msg="P : "+(trace-1);
        if (nbOccupé == taille) msg=msg+ " (PLEIN)";
        System.out.println(msg);

        this.notifyAll();

    } //déposer()

    public synchronized int retirer() {	// Item remove()
        int i;							// Item i
        while (nbOccupé==0){
            try {
                this.wait();
            }
            catch(InterruptedException e){

            }
        }

        // retrait
        i = tampon[tête];
        tête = (tête + 1) % taille;
        nbOccupé--;

        // affichage pour le test uniquement
        String msg="C : "+i;
        if (nbOccupé == 0) msg=msg+ " (VIDE)";
        System.out.println(msg);

        this.notifyAll();
        return i;
    } // retirer
} // TamponBorné

//--------------------------------------inutile de modifier ce qui suit ------------------

class Producteur implements Runnable {
    private TamponBorné tampon;
    public Producteur(TamponBorné t) {
        tampon = t;
    }
    public void run() {
        try {
            Thread.sleep(10) ; // pour le test : initialement, les consommateurs trouveront tous un tampon vide
            for (int i = 0; i < 25; i++) {
                // possible de trouver des producteurs bloqués à la fin, selon le nb de consommateurs
                tampon.déposer();
                Thread.sleep(2*i); //producteurs ralentissent un peu
            }
        } catch (InterruptedException e) {
            System.out.println("interrompu");
        }
    }
}

class Consommateur implements Runnable {
    private TamponBorné tampon;
    private int identité;
    public Consommateur(TamponBorné t) {
        tampon = t;
    }
    public void run() {
        int res;
        for (int i = 0; i < 25; i++) {
            // possible de trouver des consommateurs bloqués à la fin, selon le nb de producteurs
            res = tampon.retirer();
            try {
                Thread.sleep(10*i); //consommateurs ralentissent davantage
            } catch (InterruptedException e) {
                System.out.println("interrompu");
            }
        }
    }
}

public class ProdConso {
    public static void main(String[] args) {
        int nbProd = 5;
        int nbConso = 10;
        int tailleTampon = 10;
        //aucun blindage : on suppose que les valeurs de paramètres fournies sont raisonnables
        if (args.length != 3) {
            System.out.println("java ProdConso <nbProd> <nbConso> <nbCases>");
            System.out.println("-> choix par défaut : "+nbProd+"/"+nbConso+"/"+tailleTampon);
        } else {
            nbProd = Integer.parseInt (args[0]);
            nbConso = Integer.parseInt (args[1]);
            tailleTampon = Integer.parseInt (args[2]);
        }
        System.out.println("nbProd (arg1) : " + nbProd + " /nbConso (arg2) : " + nbConso
                           + " /nbCases) (arg3) : "+ tailleTampon);
        TamponBorné t = new TamponBorné(tailleTampon);
        for (int i = 0; i < nbProd; i++) {
            new Thread(new Producteur(t)).start() ;
        }
        for (int i = 0; i < nbConso; i++) {
            new Thread(new Consommateur(t)).start() ;
        }
        //ajouter éventuellement un thread pour gérer l'arrêt et une prise de cliché finale
    }
}