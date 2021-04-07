/** Calculer la somme des paramètres de la ligne de commande.
  * @author	Xavier Crégut
  * @version	$Revision$
  */
public class SommeDonneesValides {

	/* Afficher la somme des arguments de la ligne de commande */
	public static void main(String[] args) {
		double somme = 0;
		for (int i = 0; i < args.length; i++) {
			try {
				somme += Double.parseDouble(args[i]);
			} catch (NumberFormatException e) {
				System.out.println(args[i] + " ignorée : mauvais format !");
			}
		}
		System.out.println(somme);
	}

}

