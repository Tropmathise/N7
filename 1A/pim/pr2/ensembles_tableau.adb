with Ada.Text_IO; use Ada.Text_IO;
package body Ensembles_Tableau is


    procedure Initialiser (Ensemble : out T_Ensemble) is
    begin
        Ensemble.Taille := 0;
    end Initialiser;

    procedure Detruire (Ensemble : out T_Ensemble) is
    begin
        Ensemble.Taille := 0;
    end Detruire;

    function est_vide (Ensemble : in T_Ensemble) return Boolean is
    begin
        return Ensemble.Taille = 0;
    end est_vide;

    function est_plein (Ensemble : in T_Ensemble) return Boolean is
    plein : Boolean := False;
    begin
        if Ensemble.Taille = Capacite then
            plein := True;
        else
            null;
        end if;
        return plein;
    end est_plein;


    function Taille (Ensemble : in T_Ensemble) return Integer is
    begin
        return Ensemble.Taille;
    end Taille;

    function est_present (Ensemble : in T_Ensemble; Element : in T_Element) return Boolean is
    present : Boolean := False;
    begin
        for i in 1..Ensemble.Taille loop
            if Ensemble.Tab(i)=Element then
                present := True;
            else
                null;
            end if;
        end loop;
        return present;
    end est_present;

    procedure Ajouter (Ensemble : in out T_Ensemble; Element : in T_Element) is
    begin
        if est_present(Ensemble, Element) then
            null;
        else
            Ensemble.Taille := Ensemble.Taille+1;
            Ensemble.Tab(Ensemble.Taille) := Element;
        end if;

    end Ajouter;

    procedure Supprimer (
                         Ensemble : in out T_Ensemble;
                         Element : in T_Element) is
    Indice : Integer := 1;
    begin
        while Indice<=Ensemble.Taille and Ensemble.Tab(Indice) /= Element loop
            Indice := Indice+1;
        end loop;
        if Ensemble.Tab(Indice) = Element then
            Ensemble.Tab(Indice):=Ensemble.Tab(Indice+1);
            Ensemble.Taille := Ensemble.Taille-1;
        end if;
    end Supprimer;

--      procedure Afficher (Ensemble : in T_Ensemble) is
--      begin
--          if not est_vide(Ensemble) then
--              Put("{");
--              for i in 1..Ensemble.Taille loop
--                  --Put(Ensemble.Tab(i));
--                  Put(",");
--             end loop;
--             Put ("}");
--          else
--              Put("{}");
--          end if;
--          New_Line;
--      end Afficher;


    procedure Appliquer_Sur_Tous(Ensemble : in T_Ensemble) is
    begin
        Put("{");
        for i in 1..Ensemble.Taille loop
            Operation(Ensemble.Tab(i));
        end loop;
        Put("}");
        New_Line;
    end Appliquer_Sur_Tous;

end Ensembles_Tableau;
