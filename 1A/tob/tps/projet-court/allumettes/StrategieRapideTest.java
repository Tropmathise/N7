package allumettes;
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

/** Programme de test de la stratégie rapide.
 * @author Thomas SADURNI
 * @version 1.1
 */

 public class StrategieRapideTest {

    private StrategieRapide stratTest=new StrategieRapide();
    public static final double EPSILON = 1e-6;
    private Strategie strat;
    private Jeu jeu10;
    private Jeu jeu9;
    private Jeu jeu8;
    private Jeu jeu7;
    private Jeu jeu6;
    private Jeu jeu5;
    private Jeu jeu4;
    private Jeu jeu3;
    private Jeu jeu2;
    private Jeu jeu1;

    @Before
    public void setUp() throws Exception {  // Creation de jeu avec un nombre d'allumettes donné.
        strat = new StrategieRapide();
        jeu10 = new NouveauJeu(10);
        jeu9 = new NouveauJeu(9);
        jeu8 = new NouveauJeu(8);
        jeu7 = new NouveauJeu(7);
        jeu6 = new NouveauJeu(6);
        jeu5 = new NouveauJeu(5);
        jeu4 = new NouveauJeu(4);
        jeu3 = new NouveauJeu(3);
        jeu2 = new NouveauJeu(2);
        jeu1 = new NouveauJeu(1);
    }

    @Test
    public void getPriseTest() {
        assertEquals(3,strat.getPrise(jeu10),EPSILON);
        assertEquals(3,strat.getPrise(jeu9),EPSILON);
        assertEquals(3,strat.getPrise(jeu8),EPSILON);
        assertEquals(3,strat.getPrise(jeu7),EPSILON);
        assertEquals(3,strat.getPrise(jeu6),EPSILON);
        assertEquals(3,strat.getPrise(jeu5),EPSILON);
        assertEquals(3,strat.getPrise(jeu4),EPSILON);
        assertEquals(3,strat.getPrise(jeu3),EPSILON);
        assertEquals(2,strat.getPrise(jeu2),EPSILON);
        assertEquals(1,strat.getPrise(jeu1),EPSILON);
    }

    @Test
    public void testStrategierapide() {
        assertNotNull(stratTest);
    }

    @Test
    public void testgetPris() {
        for (int i = 13; i>=Jeu.PRISE_MAX; i--) {
            assertEquals(stratTest.getPrise(new NouveauJeu(i)),3);
        }
        assertEquals(stratTest.getPrise(new NouveauJeu(2)),2);
        assertEquals(stratTest.getPrise(new NouveauJeu(1)),1);
        }
    }
