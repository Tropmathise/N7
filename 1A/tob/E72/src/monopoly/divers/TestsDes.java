// package monopoly;

// import org.junit.Test;
// import org.junit.Before;

// /** Classe de test de la classe Des
//  * 
//  * @author Nicolas
//  * @version 1.0
//  *
//  */
// public class TestsDes {

// 	int nbTests = 100;	// Nombre de tests
// 	Des des = new Des(1,1);	// Construire les dés à tester
	
// 	@Test
// 	public void testLancerDes() {
// 		for (int i = 0; i < nbTests; i++) {
// 			des.lancerDes();
// 			// Vérifier que le dé 1 à un résultat entre 1 et 6 inclus
// 			assert(1 <= des.getDe1());
// 			assert(des.getDe1() <= 6);
// 			// Vérifier que le dé 2 à un résultat entre 1 et 6 inclus
// 			assert(1 <= des.getDe2());
// 			assert(des.getDe2() <= 6);
// 		}
// 	}

// }
