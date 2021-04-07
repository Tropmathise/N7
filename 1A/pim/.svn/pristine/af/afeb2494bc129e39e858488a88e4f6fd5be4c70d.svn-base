with Ada.Text_IO;       use Ada.Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
-- Exemple d'utilisation des vecteurs creux.
procedure Exemple_Vecteurs_Creux is

	V : T_Vecteur_Creux;
begin
    Put_Line ("Début du scénario");

    -- Initialisation
    Initialiser(V);
    Afficher(V);
    New_Line;

    -- vecteur nul?
    if Est_Nul(V) then
        Put("V est nul");
    Else
        Put("V est non nul");
    end if;

    New_Line;

    --Destruction
    Detruire (V);
    Put("V est détruit");
    New_Line;

    -- Composante récursive
    Put(Composante_Recursif(V,18),1,2,0);
    New_Line;

    -- Composante itératif
    Put(Composante_Iteratif(V,18),1,2,0);
    New_Line;

    -- Modification de la composante
    Modifier(V,18,12.0);
    Afficher(V);
    New_Line


	Put_Line ("Fin du scénario");
end Exemple_Vecteurs_Creux;
