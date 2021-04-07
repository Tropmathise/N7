import afficheur.Ecran;
import java.awt.Color;
import afficheur.Afficheur;

abstract public class ObjetGeometrique {

    private Color couleur;

    public ObjetGeometrique(Color c) {
        this.couleur=c;
    }
    
    public Color getCouleur() {
        return this.couleur;
    }
    
    public void setCouleur (Color c) {
        this.couleur=c;
    }

    abstract public void afficher();

    abstract public void translater( double dx, double dy);
    
    abstract public void dessiner(Afficheur afficheur);

}

