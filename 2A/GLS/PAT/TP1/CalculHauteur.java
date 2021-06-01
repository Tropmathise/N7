/**
  * CalculHauteur : calcul la hauteur d'un arbre
  *
  * @author	Thomas SADURNI
  * @version	$Revision$
  */


  public class CalculHauteur implements VisiteurExpression<Integer> {

	public Integer visiterAccesVariable(AccesVariable v) {
		return 1 ;
	}

	public Integer visiterConstante(Constante c) {
		return 1;
	}

	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
		return 1+Math.max(e.getOperandeDroite().accepter(this), e.getOperandeGauche().accepter(this));
	}

	public Integer visiterAddition(Addition a) {
		return 0;
	}

	public Integer visiterMultiplication(Multiplication m) {
		return 0;
	}

	public Integer visiterExpressionUnaire(ExpressionUnaire e) {
		return 1
            + e.getOperande().accepter(this);
	}

	public Integer visiterNegation(Negation n) {
		return 0;
    }

    public Integer visiterSoustraction(Soustraction s) {
		return 0;
	}
}
