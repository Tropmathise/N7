generic
    Capacite : Integer; -- Nombre maximal d'éléments que l'ensemble peut contenir
    type T_Element is private; -- Type d'élément dans l'ensemble


package Ensembles_Tableau is

    type T_Ensemble is limited private;
    type T_Tableau is limited private;

    -- Initialiser un ensemble
    -- Parametres : Ensemble : l'ensemble à initialiser
    --
    -- Nécéssité : Rien
    --
    -- Assure : est_vide (Ensemble)  = Vrai
    --
    procedure Initialiser (
                           Ensemble : out T_Ensemble);


    -- Détruire un ensemble
    -- Parametre : Ensemble : l'ensemble à détruire
    --
    -- Nécessité : est_vide(Ensemble) = Faux
    --
    -- Assure : est_vide(Ensemble) = Vrai
    --
    procedure Detruire (
                        Ensemble : out T_Ensemble);


    -- Est-ce que l'ensemble est vide ?
    -- Parametre : Ensemble : l'ensemble concérné
    --
    -- Nécessité : Rien
    --
    -- Assure : Rien
    --
    function est_vide (Ensemble : in T_Ensemble) return Boolean;

    -- Est ce que l'ensemble est plein?
    -- Parametre : Ensemble : l'ensemble concérné
    --
    -- Nécéssité : Rien
    -- Assure : Rien
    function est_plein ( Ensemble : in T_Ensemble) return Boolean;

    -- Obtenir la taille d'un ensemble
    -- Paramètre : Ensemble
    --
    -- Nécessité : Rien
    --
    -- Assure : taille <= Capacite et taille >= 0
    --
    function Taille (Ensemble : in T_Ensemble) return Integer
            with Post => Taille'Result <= Capacite and Taille'Result >= 0;

    -- Savoir si un élément est dans l'ensemble
    -- Parametre : Ensemble : l'ensemble dans lequel on cherche l'élément
    --             Element : l'élément que l'on cherche
    --
    -- Nécéssité : Rien
    --
    -- Assure : l'élément est dans l'ensemble ou non
    function est_present (
                       Ensemble : in T_Ensemble;
                       Element : in T_Element
                      ) return Boolean;

    -- Ajouter un élément dans un ensemble
    -- Paramètre : Ensemble : l'ensemble dans lequel ajouter l'élément
    --             Element : l'élément à ajouter
    --
    -- Necéssité : L'élement n'est pas dejà dans l'ensemble
    --
    -- Assure : Taille.Ensemble = Taille.Ensemble + 1
    --
    procedure Ajouter (
                       Ensemble : in out T_Ensemble;
                       Element : in T_Element
                      ) with Post => est_present(Ensemble, Element);

    -- Supprimer un élement d'un ensemble
    -- Paramètre : Ensemble : l'ensemble dans lequel supprimer un élément
    --             Element : l'élément à supprimer de l'ensemble*
    --
    -- Nécéssité : l'ensemble n'est pas video
    --
    -- Assure : l'élément a été supprimé de l'ensemble
    --
    procedure Supprimer (
                         Ensemble : in out T_Ensemble;
                         Element : in T_Element) with Pre => not est_vide(Ensemble);


    -- Afficher les élements de l'ensemble
    -- Parametre : Ensemble : l'ensemble que l'on veut afficher
    -- Necessité : Rien
    -- Assure : l'ensemble est bien affiché
--    procedure Afficher (Ensemble : in T_Ensemble);


    -- Appliquer une opération sur chaque élément de l'ensemble
    -- Parametre : Ensemble : l'ensemble des éléments auxquel appliquer l'opération
    --             Opération : l'opération à appliquer aux éléments
    -- Nécéssité : not est_vide(Ensemble)
    -- Assure : l'opération est bien effectuée
    generic
        with procedure Operation (Element : in T_Element);
    procedure Appliquer_Sur_Tous (Ensemble : in T_Ensemble);


private

    type T_Tableau is array (1..Capacite) of T_Element;
    type T_Ensemble is
        record
            Tab : T_Tableau; -- les éléments de l'ensemble
            Taille : Integer; -- Nombre d'éléments dans l'ensemble
        end record;


end Ensembles_Tableau;
