/** Lecture de fichier avec un chemin local.
 * @author E72
 * @version 1.0
*/

package monopoly.divers;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

public final class Fichier {

    /** Lecture permet la lecture d'un fichier texte.
     * 
     * @param nomFichier Son nom + extension. Exemple : "Text.txt".
     * @param nbLignesUtiles Nombre de lignes non commentaires (ne commençant pas par //).
     * @return Un tableau ordonné des lignes du fichier.
     * @throws IOException
     */
    public static String[] Lecture(String nomFichier, Integer nbLignesUtiles) throws IOException {
            String tab[] = new String[nbLignesUtiles];
            Fichier read = new Fichier();
        try (
            InputStream input = read.getClass().getResourceAsStream(nomFichier);
            InputStreamReader isr = new InputStreamReader(input, ENCODING);
            BufferedReader reader = new BufferedReader(isr);
        )
        {
            Integer indice = 0;
            String line = null;
            while ((line = reader.readLine()) != null) {
                if (!("//".equals(line.substring(0, 2)))) {
                    tab[indice] = line;
                    indice++;
                }
            }
        }
        return tab;
    }    
  
    private final static Charset ENCODING = StandardCharsets.UTF_8;
  
}