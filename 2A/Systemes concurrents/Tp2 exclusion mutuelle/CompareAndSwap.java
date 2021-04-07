import java.util.concurrent.atomic.AtomicBoolean;

public class CompareAndSwap {

    static int tour = 0;
    static AtomicBoolean occupe = new AtomicBoolean(false);

    public static void main(String[] args) {
        Thread t1 = new Thread(new Proc(),"1");
        Thread t2 = new Thread(new Proc(),"0");
        Thread t3 = new Thread(new Proc(),"2");
        t1.start(); 
        t2.start(); 
        t3.start();
    }
}

class Proc implements Runnable {
    int id1, id2,id3;
    public void run() {
        id1 = Integer.parseInt(Thread.currentThread().getName());
        id2 = (id1+1) % 3;
        id3 = (id1+2) % 3;
        for ( ; ; ) {
            System.out.println("Thread " + id1 + " attend SC ");
            entrer();
            System.out.println("Thread " + Thread.currentThread().getName() + " en SC ");
            sortir();
            System.out.println("Thread " + Thread.currentThread().getName() + " hors SC ");
        }
    }

    void entrer() {
        while (CompareAndSwap.occupe.compareAndSet(false, true)) {
            ;//System.out.println(".."+id+"..");
        }
    }

    void sortir() {
        CompareAndSwap.occupe.set(false);
    }
}