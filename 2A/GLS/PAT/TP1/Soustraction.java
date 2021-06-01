public class Soustraction implements OperateurBinaire {

	@Override
	public <R> R accepter(VisiteurExpression<R> visiteur) {
		return visiteur.visiterSoustraction(this);
	}

}