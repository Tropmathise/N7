with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


	procedure Initialiser(Abr: out T_ABR) is
    begin
        Abr := Null;
	end Initialiser;


	function Est_Vide (Abr : in T_Abr) return Boolean is
	begin
		return Abr = Null;
	end;


    function Taille (Abr : in T_ABR) return Integer is
    begin
        if Est_vide(Abr) then
            return 0;
        else
            return (1+Taille(Abr.all.Sous_Arbre_Gauche) + Taille(Abr.all.Sous_Arbre_Droit));
            -- return(1+integer'max(Taille(Arbr.all.Sous_abre_Gauche), Taille(Abr.all.sous_arbre_droit));
        end if;
        end Taille;


    procedure Inserer (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
    begin
        if Est_Vide(Abr) then
            Abr := new T_Noeud;
            Abr.all.Cle := Cle;
            Abr.all.Donnee := Donnee;
            Abr.all.Sous_Arbre_Gauche := Null;
            Abr.all.Sous_Arbre_Droit := Null;
        else
            if Cle< Abr.all.Cle then
                if Est_Vide(Abr.all.Sous_Arbre_Gauche) then
                    Abr.all.Sous_Arbre_Gauche := new T_Noeud;
                    Abr.all.Sous_Arbre_Gauche.all.cle := Cle;
                    Abr.all.Sous_Arbre_Gauche.all.Donnee := Donnee;
                else
                    Inserer(Abr.all.Sous_Arbre_Gauche, cle, donnee);
                end if;
            elsif
                    cle > Abr.all.cle then
                if est_vide(Abr.all.Sous_Arbre_Gauche) then
                    Abr.all.Sous_Arbre_Droit := new T_Noeud;
                    Abr.all.Sous_Arbre_Droit.all.cle := Cle;
                    Abr.all.Sous_Arbre_Droit.all.donnee := Donnee;
                else
                    Inserer(Abr.all.Sous_Arbre_Droit, cle, donnee);
                end if;
            else
                raise Cle_Presente_Exception;
            end if;
        end if;
    exception when Cle_Absente_Exception => Put_Line("La clé est déjà présente");
    end Inserer;


	procedure Modifier (Abr : in out T_ABR ; Cle : in Character ; Donnee : in Integer) is
    begin
        if Est_vide(abr) then
            Null;

        else


	end Modifier;


	function La_Donnee (Abr : in T_ABR ; Cle : in Character) return Integer is
	begin
		return 0;	-- TODO : à changer
	end La_Donnee;


	procedure Supprimer (Abr : in out T_ABR ; Cle : in Character) is
	begin
		Null;	-- TODO : à changer
	end Supprimer;


	procedure Vider (Abr : in out T_ABR) is
	begin
		Null;	-- TODO : à changer
	end Vider;


	procedure Afficher (Abr : in T_Abr) is
	begin
		Null;	-- TODO : à changer
	end Afficher;


	procedure Afficher_Debug (Abr : in T_Abr) is
	begin
		Null;	-- TODO : à changer
	end Afficher_Debug;

end ABR;
