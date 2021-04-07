package monopoly.divers;

/** Le type des différentes cartes.
 * @author Theo
 */

public enum TypeCarte {
    PAYER,
    RECEVOIR,
    MOUVEMENT,
    TELEPORTATION,
    GOPRISON,
    SORTIEPRISON,
    UNKNOWN;

    public static TypeCarte fromString(String str) {
        switch(str) {
            case "PAYER":
                return TypeCarte.PAYER;
            case "RECEVOIR":
                return TypeCarte.RECEVOIR;
            case "MOUVEMENT":
                return TypeCarte.MOUVEMENT;
            case "TELEPORTATION":
                return TypeCarte.TELEPORTATION;
            case "GOPRISON":
            	return TypeCarte.GOPRISON;
            case "SORTIEPRISON":
            	return TypeCarte.SORTIEPRISON;
            default:
                System.out.println("Type de case inconnu.");
                return TypeCarte.UNKNOWN;
        }
    }
}