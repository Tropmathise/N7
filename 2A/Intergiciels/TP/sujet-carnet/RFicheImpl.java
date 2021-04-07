import java.rmi.RemoteException;

public class RFicheImpl implements RFiche{
    private String nom;
    private String email;

    public RFicheImpl(String nom, String email){
        super();
        this.nom=nom;
        this.email=email;
    }

    public String getNom() throws RemoteException{
        return this.nom;
    }

    public String getEmail() throws RemoteException{
        return this.email;
    }
}
