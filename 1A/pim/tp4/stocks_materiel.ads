
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);
    
    type T_Materiel is record 
        NumeroSerie : Integer;
        Nature : T_Nature;
        Annee_Achat : Integer;
        Etat : Boolean;
    end record;
    

    type T_Stock is limited private;

    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels dans le stock Stock
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;


    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
                    Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;

    -- Mettre à jour l'état d'un materiel à aprtir de son numéro de série 
    -- 
    -- Parametres : 
    --    Stock : le stock à utiliser 
    --    Numero_Serie : le suméro de série du materiel à mettre à jour 
    --    Etat : l'état du materiel avant la maj 
    --
    -- Necessité : 
    --    Nb_Materiel (Stock) > 0
    -- 
    -- Assure 
    --
    procedure Maj ( 
                    Stock : in out T_Stock;
                    Numero_Serie : in Integer;
                    Etat : in Boolean
                   ) with 
            Pre => Nb_Materiels(Stock) > 0;
            
    
    
    -- Supprimer un matériel dans le stock
    -- 
    -- Parametres :
    --    Stock : le stock à utiliser 
    --    Numero_Serie : Le numero de serie du materiel à supprimer
    --
    -- Necessité :
    --    Nb_Materiels (Stock) > 0
    --
    -- Assure :
    --   Materiel supprimé
    --   Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant -1
    procedure Supprimer ( 
                          Stock  : in out T_Stock;
                          Numero_Serie : in Integer
                         ) with 
            Pre => Nb_Materiels (Stock) > 0,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old-1;
            
    
    
            
    -- Afficher tous les materiels du stock
    -- 
    -- Parametres :
    --   Stock : le stock à utiliser 
    --   
    -- Necessité: 
    --   Nb_Materiels (Stock) <= CAPACITE
    --
    -- Assure:
    --   Affiche tous les materiels dans le terminal 
    --
    procedure Afficher ( 
                         Stock : in out T_Stock;
                         Etat : in Boolean;
                         Numero_Serie : in Integer;
                         Nature : in integer;
                         Annee_Achat : in integer
                        ) with 
            Pre => Nb_Materiels(stock) < CAPACITE;
    
    -- Supprimer tous les materiels qui ne sont pas en état de fonctionnement
    -- 
    -- Parametres :
    --   Stock : le stock à utiliser 
    --   Etat : l'etat du materiel 
    --
    -- Necessite 
    --
    -- Assure :
    --   Materiel Supprimé
    --   Nb_Materiel(Stock) >= Nb_Materiel(stock)'Avant 
    procedure Supprimer_Etat_HS ( 
                                  Stock : in out T_Stock
                                 ) with 
            Post => Nb_Materiels(Stock) >= Nb_Materiels(Stock)'Old;
    
    
                    
     
                   
  
private
    type T_Stock is array (1..CAPACITE) of T_Materiel;
  

end Stocks_Materiel;
