package ordo;

public class SortComparatorLexico implements SortComparator{
	
	public SortComparatorLexico(){}

	// Compare deux chaînes selon l'ordre lexicographique
	// Renvoie 0 si les chaînes sont égales.
	// < 0 si k1 est avant k2
	// > 0 si k2 est avant k1
	public int compare(String k1, String k2) {
		return k1.compareToIgnoreCase(k2);
	}

}
