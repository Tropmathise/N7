with Ada.Unchecked_Deallocation;
with Ada.Text_IO;  use Ada.Text_IO;

package body Ensembles_Chainage is

    procedure Free is new Ada.Unchecked_Deallocation (T_Cellule, T_Ensemble);

    procedure Initialiser (Chaine : out T_Ensemble) is
    begin
        Chaine := Null;
    end Initialiser;

    procedure Detruire (Chaine : in out T_Ensemble) is
    begin
        if Chaine /= Null then
            Detruire (Chaine.all.Suivant);
            Free(Chaine);
        else
            Null;
        end if;
    end Detruire;

    function Est_Vide(Chaine : in T_Ensemble) return Boolean is
    begin
        return Chaine = Null;
    end Est_Vide;

    function Taille(Chaine : in T_Ensemble) return Integer is
        Chaine2 : T_Ensemble := Chaine;
        somme : Integer :=0;
    begin
        while Chaine2/= Null loop
            somme := somme + 1;
            Chaine2 := Chaine2.all.Suivant;
        end loop;
        return somme;
    end Taille;

    function Est_Present(Chaine : in T_Ensemble; Element : in T_Element) return Boolean is
        Chaine2 : T_Ensemble := Chaine;
    begin
        while Chaine2 /= Null and then Chaine2.all.ELement /= Element loop
            Chaine2 := Chaine2.all.suivant;
        end loop;
        return Chaine2 /= Null;
    end Est_Present;

    procedure Ajouter (Chaine : in out T_Ensemble; Element : in T_Element) is
        Chaine2 : T_Ensemble := Chaine;
    begin
        if Chaine = Null then
            Chaine := new T_Cellule;
            Chaine.all.Element := Element;
            Chaine.all.Suivant := Null;
        elsif not Est_Present(Chaine, Element) then
            while Chaine2.all.suivant /= null loop
                Chaine2 := Chaine2.all.suivant;
            end loop;
            Chaine2.all.Suivant := new T_Cellule;
            Chaine2.all.Suivant.all.Element := Element;
            Chaine2.all.suivant.all.suivant := Null;
        else
            null;
        end if;
    end Ajouter;

    procedure Supprimer_ite (Chaine : in out T_Ensemble; Element : in T_Element) is
        Chaine2 : T_Ensemble := Chaine;
    begin
        if Chaine.all.element=Element then
            Chaine := Chaine.all.suivant;
        else
            while Chaine2.all.suivant.all.element /= Element loop
                Chaine2:=Chaine2.all.suivant;
            end loop;
            chaine2.all.suivant := chaine2.all.suivant.all.suivant;
        end if;
    end Supprimer_ite;

    procedure Supprimer (Chaine : in out T_Ensemble; Element : in T_Element) is --Supprimer recursivement
        Chaine2 : T_ensemble;
    begin
        if Est_Vide(Chaine) then
            Null;
        elsif
            Chaine.all.Element=Element then
            Chaine2 := Chaine.all.suivant;
            Free(Chaine);
            Chaine := Chaine2;
        else
            Chaine2 := chaine.all.suivant;
            if Chaine2 /= null and then Chaine2.all.element=element then
                Chaine.all.suivant := chaine2.all.suivant;
                Free(Chaine2);
            else
                Supprimer(Chaine2.all.suivant, Element);
            end if;
        end if;
    end Supprimer;

    procedure Appliquer_Sur_Tous (Chaine : in T_Ensemble) is
    begin
        if Chaine=Null then
            Null;
        elsif Chaine.all.Suivant = Null then
            Put('{');
            --Put(" ");
            Operation (Chaine.all.Element);
            --Put('}');
        else
            Appliquer_Sur_Tous(Chaine.all.Suivant);
            --Put(", ");
            Operation(Chaine.all.Element);
            --Put('}');
        end if;
        --Put('}');

    end Appliquer_Sur_Tous;


end Ensembles_Chainage;
