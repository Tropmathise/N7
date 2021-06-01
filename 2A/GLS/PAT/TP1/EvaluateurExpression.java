import java.util.*;

public class EvaluateurExpression implements VisiteurExpression<Integer>{
    
    private Map<String, Integer> envi;

    public EvaluateurExpression(Map<String, Integer> envi){
        this.envi=envi;
    }
    
    @Override
    public Integer visiterAccesVariable(AccesVariable v) {
		return envi.get(v.getNom()) ;
	}

    @Override
	public Integer visiterConstante(Constante c) {
		return c.getValeur();
    }
    
    @Override
	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
        int gauche = e.getOperandeGauche().accepter(this);
        int droite = e.getOperandeDroite().accepter(this);
        int  operateur = e.getOperateur().accepter(this);
        int res =0;
        switch(operateur){
            case 0:
                res = gauche + droite;
                break;
            case 1:
                res = gauche * droite;
                break;
            case 2: 
                res = gauche - droite;
                break;
            default: 
                break;
        }
        return res;
    }
    
    @Override
	public Integer visiterAddition(Addition a) {
		return 0;
    }
    
    @Override
	public Integer visiterMultiplication(Multiplication m) {
		return 1;
    }
    
    @Override
	public Integer visiterExpressionUnaire(ExpressionUnaire e) {
		return e.getOperateur().accepter(this)*e.getOperande().accepter(this);
    }
    
    @Override
	public Integer visiterNegation(Negation n) {
		return (-1);
    }

    @Override
    public Integer visiterSoustraction(Soustraction s) {
		return 2;
	}  
}
