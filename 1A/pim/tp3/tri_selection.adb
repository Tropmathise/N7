with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

-- Objectif : Afficher un tableau trié suivant le principe du tri par sélection.

procedure Tri_Selection is

    CAPACITE: constant Integer := 10;   -- la capacité du tableau

    type Tableau_Entier is array (1..CAPACITE) of Integer;

    type Tableau is
        record
            Elements : Tableau_Entier;
            Taille   : Integer;         --{ Taille in [0..CAPACITE] }
        end record;


    -- Objectif : Afficher le tableau Tab.
    -- Paramètres :
    --     Tab : le tableau à afficher
    -- Nécessite : ---
    -- Assure : Le tableau est affiché.
    procedure Afficher (Tab : in Tableau) is
    begin
        Put ("[");
        if Tab.Taille > 0 then
            -- Afficher le premier élément
            Put (Tab.Elements (1), 1);

            -- Afficher les autres éléments
            for Indice in 2..Tab.Taille loop
                Put (", ");
                Put (Tab.Elements (Indice), 1);
            end loop;
        end if;
        Put ("]");
    end Afficher;

    procedure Trier (Tab : in out Tableau) is
        memoire : Integer ; -- mémorise l'élément qui est traité
        min : Integer ; --minimum de la liste restante
        indice : integer := 1 ; -- indice du minimum
    begin
        for i in 1..Tab.Taille loop
            min := Tab.Elements(i);
            for j in i..Tab.Taille loop
                if Tab.Elements (j) < min then
                    min := Tab.Elements(j);
                    indice := j;
                else null;
                end if;
            end loop;
            memoire := Tab.Elements(indice);
            Tab.Elements(indice) := Tab.Elements(i);
            Tab.Elements(i) := memoire;
        end loop;
    end Trier;



    Tab1 : Tableau;
begin
    -- Initialiser le tableau
    Tab1 := ( (1, 3, 4, 2, others => 0), 4);
    Trier(Tab1);
    -- Afficher le tableau
    Afficher (Tab1);
    New_Line;

end Tri_Selection;
