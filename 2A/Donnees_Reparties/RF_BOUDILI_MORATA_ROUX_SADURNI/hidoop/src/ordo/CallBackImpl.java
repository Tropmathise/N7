package ordo;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.concurrent.Semaphore;

public class CallBackImpl extends UnicastRemoteObject implements CallBack {

    private static final long serialVersionUID = 1L;
    private Semaphore nbMapsFinished;

    public CallBackImpl() throws RemoteException {
        super();
        nbMapsFinished = new Semaphore(0);
    }

    @Override
    // confirmer la fin d'un map
    public void finishedMaps() throws InterruptedException, RemoteException {
        nbMapsFinished.release();
    }

    @Override
    //attendre les que les maps soient finis
    public void waitMaps(int nb) throws InterruptedException, RemoteException {
        for(int i = 0; i < nb; i++) {
			try {
				nbMapsFinished.acquire();
		    	System.out.println((i+1) + " maps se sont finis.");
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
    }
}
