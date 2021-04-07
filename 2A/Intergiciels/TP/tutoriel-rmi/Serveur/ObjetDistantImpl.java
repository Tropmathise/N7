import java.rmi.*;
import java.rmi.server.*;
import java.io.*;
import java.util.*;

public class ObjetDistantImpl extends UnicastRemoteObject implements ObjetDistant {

    private Random alea;
    private int calls;

    public ObjetDistantImpl() throws RemoteException {
        alea = new Random();
        calls = 0;
    }

    public int getRandom() throws RemoteException {
        calls++;
        return alea.nextInt();
    }

    public int getCall() throws RemoteException {
        return calls;
    }
}
