package monopoly.swing;

import monopoly.divers.*;

/* Classe Swing du Menu : Jouer ou Quitter */

import java.awt.event.ActionListener;
import javax.swing.*;

public class Menu extends JFrame implements ActionListener {

    private static final long serialVersionUID = 1L;
    
    // Boutons
    private JButton boutonJouer = new JButton(); // Jouer
    private JButton boutonQuitter = new JButton(); // Quitter
    private JButton boutonParametres = new JButton(); // Paramètres

    // Tuto
    public static JLabel tuto = new JLabel(StringPerso.creer("Veuillez entrer au moins 2 joueurs dans les paramètres avant de lancer la partie."));
    

    public Menu() {
        super();
        this.setTitle("Monopoly : Menu principal");
        this.setSize(1000, 500);
        this.setLocationRelativeTo(null);
        this.setContentPane(panelMenu());
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }


    private JPanel panelMenu() {

        // Positions et tailles des boutons
        boutonJouer.setBounds(350,75,300,100); // Au milieu haut
        boutonQuitter.setBounds(350, 225, 300, 100);
        boutonParametres.setBounds(800, 425, 150, 25); // En bas à droite
        tuto.setBounds(270, 187, 500, 25);
        tuto.setVisible(false);

        // On ajoute les listeners sur les boutons pour gérer les effets
        boutonJouer.addActionListener(this);
        boutonQuitter.addActionListener(this);
        boutonParametres.addActionListener(this);

        boutonJouer.setText(StringPerso.creer("Jouer"));
        boutonQuitter.setText(StringPerso.creer("Quitter"));
        boutonParametres.setText(StringPerso.creer("Paramètres"));

        // Panel de la fenêtre
        JPanel panel = new JPanel();

        // Layout du panel (null pour placer les boutons où on veut)
        panel.setLayout(null);

        // Ajout des boutons au panel
        panel.add(boutonJouer);
        panel.add(boutonQuitter);
        panel.add(boutonParametres);
        panel.add(tuto);

        
        // Le panel est complet
        return panel;
    }

    public static void CreerJoueur(JTextField text, Integer numero, String couleur) {
        if (!text.getText().equals("Nom du joueur " + numero)) {
            System.out.println("Nom du joueur " + numero + " : " + text.getText());
            JoueurMonopoly j = new JoueurMonopoly(StringPerso.creer(text.getText()), numero, Partie.argentDepart, couleur);
            Partie.joueurs.add(j);
        }
    }


    /* Action sur les boutons */
    public void actionPerformed(java.awt.event.ActionEvent e) {
        Object bouton = e.getSource();
        if (bouton == boutonJouer) {
            Partie.plateau = new PlateauSwing(Partie.joueurs);
            if (Partie.joueurs.size() <= 1) {
                tuto.setVisible(true);

            }
            else {
                Partie.plateau.setVisible(true);
                new Annonce("Bienvenue dans une nouvelle partie de Monopoly !");
                tuto.setVisible(false);
                this.setVisible(false);
            }
        }
        else if (bouton == boutonQuitter) {
            new Annonce("Nous espérons vous revoir bientôt ! Au revoir.");
            System.exit(0);
        }
        else if (bouton == boutonParametres) {
            Partie.parametres.setVisible(true);
        }
	}
}