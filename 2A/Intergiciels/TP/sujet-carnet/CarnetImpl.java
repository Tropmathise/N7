import java.rmi.server.UnicastRemoteObject;
import java.rmi.*;
import java.rmi.server.*;
import java.rmi.registry.*;
import java.util.HashMap;

public class CarnetImpl extends UnicastRemoteObject implements Carnet {
    private HashMap<String, RFiche> fiches;
    private String nom;
    private int num;

    public CarnetImpl(int num) throws RemoteException{
        super();
        this.fiches = new HashMap<String,RFiche>();
        this.num=num;
    }

    public void Ajouter(SFiche sfiche) throws RemoteException {
        System.out.println("Ajouter " + sfiche.getNom());
        RFiche fiche = new RFicheImpl(sfiche.getNom(),sfiche.getEmail());
        fiches.put(sfiche.getNom(),fiche);
    }

    public RFiche Consulter(String string, boolean bool) throws RemoteException{
        System.out.println("Consulter " + string);
        return fiches.get(string);
    }

    public static void main(String[] args){
        try {
            int num = Integer.parseInt(args[0]);
            CarnetImpl carnetImpl = new CarnetImpl(num);
            Registry registry = LocateRegistry.createRegistry(4000);
            Naming.rebind("//localhost:4000/CarnetImpl", carnetImpl);
            System.out.println("Carnet enregistré dans le registre\n");
        }catch (Exception ed){
            ed.printStackTrace();
        }
    }
}