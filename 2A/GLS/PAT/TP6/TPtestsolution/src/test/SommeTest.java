/**
 * SommeTest, classe de test de Somme.
 *
 * @author	Xavier Crégut &lt;Prenom.Nom@enseeiht.fr&gt;
 */

package fr.n7.gls.test;

import java.io.*;

import org.junit.*;
import static org.junit.Assert.*;

import org.mockito.*;
import org.mockito.junit.*;
import static org.mockito.Mockito.*;

public class SommeTest {

	@Rule public MockitoRule mockito = MockitoJUnit.rule();

	public Somme somme;

	@Before
	public void setUp() {
		this.somme = new Somme();
	}

	@Test
	public void testerSommeAvecUnVraiFichier() throws Exception {

		// Créer le fichier pour le test
		File fichier = File.createTempFile("tmp", ".txt");
		try (PrintWriter bw = new PrintWriter(new FileWriter(fichier))) {
			bw.println("10");
			bw.println("30");
			bw.println("20");
		}

		// L'utiliser pour le test
		try (BufferedReader br = new BufferedReader(new FileReader(fichier))) {
			assertEquals(60, somme.somme(br));
		}

		// Effacer le fichier
		fichier.delete();

	}

	@Test
	public void testerSommeAvecUneDoublure() throws Exception {
		BufferedReader mockedBufferedReader = Mockito.mock(BufferedReader.class);
		when(mockedBufferedReader.readLine()).thenReturn("10", "30", "20", null);

		assertEquals(60, somme.somme(mockedBufferedReader));
	}

	@Test
	public void testerSommeMockAvecDonneesAvecZero() throws Exception {
		BufferedReader mockedBufferedReader = Mockito.mock(BufferedReader.class);
		when(mockedBufferedReader.readLine()).thenReturn("5", "0",  "3", null);

		Erreurs mockedErreurs = Mockito.mock(Erreurs.class);

		assertEquals(8, somme.somme(mockedBufferedReader, mockedErreurs));

		verify(mockedErreurs, never()).signaler(eq("0"), anyString());
	}

	@Test
	public void testerSommeMockAvecDonneesInvalides() throws Exception {
		BufferedReader mockedBufferedReader = Mockito.mock(BufferedReader.class);
		when(mockedBufferedReader.readLine()).thenReturn("1", "-5",  "2", "xxx", "4", null);

		Erreurs mockedErreurs = Mockito.mock(Erreurs.class);

		assertEquals(7, somme.somme(mockedBufferedReader, mockedErreurs));

		// Vérifier les appels à signaler, peu importe l'ordre
		verify(mockedErreurs).signaler("xxx", "Pas un entier !");
		verify(mockedErreurs).signaler("-5", "Valeur négative");

		// Vérifier les appels à signaler dans l'ordre (il peut y avoir d'autres
		// appels entre deux appels vérifiés).
		InOrder inOrder = inOrder(mockedErreurs);
		inOrder.verify(mockedErreurs).signaler("-5", "Valeur négative");
		inOrder.verify(mockedErreurs).signaler("xxx", "Pas un entier !");
	}

	@Test(expected=IOException.class)
	public void testerSommeMockIOException() throws Exception {
		BufferedReader mockedBufferedReader = Mockito.mock(BufferedReader.class);
		when(mockedBufferedReader.readLine()).thenReturn("1", "-1", "2", "trois")
			.thenThrow(new IOException())
			.thenReturn("10", "20", null);

		Erreurs mockedErreurs = Mockito.mock(Erreurs.class);

		somme.somme(mockedBufferedReader, mockedErreurs);

		// Les instructions suivantes ne seront pas exécutées
		verify(mockedErreurs).signaler("-1", "Valeur négative");
		verify(mockedErreurs).signaler("trois", "Pas un entier !");
	}

}
