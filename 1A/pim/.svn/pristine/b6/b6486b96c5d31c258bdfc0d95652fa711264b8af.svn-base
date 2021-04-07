with Ensembles_Tableau;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Test_Ensembles_Sujet_Tableau is

 -- Instancier le paquetage Ensembles_Tableau pour avoir un Ensemble
 -- d'entiers de capacité 10
    package Ensemble_Test_Entier is new Ensembles_Tableau(10,Integer);
    use Ensemble_Test_Entier;


	-- Définir une opération Afficher qui affiche les éléments d'un ensemble
	-- d'entier en s'appuyant sur Appliquer_Sur_Tous.  L'ensemble {5, 28, 10}
	-- sera affiché :
 --           5         28         10

	Ens1 : T_Ensemble;
    procedure Operation (Element : Integer) is
    begin
        Put(Element,1);
        Put(", ");
    end Operation;

    procedure Afficher is new Ensemble_Test_Entier.Appliquer_Sur_Tous(Operation);

begin
    -- Créer un ensemble vide Ens1
    Initialiser(Ens1);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (est_vide(Ens1));
    pragma Assert (Taille(Ens1)=0);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (not est_present(Ens1,5));
    pragma Assert (not est_present(Ens1,7));
    pragma Assert (not est_present(Ens1,10));

    -- Ajouter 5 dans Ens1
    Ajouter (Ens1, 5);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=1);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (est_present(Ens1,5));
    pragma Assert (not est_present(Ens1,7));
    pragma Assert (not est_present(Ens1,10));

    -- Ajouter 28 puis 10 dans Ens1
    Ajouter (Ens1,28);
    Ajouter (Ens1,10);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
    -- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=3);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (est_present(Ens1,5));
    pragma Assert (not est_present(Ens1,7));
    pragma Assert (est_present(Ens1,10));


    -- Ajouter 7 dans Ens1
    Ajouter (Ens1,7);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=4);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (est_present(Ens1,5));
    pragma Assert (est_present(Ens1,7));
    pragma Assert (est_present(Ens1,10));

    -- Supprimer 10 en Ens1
    Supprimer (Ens1, 10);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=3);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (est_present(Ens1,5));
    pragma Assert (est_present(Ens1,7));
    pragma Assert (not est_present(Ens1,10));

    -- Supprimer 7 en Ens1
    Supprimer (Ens1,7);
    -- Afficher l'ensemble
    Afficher (Ens1);
    New_Line;
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=2);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (est_present(Ens1,5));
    pragma Assert (not est_present(Ens1,7));
    pragma Assert (not est_present(Ens1,10));

    -- Supprimer 5 en Ens1
    Supprimer (Ens1,5);
	-- Afficher l'ensemble
	Afficher (Ens1);
	New_Line;
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
    pragma Assert (not est_vide(Ens1));
    pragma Assert (Taille(Ens1)=1);
    pragma Assert (not est_present(Ens1,2));
    pragma Assert (not est_present(Ens1,5));
    pragma Assert (not est_present(Ens1,7));
    pragma Assert (not est_present(Ens1,10));

    -- Détruire l'ensemble
    Detruire (Ens1);

end Test_Ensembles_Sujet_Tableau;
