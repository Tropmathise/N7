package monopoly.divers;

/** Le type des dfférentes cases.
 * @author Theo
 */

public enum TypeCase {
    PAIEMENT, 	//écrit et traité
    PROPRIETE,	
    COMPAGNIE, 	
    CHANCE, 	//écrit
    CDC, 		//écrit
    PRISON,		// rien à faire
    GOPRISON,	
    PARC,		//écrit et traité
    DEPART,		//écrit et traité
    GARE,		
    UNKNOWN;

    public static TypeCase fromString(String str) {
        switch(str) {
            case "PAIEMENT":
                return TypeCase.PAIEMENT;
            case "PROPRIETE":
                return TypeCase.PROPRIETE;
            case "COMPAGNIE":
                return TypeCase.COMPAGNIE;
            case "CHANCE":
                return TypeCase.CHANCE;
            case "CDC":
                return TypeCase.CDC;
            case "PRISON":
                return TypeCase.PRISON;
            case "GOPRISON":
                return TypeCase.GOPRISON;
            case "PARC":
                return TypeCase.PARC;
            case "DEPART":
                return TypeCase.DEPART;
            case "GARE":
                return TypeCase.GARE;
            default:
                System.out.println("Type de carte inconnu");
                return TypeCase.UNKNOWN;
        }
    }
}