with Ensembles_Chainage;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_Ensembles_Chainage is

    type T_Pointeur_Integer is access Integer;
    type T_Pointeur_Character is access Character;

    package Ensemble_Test_Entier is new Ensembles_Chainage(Integer);
    use Ensemble_Test_Entier;
    package Ensemble_Test_Caractere is new Ensembles_Chainage(Character);
    use Ensemble_Test_Caractere;

    procedure Operation (Element : Character) is
    begin
        Put(Element);
        Put(", ");
    end Operation;
    procedure Afficher is new Ensemble_Test_Caractere.Appliquer_Sur_Tous(Operation);


    procedure Test_Initialiser is
        ensemble_test_ent : Ensemble_Test_Entier.T_Ensemble;
        ensemble_test_car : Ensemble_Test_Caractere.T_Ensemble;
    begin
        Initialiser(ensemble_test_ent);
        pragma Assert (Taille(ensemble_test_ent)=0);
        Initialiser(ensemble_test_car);
        pragma Assert (Taille(ensemble_test_car)=0);
    end Test_Initialiser;

    procedure Test_Detruire is
        Ensemble_Test_Ent : Ensemble_Test_Entier.T_Ensemble;
        Ensemble_Test_Car : Ensemble_Test_Caractere.T_Ensemble;
    begin
        Initialiser(Ensemble_Test_Ent);
        Initialiser(Ensemble_Test_Car);
        Ajouter(Ensemble_Test_Ent,5);
        Ajouter(Ensemble_Test_Car,'a');
        Detruire(Ensemble_Test_Car);
        Detruire(Ensemble_Test_Ent);
        Pragma Assert (Taille(Ensemble_Test_Ent)=0);
        Pragma Assert (Taille(Ensemble_Test_Car)=0);
    end Test_Detruire;


    procedure Test_est_present is
        Ensemble_Test_Ent : Ensemble_Test_Entier.T_Ensemble;
        Ensemble_Test_Car : Ensemble_Test_Caractere.T_Ensemble;
    begin
        Initialiser(Ensemble_Test_Ent);
        Initialiser(Ensemble_Test_Car);
        Ajouter(Ensemble_Test_Ent,5);
        Ajouter(Ensemble_Test_Car,'a');
        pragma Assert (est_present(Ensemble_Test_Ent,5));
        pragma Assert (est_present(Ensemble_Test_Car,'a'));
        Supprimer (Ensemble_Test_Ent,5);
        Supprimer (Ensemble_Test_Car,'a');
        pragma Assert (not est_present(Ensemble_Test_Ent,5));
        pragma Assert(not est_present(Ensemble_Test_Car,'a'));
    end Test_est_present;

    procedure Test_est_vide is
        Ensemble_Test_Ent : Ensemble_Test_Entier.T_Ensemble;
        Ensemble_Test_Car : Ensemble_Test_Caractere.T_Ensemble;
    begin
        Initialiser(Ensemble_Test_Ent);
        Initialiser(Ensemble_Test_Car);
        pragma Assert (est_vide(Ensemble_Test_Ent));
        pragma Assert (est_vide(Ensemble_Test_Car));
        Ajouter (Ensemble_Test_Ent,2);
        Ajouter (Ensemble_Test_Car,'a');
        pragma Assert (not est_vide(Ensemble_Test_Ent));
        pragma Assert (not est_vide(Ensemble_Test_Car));
    end Test_est_vide;

    procedure Test_Taille is
        Ensemble_Test_Ent : Ensemble_Test_Entier.T_Ensemble;
    begin
        Initialiser(Ensemble_Test_Ent);
        Pragma Assert (Taille(Ensemble_Test_Ent)=0);
        Ajouter (Ensemble_Test_Ent,1);
        Pragma Assert(Taille(Ensemble_Test_Ent)=1);
        Supprimer (Ensemble_Test_Ent,1);
        Pragma Assert (Taille(Ensemble_Test_Ent)=0);
    end Test_Taille;

begin
    Test_Initialiser;
    Test_Detruire;
    Test_est_vide;
    Test_est_present;
    Test_Taille;
end Test_Ensembles_Chainage;
