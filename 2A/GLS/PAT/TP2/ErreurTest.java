/** ErreurTest est un programme de test qui définit trois méthodes de test
  * dont une provoque une erreur.
  */
public class ErreurTest {
	
	public @UnTest void tester1() {
	}

	public @UnTest void tester2() {
		Assert.assertTrue(false);
	}

	public @UnTest void tester3() {
		Assert.assertTrue(true);
	}

}
