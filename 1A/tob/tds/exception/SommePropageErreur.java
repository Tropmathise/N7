/** Calculer la somme des paramètres de la ligne de commande.
  * @author	Xavier Crégut
  * @version	$Revision$
  */
public class SommePropageErreur {

	/* Afficher la somme des arguments de la ligne de commande */
	public static void main(String[] args) throws ArgumentIncorrectException {
		try {
			double somme = 0;
			for (int i = 0; i < args.length; i++) {
				somme += Double.parseDouble(args[i]);
			}
			System.out.println(somme);
		} catch (NumberFormatException e) {
			throw new ArgumentIncorrectException(e);
		}
	}

}

