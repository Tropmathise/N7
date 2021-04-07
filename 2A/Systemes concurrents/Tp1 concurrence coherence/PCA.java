// v0.1, 7/9/16 (PM)
public class PCA {

    static final int N = 10;
    static volatile int dépôt = 0;
    static volatile int retrait = 0;
    static int [] tampon = new int[N];
    static Object mutex = new Object();

    public static void main(String[] args) throws InterruptedException {
        Thread t1 = new Thread(new Producteur());
        Thread t2 = new Thread(new Consommateur());
        t1.start();
        t2.start();
        t1.join();
        t2.join();
    }
}

class Producteur implements Runnable {
// dépose des suites de N entiers identiques, en incrémentant la valeur déposée à chaque nouvelle suite
    public void run(){
        try{
            for (;;) {
                System.out.println("production...");
                while (PCA.dépôt-PCA.retrait==PCA.N) {}
                System.out.println("PCA.dépôt "+  PCA.dépôt/PCA.N);
                PCA.tampon[PCA.dépôt%PCA.N] = PCA.dépôt/PCA.N;
                PCA.dépôt++;
                Thread.sleep(100);
                System.out.println("fait");
            }
        }
        catch(InterruptedException e){
            System.out.println("PRODUCTEUR INTERROMPU");
        }

    }
}

class Consommateur implements Runnable {
    public void run() {
        int item;
        try{
            for (;;) {
                System.out.println("repos...");
                while (PCA.dépôt==PCA.retrait) {}
                System.out.println("PCA.retrait");
                item=PCA.tampon[PCA.retrait%PCA.N];
                PCA.retrait++;
                Thread.sleep(100);
                System.out.println("consommation "+item);
            }
        }
        catch(InterruptedException e){
            System.out.println("CONSOMMATEUR INTERROMPU");
        }
    }
}