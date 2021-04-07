public class SFicheImpl implements SFiche{
    private String nom;
    private String email;

    public SFicheImpl(String nom, String email){
        super();
        this.nom=nom;
        this.email=email;
    }

    public String getNom() {
        return this.nom;
    }

    public String getEmail(){
        return this.email;
    }
}
