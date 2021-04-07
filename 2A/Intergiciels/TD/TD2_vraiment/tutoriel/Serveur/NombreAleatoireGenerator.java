import java.rmi.*;
import java.rmi.server.*;
import java.io.*;
import java.util.*;

public class NombreAleatoireGenerator extends UnicastRemoteObject implements NombreAleatoireGeneratorInterface {

    private Random alea;
    private int nombreAppels;

    public NombreAleatoireGenerator() throws RemoteException {
        nombreAppels = 0;
        alea = new Random();
    }

    public int getRandom() throws RemoteException {
        nombreAppels++;
        return alea.nextInt();
    }

    public int getNombreAppels() throws RemoteException {
        return nombreAppels;
    }

}
