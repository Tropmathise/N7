import java.awt.Color;

/** Afficheur Texte des données de point, segment, ou cercle
 *  @author Thomas SADURNI 
 */

 public class AfficheurTexte {

     public static void afficherPoint(double x, double y, Color couleur) {
         System.out.println("Point {");
         System.out.println("x=" + x);
         System.out.println("y=" + y);
         System.out.println("couleur" + couleur);
         System.out.println("}");
     }
    public static void afficherLigne(double x1, double y1,double x2, double y2, Color couleur) {
         System.out.println("ligne {");
         System.out.println("x1=" + x1);
         System.out.println("y1=" + y1);
         System.out.println("x2=" + x2);
         System.out.println("y2=" + y2);
         System.out.println("couleur" + couleur);
         System.out.println("}");
     }

    public static void afficherCercle(double x, double y, double r, Color couleur) {
         System.out.println("Cercle {");
         System.out.println("centre_x=" + x);
         System.out.println("centre_y=" + y);
         System.out.println("rayon=" + r);
         System.out.println("couleur" + couleur);
         System.out.println("}");
     }

    public static void afficherTexte(double x, double y, String valeur, Color couleur) {
         System.out.println("Texte {");
         System.out.println("x=" + x);
         System.out.println("y=" + y);
         System.out.println("valeur=" + valeur);
         System.out.println("couleur" + couleur);
         System.out.println("}");
     }

 }