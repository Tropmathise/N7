package monopoly.divers;
import java.util.ArrayList;

/** La classe principale du joueur de Monopoly
 * @author Thomas
 */

public class JoueurMonopoly {

    private String nom;
    private Integer id;
    private Integer solde;
    private Case position = Plateau.cases[0];
    private Integer nbTourDePlateau = 0;
    private Integer nbTourEnPrison = 0;
    private Boolean estEnPrison = false;
    private Boolean aPerdu = false;
    private Integer nbCarteSortiePrison = 0;
    private Integer nbGaresPossedees = 0;
    private Integer nbServicesPossedes = 0;
    private ArrayList<Case> terrains = new ArrayList<Case>();
    private Integer nombreDouble=0;
    private String couleur;
    
    /** remplir si idées */

    /* Constructeur du Joueur de Monopoly */
    public JoueurMonopoly(String nom, Integer id, Integer argent, String couleur){
	    this.nom = nom;
        this.id = id;
        this.solde=argent;
        this.couleur = couleur;
    }

    /** Obtenir le nom du joueur
     * @return son nom
     */
    public String getNom() {
        return this.nom;
    }

    /** Obtenir l'id du joueur 
     * @return son id
     */
    public Integer getId() {
        return this.id;
   }

   /** Obtenir la couleur du joueur 
     * @return sa couleur
     */
    public String getCouleur() {
        return this.couleur;
   }

    /** Obtenir l'argent du joueur
     * @return argent 
     */
    public Integer getSolde() {
        return this.solde;
    }

    /** Obtenir la position du joueur
     * @return sa position
     */
    public Case getPosition() {
        return this.position;
    }

    public void setNom(String nom){
        assert (nom != null);
        this.nom = nom;
    }

     /** Définir l'id du joueur
     * @param Integer son id
     */
    public void setId(Integer id) {
        assert (id > 0);
        this.id = id;
    }

    /** Définir le solde du joueur
     * @param Integer son solde
     */
    public void setSolde(Integer solde){
        assert (solde > 0);
        this.solde =solde;
    }

    /** Ajouter de l'argent au joueur
     * @param montant argent ajouté
     */
    public void ajouterArgent(Integer montant) {
        assert (montant > 0);
        this.solde=this.solde+montant;
    }

    /** Retirer de l'argent au joueur
     * @param debit argent débité
     */
    public void retirerArgent(Integer debit) throws ImpayableException {
        assert (debit >0);
        this.solde = this.solde - debit;
        if (this.solde<=0) {
            this.aPerdu=true;
            throw new ImpayableException();
        }
    }

    /** Définir la position du joueur
     * @param Integer sa position
     */
    public void setPosition(Case position) {
        this.position = position;
    }

    /** Savoir si le joueur a perdu ou non
    * @return Banqueroute 
    */ 
    public Boolean getAPerdu(){
        return this.aPerdu;
    }

    /** Le joueur est banqueroute */
    public void setAPerdu(){
        this.aPerdu= true;
        /* effacer les terrains*/
        /* supprimer son joueur */
    }

    /** Obtenir les terrains du joueur
     * @return terrains
     */
    public ArrayList<Case> getTerrains() {
        return this.terrains;
    }

    /** Ajouter un terrain a la liste du joueur
     * @param nvTerrain
     */
    public void ajouterTerrain(Case terrain) {
        this.terrains.add(terrain);
    }

    /** Obtenir le nombre de passage en prison
     * au bout de 3 le joueur a perdu
     */
    public Integer getToursEnPrison() {
        return nbTourEnPrison;
    }

    /** Definir le nombre de tour en prison
     * @param nbToursPrison nombre de tour en prison
     */
    public void setTourEnPrison(Integer nbToursPrison) {
        assert (nbToursPrison >= 0);
        this.nbTourEnPrison = nbToursPrison;
    }

    /** Savoir si le joueur est en prison
     * @return boolean estEnPrison
     */
    public Boolean getEstEnPrison() {
        return this.estEnPrison;
    }

    /** Mettre le joueur en prison
     * @param allerEnPrison
     */
    public void setEstEnPrison(Boolean allerEnPrison) {
        this.estEnPrison = allerEnPrison;
    }

    /** Savoir le nombre de gares possédé
     * @return nombre de gare en possession
     */
    public Integer getNbGares() {
        return this.nbGaresPossedees;
    }

    /** Defnir le nombre de gare en possession
     * @param nbgares le nombre de gares en possession
     */
    public void setNbGares(Integer nbgares) {
        assert (nbgares >= 0);
        this.nbGaresPossedees= nbgares;
    }
        
    /** Savoir le nombre de services possédé
     * @return nombre de services en possession
     */
    public Integer getNbServices() {
        return this.nbServicesPossedes;
    }

    /** Defnir le nombre de services en possession
     * @param nbservices le nombre de services en possession
     */
    public void setNbServices(Integer nbservices) {
        assert (nbservices >= 0);
        this.nbServicesPossedes= nbservices;
    }

    /** Obtenir le nombre de tours de plateau
     * @return nombre de tours de plateau
     */
    public Integer getNbToursPlateau() {
        return this.nbTourDePlateau;
    }

    /** Obtenir le nombre de double qu'a fait un joueur
     * @return nombre de double
     */
    public Integer getnbDouble(){
        return this.nombreDouble;
    }

    /** Definir le nombre de double d'un joueur
     * @param nbdouble nombre de double
     */
    public void setnbDouble(Integer nbdouble) {
        this.nombreDouble = nbdouble;
    }

    public void incrementerNbDouble() {
        this.nombreDouble++;
    }

    /** Definir le nombre de tours de plateau
     * @param nbTourPlateau nombre de tours de plateau
     */
    public void setNbTourDePlateau(Integer nbTourDePlateau) {
        assert (nbTourDePlateau >= 0);
        this.nbTourDePlateau = nbTourDePlateau;
    }

    /** Savoir si le joueur a une cart de sortie de prison
     * @return possede ou pas la carte sortie de prison
     */
    public Integer getNbCarteSortieDePrison() {
        return this.nbCarteSortiePrison;
    }

    /** Definir si le joueur a une carte sortie de prison
     * @param carte booleen
     */
    public void setNbCarteSortieDePrison(Integer nombre) {
        this.nbCarteSortiePrison = nombre;
    }

    public void decrementerSortiPrison() {
        this.nbCarteSortiePrison--;
    }

}

