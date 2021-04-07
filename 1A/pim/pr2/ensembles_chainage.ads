generic
    type T_Element is private;

package Ensembles_Chainage is

    type T_Ensemble is limited private;

    -- Initialiser une chaîne
    -- Parametres : Chaine : la chaîne à initialiser
    --
    -- Nécéssité : Rien
    --
    -- Assure : est_vide (Chaine)  = Vrai
    --
    procedure Initialiser (Chaine : out T_Ensemble) with post => est_vide(Chaine);

    -- Détruire une chaine
    -- Parametre : Chaine : la chaine à détruire
    --
    -- Nécessité : est_vide(Chaine) = Faux
    --
    -- Assure : est_vide(Chaine) = Vrai
    --
    procedure Detruire (
                        Chaine : in out T_Ensemble);

    -- Est ce que la chaîne est vide ?
    function Est_Vide (Chaine : in T_Ensemble) return Boolean;

    -- Combien d'éléments contient l'ensemble?
    function Taille (Chaine : in T_Ensemble) return Integer with Post => Taille'Result >= 0;

    -- Est ce que l'élément est présent dans la chaîne ?
    function Est_Present (Chaine: in T_Ensemble; Element : in T_Element) return Boolean;

    -- Ajouter un élement dans la chaine
    procedure Ajouter (Chaine : in out T_Ensemble; Element : in T_Element) with post => Est_present(Chaine, Element);

    -- Supprimer un élément de la chaîne
    procedure Supprimer_ite(Chaine : in out T_Ensemble; Element : in T_Element) with pre => Est_Present(Chaine, Element), Post => not est_present (Chaine, Element);

    --Supprimer recursivement un élément de la chaine
    procedure Supprimer (Chaine : in out T_Ensemble; Element : in T_Element);

    -- Afficher les elements de l'ensmeble
    generic
        with procedure Operation (Element: in T_Element);
    procedure Appliquer_Sur_Tous(Chaine : in T_Ensemble);


private
    type T_Cellule;
    type T_Ensemble is access T_Cellule;
    type T_Cellule is record
        Element : T_Element;
        Suivant : T_Ensemble;
    end record;

end Ensembles_Chainage;
