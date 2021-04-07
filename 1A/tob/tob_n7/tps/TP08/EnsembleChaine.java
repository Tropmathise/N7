public class EnsembleChaine implements Ensemble {

    private Cellule cellule;

    public EnsembleChaine() { 
        this.cellule=null;
    }

    public EnsembleChaine(int x) {
        this.cellule = new Cellule (x);
    }

    public int cardinal() {
        int cpt = 0;
        if (this.cellule == null) {
            return cpt;
        }
        else {
            Cellule cell = this.cellule;
            while (cell.getSuivant() != null) {
                cell = cell.getSuivant();
                cpt+=1;
            }
        }
        return cpt;
    }

    public boolean estVide() {
        return this.cardinal() == 0;
    }

    public boolean contient(int x) {
        boolean estPresent = false;
        Cellule cell = this.cellule;
        if (this.cellule == null){
            estPresent = false;
        }
        while (cell.getSuivant() != null) {
            if (cell.getSuivant().getElement() == x) {
                estPresent = true;
            }
            else {
                cell=cell.getSuivant();
            }
        }
        return estPresent;
    }

    public void ajouter(int x) {
        Cellule cell = this.cellule;
        if (this.estVide()) {
            cell = new Cellule(x);
        }
        else if (!this.contient(x)) {
            while (cell.getSuivant() != null) {
                cell = cell.getSuivant(); 
            }
            cell.setElement(x);
            cell.setSuivant(null);
        }
    }

    public void supprimer(int x) {


    }
}