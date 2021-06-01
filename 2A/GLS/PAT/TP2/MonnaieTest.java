/** Classe regroupant les tests unitaires de la classe Monnaie.  */


public class MonnaieTest {

	protected Monnaie m1;
	protected Monnaie m2;

	public @Avant void preparer() {
		this.m1 = new Monnaie(5, "euro");
		this.m2 = new Monnaie(7, "euro");
	}

	public @UnTest void testerAjouter() throws DeviseInvalideException {
		m1.ajouter(m2);
		Assert.assertTrue(m1.getValeur() == 12);
	}

	public @UnTest void testerRetrancher() throws DeviseInvalideException {
		m1.retrancher(m2);
		Assert.assertTrue(m1.getValeur() == -2);
	}

}