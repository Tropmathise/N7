public class Cellule {
    private int x;
    private Cellule suivant; 

    public Cellule (int x) {
        this.x = x;
        this.suivant = null;
    }

    public Cellule getSuivant () {
        return this.suivant; 
    }

    public int getElement () {
        return this.x;
    }

    public void setSuivant (Cellule suivant) {
        this.suivant = suivant;
    }

    public void setElement (int x) {
        this.x=x;
    }

    //public Cellule ajouter(int x) {
    //  Cellule cell = new Cellule(x);
      //  cell.suivant = this;
    //}

    //public Cellule supprimer(int x) {
}