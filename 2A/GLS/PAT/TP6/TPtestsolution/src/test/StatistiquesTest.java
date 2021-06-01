/**
 * StatistiquesTest, classe de test de Statistiques.
 *
 * @author	Xavier Crégut &lt;Prenom.Nom@enseeiht.fr&gt;
 */

package fr.n7.gls.test;

import org.junit.*;
import static org.junit.Assert.*;

import java.util.*;

public class StatistiquesTest {

	@Test
	public void testStatistiquesNominal() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 1, 3, 11, 5, 7);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(1), r.min);
		assertEquals(Integer.valueOf(11), r.max);
		assertEquals(1, r.nbMin);
		assertEquals(1, r.nbMax);
	}

	@Test
	public void testStatistiquesNominalNonCroissant() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 7, 5, 1, 3, 11);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(1), r.min);
		assertEquals(Integer.valueOf(11), r.max);
		assertEquals(1, r.nbMin);
		assertEquals(1, r.nbMax);
	}

	@Test
	public void testStatistiquesNominalVide() {
		List<Integer> l = new ArrayList<>();
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(null, r.min);
		assertEquals(null, r.max);
		assertEquals(0, r.nbMin);
		assertEquals(0, r.nbMax);
	}

	@Test
	public void testStatistiquesNominalMinChange() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 7, 1, 3, 5, 11);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(1), r.min);
		assertEquals(Integer.valueOf(11), r.max);
		assertEquals(1, r.nbMin);
		assertEquals(1, r.nbMax);
	}

	@Test
	public void testStatistiquesNominalPlusieursMin() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 7, 1, 3, 5, 11, 1);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(1), r.min);
		assertEquals(Integer.valueOf(11), r.max);
		assertEquals(2, r.nbMin);
		assertEquals(1, r.nbMax);
	}

	@Test
	public void testStatistiquesNominalPlusieursMax() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 7, 11, 1, 3, 5, 11, 11);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(1), r.min);
		assertEquals(Integer.valueOf(11), r.max);
		assertEquals(1, r.nbMin);
		assertEquals(3, r.nbMax);
	}

	@Test(expected=IllegalArgumentException.class)
	public void testStatistiquesWithNull() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 1, 3, null, 7, 11);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
	}

	@Test	// Les outils de couverture n'aident pas à trouver ce test !
	public void testStatistiquesNominalLimite() {
		List<Integer> l = new ArrayList<>();
		Collections.addAll(l, 3, 3, 3, 3);
		Statistiques.Resultat<Integer> r = new Statistiques().statistiques(l);
		assertEquals(Integer.valueOf(3), r.min);
		assertEquals(Integer.valueOf(3), r.max);
		assertEquals(4, r.nbMin);
		assertEquals(4, r.nbMax);
	}

}
