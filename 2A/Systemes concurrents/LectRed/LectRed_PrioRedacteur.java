// Time-stamp: <08 Apr 2008 11:35 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioRedacteur implements LectRed
{   
    private int nbLecteurs=0;
    private int nbAttente=0;
    private boolean occupe;
    private ReentrantLock moniteur;
    private Condition lecteurPossible;
    private Condition ecriturePossible;


    public LectRed_PrioRedacteur()
    {
        moniteur = new ReentrantLock();
        lecteurPossible = moniteur.newCondition();
        ecriturePossible = moniteur.newCondition();
        nbLecteurs=0;
        nbAttente=0;
        occupe = false;
    }

    public void demanderLecture() throws InterruptedException
    {
        moniteur.lock();
        while (occupe || nbAttente != 0){
            lecteurPossible.await();
        }
        nbLecteurs++;
        lecteurPossible.signal();
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException
    {
        moniteur.lock();
        nbLecteurs--;
        if(nbLecteurs==0){
            ecriturePossible.signal();
        }
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException
    {
        moniteur.lock();
        nbAttente++;
        while(occupe || nbLecteurs != 0 ){
            ecriturePossible.await();
        }
        occupe=true;
        nbAttente--;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException
    {
        moniteur.lock();
        occupe=false;
        ecriturePossible.signal();
        moniteur.unlock();
    }

    public String nomStrategie()
    {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
