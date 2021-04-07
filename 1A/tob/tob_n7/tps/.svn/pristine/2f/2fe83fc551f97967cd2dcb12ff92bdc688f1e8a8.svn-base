package allumettes;
import java.util.Scanner;

/** La strategie huamine consiste à faire jouer un humain.
  * @author Thomas SADURNI
  * @version 1.3
  */
public class StrategieHumaine implements Strategie{

    /** Le scanner. */
    protected Scanner scanner;

    /** Constructeur de la classe. */
    public StrategieHumaine(){
        this.scanner = new Scanner(System.in);
    }

    @Override
    public int getPrise(Jeu jeu) {
        assert(jeu != null);
        int n = jeu.getNombreAllumettes();
        assert(n>0);
        int nb = 111;

        while (nb==111){
            System.out.print("Combien prenez-vous d'allumettes ? ");
            try {
                nb = Integer.parseInt(this.scanner.nextLine());
            }
            catch (NumberFormatException e) {
                System.out.println("Vous devez donner un entier.");
            }
        }
        return nb; 
    }

}
