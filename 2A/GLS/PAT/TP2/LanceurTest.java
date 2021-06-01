public class LanceurTest {
    LanceurIndependant lanceurInde;

    public void preparer(){
        lanceurInde=new LanceurIndependant("MonnaieTest");
    }
    public void testerNbTest() {
        Assert.assertTrue(lanceurInde.getNbTests()==6);
    }
    public void testerNbEchec() {
        Assert.assertTrue(lanceurInde.getNbEchecs()==2);
    }
    public void testerNbErreur() {
        Assert.assertTrue(lanceurInde.getNbErreurs()==2);
    }
}
