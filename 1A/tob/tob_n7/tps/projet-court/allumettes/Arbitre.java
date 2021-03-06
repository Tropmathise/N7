package allumettes;

import java.util.InputMismatchException;

/** Un arbitre, comme son nom l'indique, arbitre la partie.
  * Il affiche le nombre d'allumettes restantes et vérifie
  * que les joueurs respectent les règles du jeu. Enfin, il
  * affiche le résultat en fin de partie.
  * @author Thomas SADURNI
  * @version 1.2
  */

public class Arbitre {

    /** Joueur 1 de la partie. */
    private Joueur joueur1;

    /** Joueur 2 de la partie. */
    private Joueur joueur2;

    /** Confiance de l'arbitre. */
    protected boolean confiant;

    /** Constucteur Arbitre. */
    public Arbitre(Joueur j1, Joueur j2) {
        assert(j1 != null);
        assert(j2 != null);
        this.joueur1=j1;
        this.joueur2=j2;
        this.confiant=false;
    }

    public void arbitrer(Jeu jeu) {
        assert(jeu != null);
        assert(jeu.getNombreAllumettes()>0);
        boolean coup_fait = false;  //le coup a été réalisé.
        int nb=0;
        Joueur gagnant = this.joueur1;
        Joueur perdant = this.joueur2;
        while (jeu.getNombreAllumettes()>0){
            Joueur joueur_actuel = this.joueur1; //creation du joueur actuel
            if(coup_fait){
              joueur_actuel=this.joueur2;
            }
            System.out.println("Nombre d'allumettes restantes : " + jeu.getNombreAllumettes());
            System.out.println("Au tour de " + joueur_actuel.getNom() + ".");
            
            try {
                if (this.confiant) {
                    nb = joueur_actuel.getPrise(jeu);
                    if (nb>1) {
                        System.out.println(joueur_actuel.getNom() + " prend " + nb + " allumettes.");
                    }
                    else {
                        System.out.println(joueur_actuel.getNom() + " prend " + nb + " allumette."); 
                    }
                    System.out.println();
                    jeu.retirer(nb);
                }
                else {
                    nb = joueur_actuel.getPrise(new ProcurationJeu(jeu));
                    if (nb>1) {
                        System.out.println(joueur_actuel.getNom() + " prend " + nb + " allumettes.");
                    }
                    else {
                        System.out.println(joueur_actuel.getNom() + " prend " + nb + " allumette."); 
                    }
                    System.out.println();
                    jeu.retirer(nb);
                }
                coup_fait = !coup_fait;
            }

            catch (CoupInvalideException e) {
                if (nb>jeu.getNombreAllumettes()){
                    System.out.println("Erreur ! Prise invalide : " + e.getNombreAllumettes() + " (>" + jeu.getNombreAllumettes() + ")");
                }
                else if (nb>NouveauJeu.PRISE_MAX){
                    System.out.println("Erreur ! Prise invalide : " + e.getNombreAllumettes() + " (>" + NouveauJeu.PRISE_MAX + ")");
                }
                else if (nb<1 || nb==0){
                    System.out.println("Erreur ! Prise invalide : " + e.getNombreAllumettes() + " (<" + 1 + ")");
                }
                System.out.println("Recommencez !");
                System.out.println();
            }

            catch(InputMismatchException e){
                System.out.println("Vous devez donner un entier.");
            }

            catch(OperationInterditeException e){
                System.out.println("Partie abandonnée car "+ joueur_actuel.getNom()+ " a triché !");
                System.exit(0);
            }
        } 

        if (coup_fait) {
            gagnant = this.joueur2;
            perdant = this.joueur1;
        }
        else {
            gagnant = this.joueur1;
            perdant = this.joueur2;
        }
   
        System.out.println(perdant.getNom() + " a perdu !");
        System.out.println(gagnant.getNom() + " a gagné !");
    }

}