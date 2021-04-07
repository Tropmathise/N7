import java.rmi.*;
import java.io.*;

public interface NombreAleatoireGeneratorInterface extends Remote {
    public int getRandom() throws RemoteException;
    public int getNombreAppels() throws RemoteException;
}
