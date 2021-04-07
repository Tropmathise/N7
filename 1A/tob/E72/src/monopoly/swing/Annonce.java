package monopoly.swing;

/* Classe pour annoncer les actions et les effets d'un joueur ou du menu. */

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import monopoly.divers.StringPerso;

public class Annonce extends JFrame implements ActionListener {

    private static final long serialVersionUID = 1L;

    private final JButton boutonok = new JButton("OK");
    private JLabel message;

    public static ArrayList<Annonce> listeAnnonces = new ArrayList<Annonce>();

    public Annonce(String message) {
        super();
        int taillemessage=message.length();
        this.message = new JLabel(StringPerso.creer(message));
        this.setTitle("Annonce");
        if (taillemessage>=60) {
            this.setSize(600, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(251, 15, 60, 40);
            this.message.setBounds(25, 63, 500, 25);
        }
        else if (taillemessage>=48 && taillemessage<60) {
            this.setSize(400, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(161, 15, 60, 40);
            this.message.setBounds(45, 63, 290, 25);
        }
        else if (taillemessage<48 && taillemessage>=40){
            this.setSize(400, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(161, 15, 60, 40);
            this.message.setBounds(80, 63, 290, 25);
        }

        else if (taillemessage<40 && taillemessage>=30){
            this.setSize(400, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(161, 15, 60, 40);
            this.message.setBounds(105, 63, 290, 25);
        }

        else if (taillemessage<30 && taillemessage>=20){
            this.setSize(400, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(161, 15, 60, 40);
            this.message.setBounds(120, 63, 290, 25);
        }

        else {
            this.setSize(400, 150);
            this.setLocationRelativeTo(null);
            this.isAlwaysOnTop();
            //position des boutons message et OK
            this.boutonok.setBounds(161, 15, 60, 40);
            this.message.setBounds(150, 63, 290, 25);
        }

        this.boutonok.addActionListener(this);
        this.boutonok.setVisible(true);
        this.message.setVisible(true);
        JPanel panel = new JPanel();
        panel.setLayout(null);
        panel.add(this.boutonok);
        panel.add(this.message);

        this.setContentPane(panel);

        if (Annonce.listeAnnonces.size() >= 1 ) {
            this.setVisible(false);
        }
        else {
            this.setVisible(true);
        }
        Annonce.listeAnnonces.add(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        Object source = e.getSource();
        if (source == boutonok) {
            this.dispose();
        }
    }

    @Override
    public void dispose() {
        Annonce.listeAnnonces.remove(this);
        if (Annonce.listeAnnonces.size() != 0) {
            Annonce.listeAnnonces.get(0).setVisible(true);
        }
        super.dispose();
    }
}