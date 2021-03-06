package monopoly.swing;

/* Classe Swing des parametres du jeu : temps, noms des joueurs, options ... */
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

import javax.swing.*;

import monopoly.divers.Partie;
import monopoly.divers.StringPerso;

public class Parametres extends JFrame implements ItemListener, FocusListener, ActionListener {

    private static final long serialVersionUID = 1L;

    /* Attributs */
    JCheckBox victoireQuartiers = new JCheckBox("Victoire aux quartiers.");
    JCheckBox victoireTemps = new JCheckBox("Victoire au temps.");
    JSlider sliderTemps = new JSlider(JSlider.HORIZONTAL, 5, 20, 10);
    JTextField joueur1 = new JTextField("Nom du joueur 1");
    JTextField joueur2 = new JTextField("Nom du joueur 2");
    JTextField joueur3 = new JTextField("Nom du joueur 3");
    JTextField joueur4 = new JTextField("Nom du joueur 4");
    JButton boutonRetour = new JButton("OK");

    /* Constructeur */
    public Parametres() {
        super();
        this.setTitle(StringPerso.creer("Monopoly : Paramètres"));
        this.setSize(500, 250);
        this.setLocationRelativeTo(null);
        this.setContentPane(panelParametres());
    }

    private JPanel panelParametres() {

        // Positions et tailles des objets
        victoireQuartiers.setBounds(250, 25, 200, 25);
        victoireTemps.setBounds(250, 50, 200, 25);
        sliderTemps.setBounds(250, 75, 200, 50);
        joueur1.setBounds(25, 25, 200, 25);
        joueur2.setBounds(25, 55, 200, 25);
        joueur3.setBounds(25, 85, 200, 25);
        joueur4.setBounds(25, 115, 200, 25);
        boutonRetour.setBounds(350, 175, 100, 25);

        // Configuration des objets
        victoireQuartiers.setSelected(true);
        victoireTemps.setSelected(true);
        sliderTemps.setMajorTickSpacing(5);
        sliderTemps.setMinorTickSpacing(1);
        sliderTemps.setPaintTicks(true);
        sliderTemps.setPaintLabels(true);

        // Ajout de listener sur les objets
        victoireQuartiers.addItemListener(this);
        victoireTemps.addItemListener(this);
        joueur1.addFocusListener(this);
        joueur2.addFocusListener(this);
        joueur3.addFocusListener(this);
        joueur4.addFocusListener(this);
        boutonRetour.addActionListener(this);

        // Panel de la fenêtre
        JPanel panel = new JPanel();

        // Layout du panel (null pour placer les boutons où on veut
        panel.setLayout(null);

        // Ajout des objets au panel
        panel.add(victoireQuartiers);
        panel.add(victoireTemps);
        panel.add(sliderTemps);
        panel.add(joueur1);
        panel.add(joueur2);
        panel.add(joueur3);
        panel.add(joueur4);
        panel.add(boutonRetour);

        // Le panel est complet
        return panel;
    }

    @Override
    public void itemStateChanged(ItemEvent e) {
        Object source = e.getItemSelectable();
        if (source == victoireTemps) {
            if (victoireTemps.isSelected()) {
                sliderTemps.setEnabled(true);
            } else {
                sliderTemps.setEnabled(false);
            }
        }
    }

    @Override
    public void focusGained(FocusEvent e) {
        Object source = e.getSource();
        if (source == joueur1 && joueur1.getText().equals("Nom du joueur 1")) {
            joueur1.setText("");
        } else if (source == joueur2 && joueur2.getText().equals("Nom du joueur 2")) {
            joueur2.setText("");
        } else if (source == joueur3 && joueur3.getText().equals("Nom du joueur 3")) {
            joueur3.setText("");
        } else if (source == joueur4 && joueur4.getText().equals("Nom du joueur 4")) {
            joueur4.setText("");
        }
    }

    @Override
    public void focusLost(FocusEvent e) {
        Object source = e.getSource();
        if (source == joueur1 && joueur1.getText().isEmpty()) {
            joueur1.setText("Nom du joueur 1");
        } else if (source == joueur2 && joueur2.getText().isEmpty()) {
            joueur2.setText("Nom du joueur 2");
        } else if (source == joueur3 && joueur3.getText().isEmpty()) {
            joueur3.setText("Nom du joueur 3");
        } else if (source == joueur4 && joueur4.getText().isEmpty()) {
            joueur4.setText("Nom du joueur 4");
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();
        if (source == boutonRetour) {
            Partie.joueurs.clear();
            Menu.CreerJoueur(Partie.parametres.joueur1, 1, "rouge");
            Menu.CreerJoueur(Partie.parametres.joueur2, 2, "bleu");
            Menu.CreerJoueur(Partie.parametres.joueur3, 3, "vert");
            Menu.CreerJoueur(Partie.parametres.joueur4, 4, "rose");
            if (Partie.joueurs.size() >= 2) {
                Menu.tuto.setVisible(false);
            }
            // Partie.plateau = new PlateauSwing(Partie.joueurs);
            this.setVisible(false);
        }
    }
}