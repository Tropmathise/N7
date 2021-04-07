import java.rmi.*;
import java.io.*;

public interface ObjetDistant extends Remote {
    public int getRandom() throws RemoteException;
    public int getCall() throws RemoteException;
}
