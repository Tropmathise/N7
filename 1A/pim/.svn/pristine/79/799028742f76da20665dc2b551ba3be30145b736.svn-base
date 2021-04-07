with Ensembles_Chainage;
with Alea;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Nombre_Moyen_Tirage_Chainage is

    minimum : Constant Integer :=0;
    maximum : Constant Integer :=10;
    Indice : Integer :=0;  --Tirage qui augmente de 1 à chaque ajout
    Nombre : Integer;
    moyenne : Float :=0.0;
    package Alea_Test is
            new Alea (Lower_Bound => minimum,
                      Upper_Bound => maximum);
    use Alea_Test;
    package Ensembles_Chainage_entier is
            new Ensembles_Chainage(Integer);
    use Ensembles_Chainage_entier;

    Ensemble : T_Ensemble;
begin

    for i in 1..100 loop
        Initialiser(Ensemble);
        Indice :=0;
        while Taille(Ensemble) /= maximum-minimum +1 loop
            Get_Random_Number(Nombre);
            Ajouter(Ensemble, Nombre);
            Indice:=Indice+1;
        end loop;
        moyenne := Float(moyenne) + Float(Indice)/100.0;
        Detruire(Ensemble);
    end loop;
    Put(Float'Image(moyenne));

end Nombre_Moyen_Tirage_Chainage;

