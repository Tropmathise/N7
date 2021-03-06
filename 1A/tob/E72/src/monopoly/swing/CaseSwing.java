package monopoly.swing;
/* Classe Swing des Cases */
 
import monopoly.divers.*;

import javax.swing.ImageIcon;
import javax.swing.JButton;

public class CaseSwing extends JButton {

    private static final long serialVersionUID = 1L;

    private Case c; // La case qui est modélisée

    public CaseSwing(Case c) {
        super();
        this.c = c;
        java.net.URL imageURL = Partie.class.getResource("res/" + c.getFichierIcone());
        this.setBounds(idToX(this.getId()), idToY(this.getId()), PlateauSwing.tailleCase, PlateauSwing.tailleCase);

        if (imageURL != null) {
        	ImageIcon image = new ImageIcon(imageURL);
        	this.setIcon(image);
        }
        else {
            System.out.printf("L'image \"%s\" n'a pas été trouvée pour la case %s\n", imageURL, c.getNom());
        }
    }

    public Integer getId() {
        return this.c.getId();
    }

    public Case getCase() {
        return this.c;
    }

    /* Positionner les cases sur l'axe X du plateau */
    private Integer idToX(Integer id) {
        assert (id >= 0);
        assert (id <= 39);
        if (id <= 9) {
            return (10 - id) * PlateauSwing.tailleCase;
        } else if (id >= 10 && id <= 20) {
            return 0;
        } else if (id >= 21 && id <= 29) {
            return (id % 10) * PlateauSwing.tailleCase;
        } else {
            return 10 * PlateauSwing.tailleCase;
        }
    }

    /* Positionner les cases sur l'axe Y du plateau */
    private Integer idToY(Integer id) {
        assert (id >= 0);
        assert (id <= 39);
        if (id <= 10) {
            return 10 * PlateauSwing.tailleCase;
        } else if (id >= 11 && id <= 19) {
            return (20 - id) * PlateauSwing.tailleCase;
        } else if (id >= 20 && id <= 29) {
            return 0;
        } else {
            return (id % 10) * PlateauSwing.tailleCase;
        }
    }
}