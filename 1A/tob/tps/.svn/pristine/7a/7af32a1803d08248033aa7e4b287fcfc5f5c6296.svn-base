import java.util.*;
import java.util.stream.Collectors;
import java.io.*;
import java.util.zip.*;
import java.time.LocalDateTime;


/**
 * La classe principale.
 *
 * Tous les traitements demandés sont faits dans la mêthode
 * {@code repondreQuestions}.
 * Il serait plus logique d'écrire des méthodes qui pemettraient d'améliorer
 * la structuration et la réutilisation.  Cependant l'objectif est ici la
 * manipulation de l'API des collections, pas la structuration du code
 * en sous-programmes.
 */

public class Main {

	private static void repondreQuestions(Reader in) {
		Iterable<PointDeVente> iterable = PointDeVenteUtils.fromXML(in);

		// Construire un tableau associatif (pdvs) des points de vente avec un
		// accès par identifiant
		Map<Long, PointDeVente> pdvs = new HashMap<>();
		for (PointDeVente pointDeVente : iterable) {
			pdvs.put(pointDeVente.getIdentifiant(), pointDeVente);
		}


		// Nombre de point de vente
		System.out.println("Nombre de point de vente: " + pdvs.size());


		// Afficher le nombre de services existants
		HashSet<String> services = new HashSet<String>();
		for(PointDeVente pointDeVente: iterable) {
			services.addAll(pointDeVente.getServices());
		}

		// Afficher les services fournis
		System.out.println("Services fournis : ");
		for (String service : services) {
			System.out.println(service);
		}

		// Afficher le prix du gazole pour le point de vente d'identifiant
		// 31075001 le 25 janvier 2017 à 10h.
		int prix = pdvs.get(31075001L).getPrix(Carburant.GAZOLE, LocalDateTime.parse("2017-01-25T10:00:00"));
		System.out.println("prix de 31075001 le 25 janvier 2017 à 10h:" + prix);


		// Afficher le nombre de offrant au moins un point de vente


		// Afficher le nombre moyen de points de vente par ville


		// le nombre de villes offrants un certain nombre de carburants


		// Afficher le nombre et les points de vente dont le code postal est 31200


		// Nombre de PDV de la ville de Toulouse qui proposent et du Gazole
		// et du GPLc.


		// Afficher le nom et le nombre de points de vente des villes qui ont au
		// moins 20 points de vente
	}


	private static Reader ouvrir(String nomFichier)
			throws FileNotFoundException, IOException
	{
		if (nomFichier.endsWith(".zip")) {
			// On suppose que l'archive est bien formée :
			// elle contient fichier XML !
			ZipFile zfile = new ZipFile(nomFichier);
			ZipEntry premiere = zfile.entries().nextElement();
			return new InputStreamReader(zfile.getInputStream(premiere));
		} else {
			return new FileReader(nomFichier);
		}
	}


	public static void main(String[] args) throws FileNotFoundException {
		if (args.length != 1) {
			System.out.println("usage : java Main <fichier.xml>");
		} else {
			try (Reader in = ouvrir(args[0])) {
				repondreQuestions(in);
			} catch (FileNotFoundException e) {
				System.out.println("Fichier non trouvé : " + args[0]);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
	}

}
