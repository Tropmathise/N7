/* une PROPOSITION, incomplète et adaptable... */

package ordo;

// Permet de savoir quelle String est la plus petite selon l'ordre lexicographique
// ex : "cat" < "caz" < "cazual" < "dog
public interface SortComparator {
	public int compare(String k1,String k2);
}