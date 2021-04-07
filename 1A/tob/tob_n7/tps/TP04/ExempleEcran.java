import java.awt.Color;
import afficheur.Ecran;

public class ExempleEcran {
	
	public static void main(java.lang.String[] argv) {
	Ecran ExempleEcran = new Ecran("ExempleEcran", 400, 250, 15);
	ExempleEcran.dessinerAxes();
	ExempleEcran.dessinerPoint(1, 2, Color.green);
	ExempleEcran.dessinerLigne(6,2,11,9,Color.red);
	ExempleEcran.dessinerCercle(4,4,2.5,Color.yellow);
	ExempleEcran.dessinerTexte(1,-2,"Premier dessin", Color.blue);
	AfficheurTexte.afficherTexte(1,-2,"Premier dessin", Color.blue);
	AfficheurTexte.afficherPoint(1, 2, Color.green);
	AfficheurTexte.afficherLigne(6,2,11,9,Color.red);
	AfficheurTexte.afficherCercle(4,4,2.5,Color.yellow);
	}
}

