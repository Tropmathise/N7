// Time-stamp: <08 Apr 2008 11:35 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_Equitable implements LectRed
{   
    private int nbLecteurs=0;
    private int nbAttente=0;
    private boolean occupe;
    private ReentrantLock moniteur;
    private Condition Acces;

    public LectRed_Equitable()
    {
        moniteur = new ReentrantLock();
        Acces = moniteur.newCondition();
        nbLecteurs=0;
        nbAttente=0;
        occupe = false;
    }

    public void demanderLecture() throws InterruptedException
    {
        moniteur.lock();
        if (occupe || nbAttente !=0){
            do {   
                nbAttente++;
                Acces.await();
                nbAttente--;
            } while (occupe);
        }
        nbLecteurs++;
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException
    {
        moniteur.lock();
        nbLecteurs--;
        if(nbLecteurs==0){
            Acces.signal();
        }
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException
    {
        moniteur.lock();
        if(occupe || nbLecteurs>0 || nbAttente>0){
            do{
                nbAttente++;
                Acces.await();
                nbAttente--;
            } while (occupe || nbLecteurs>0);
        }
        occupe=true;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException
    {
        moniteur.lock();
        occupe=false;
        Acces.signal();
        moniteur.unlock();
    }

    public String nomStrategie()
    {
        return "Stratégie: Equitable.";
    }
}
