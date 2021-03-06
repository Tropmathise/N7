package monopoly.swing;

/** Classe correspondant aux infos des joueurs au cours de la partie
 * @author Theo, Thomas
 */

import javax.swing.DefaultListModel;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.ListSelectionModel;

import monopoly.cases.CaseAchetable;
import monopoly.divers.Case;
import monopoly.divers.JoueurMonopoly;
import monopoly.divers.Plateau;
import monopoly.divers.StringPerso;

public class InfosJoueur extends JComponent {

    private static final long serialVersionUID = 1L;

    private JoueurMonopoly joueur;
    private JLabel solde = new JLabel();
    private JLabel positionImage = new JLabel();
    private JLabel positionText = new JLabel();
    private JLabel nbTourDePlateau = new JLabel();
    private JLabel nbTourEnPrison = new JLabel();
    private JList<String> proprietes = new JList<String>();
    private JLabel estEnPrison = PlateauSwing.initImage("res/Est_En_Prison.png");
    private JLabel carteSortiePrison = PlateauSwing.initImage("res/Sortie_Prison.png");
    private DefaultListModel<String> liste = new DefaultListModel<String>();

    /* constructeur de la classe */
    public InfosJoueur(JoueurMonopoly joueur) {
        super();
        this.joueur = joueur;
        System.out.println(joueur.getNom());
        actualiserInfos();
        initFormats();
    }

    /* Methode pour actualiser les infos des joueurs au cours de la partie */ 
    public void actualiserInfos() {
        this.liste.removeAllElements();
        this.proprietes.removeAll();
        this.solde.setText("Solde : " + this.joueur.getSolde());
        this.positionImage.setIcon(PlateauSwing.initImage("res/" + this.joueur.getPosition().getFichierIcone()).getIcon());
        this.positionText.setText(this.joueur.getPosition().getNom());
        this.nbTourDePlateau.setText("Tours de plateau : " + this.joueur.getNbToursPlateau());
        this.nbTourEnPrison.setText("Tours en prison : " + this.joueur.getToursEnPrison());
        this.liste.addElement(StringPerso.creer("Liste des propri??t??s :"));
        for (int i = 0; i < Plateau.nbCases; i++) {
            Case c = Plateau.cases[i];
            if (c instanceof CaseAchetable) {
                try {
                    if (StringPerso.creer(((CaseAchetable) c).getProp().getNom()).equals(StringPerso.creer(this.joueur.getNom()))) {
                        this.liste.addElement(c.getNom());
                    }
                }
                catch (NullPointerException e) {}
            }
        }
        this.proprietes = new JList<String>(this.liste);
        this.carteSortiePrison.setVisible(this.joueur.getNbCarteSortieDePrison() > 0);
        this.estEnPrison.setVisible(this.joueur.getEstEnPrison());
        //this.proprietes.setVisible(true);
        this.proprietes.setVisible(this.joueur.getTerrains().size() != 0);
        this.nbTourEnPrison.setVisible(this.joueur.getEstEnPrison());

    }

    /* Initialisation swing des infos des joueurs */
    private void initFormats() {
        //positions
        this.solde.setBounds(10, 10, 400, 25);
        this.nbTourDePlateau.setBounds(10, 40, 300, 25);
        this.nbTourEnPrison.setBounds(10, 70, 300, 25);
        this.positionImage.setBounds(210, 20, 40, 40);
        this.positionText.setBounds(255,15,200,50);
        this.proprietes.setBounds(10, 100, 400, 200);
        this.estEnPrison.setBounds(10, 310, 40, 40);
        this.carteSortiePrison.setBounds(60, 310, 40, 40);

        //visibilit??
        this.solde.setVisible(true);
        this.nbTourDePlateau.setVisible(true);
        this.positionImage.setVisible(true);
        this.positionText.setVisible(true);

        this.proprietes.setVisible(true);
        //this.proprietes.setVisible(this.joueur.getTerrains().size() != 0);
        //this.proprietes.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        this.proprietes.setLayoutOrientation(JList.VERTICAL);

        this.add(this.solde);
        this.add(this.nbTourDePlateau);
        this.add(this.nbTourEnPrison);
        this.add(this.positionImage);
        this.add(this.positionText);
        this.add(this.proprietes);
        this.add(this.estEnPrison);
        this.add(this.carteSortiePrison);
    }
}