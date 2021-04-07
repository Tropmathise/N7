--------------------------------------------------------------------------------
--  Auteur   : Thomas SADURNI
--  Objectif : Réviser ses tables de multiplicaitons 
--------------------------------------------------------------------------------

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Calendar;          use Ada.Calendar;
With Alea;

procedure Multiplications is
    
    -- Réviser ses tables de multiplications comprises entre 
    -- 1 et 10 en montrant le nombre d'erreur et le temps 
    -- moyen mis pour répondre à une question et en affichant
    -- une table conseillée de réviser en fonction du temps 
    -- de réponses et du nombre d'erreurs. L'utilisateur devra
    -- répondre à 10 opérations.
    --
    -- Type : procédure
    --
    -- Parametres : /
    -- 
    -- Nécessité : /
    -- 
    -- Assure : / 
    -- 

    -- Variables locales
    nb : Integer ; -- demander le nombre de multiplication
    error : Integer := 0;-- nombre d'erreurs 
    correct : Integer := 0; -- nombre de réponses justes 
    temps : Duration ; -- temps mis pour une réponse
    Debut: Time ;         -- heure de début de l'opération
    Fin: Time;           -- heure de fin de l'opération 
    maxtemps : float := 0.0; -- temps max mis pour une réponse 
    tempsmoyen : float :=0.0 ; --temps moyen pour une réponse
    continuer : Boolean := True ; 
    n : Integer; -- table à reviser 
    resultat : Integer; -- resultat donné pour la multiplication
    conseildetable : Integer ; -- table conseillée à réviser 
    a : Character ; --reponse à on continue ? 
    -- 
    -- package pour le nombre aléatoire --
    package aleatoire is 
            new Alea (1,10);
    use aleatoire;
    rn : Integer ; -- nombre aleatoire entre 1 et 10
    
    -- début du programme principale 
begin
    -- Demander la table à réviser entre 0 et 10 
    while continuer loop -- demmarage de la boucle répéter 
        Put ("Table à réviser: ");    -- demande la table à réviser
        Get (n); Skip_Line;
        if n<1 and n>10 then           -- verifie si la table entrée est entre 1 et 10
            Put ("Veuillez saisir un nombre entre 1 et 10");
            Get(n); Skip_Line;
        else 
            null;
        end if;
        Put ("Nombre d'opérations: ");    -- demande le nombre d'opérations
        Get (nb);
        for m in 1..nb loop  -- affichage des multiplications 
            Put ("M" & Integer'Image(m) & ":");
            Get_Random_Number (rn);
            Put (Integer'Image(n) & "*" & Integer'Image(rn) & "=");
            Debut := Clock; -- récupérer l'heure de début de l'opération
            Get(resultat);
            Fin := Clock; -- récupérer l'heure de fin de l'opération 
            temps := Fin-Debut; -- calculer le temps de l'opération 
            -- Calcul du temps moyen et comparaison à la moyenne
            if Float(temps)>Float(maxtemps) then
                maxtemps := float(temps);
                conseildetable := rn;
            else 
                null;
            end if;
            tempsmoyen := Float(tempsmoyen) + Float(temps)/Float(nb);  -- calcul du temps moyen 
            -- Verification du résultat
            if resultat=n*rn then           -- Affiche bravo si bonne réponse
                Put_Line("Bravo!");
                New_Line;
                correct := correct + 1;
            else                            -- Affiche mauvaise réponse si mauvaise réponse
                Put_Line("Mauvaise réponse.");
                error := error + 1 ;
                New_Line;
            end if;
        end loop;
        if error = 0 then                            -- Affichage d'un commentaire en focntion du nombre d'erreur
            Put_Line ("Aucune erreur. Excellent!");  -- on aurait pu utiliser Selon plutot que les Si...
            else if error = 1 then 
                Put_Line ("Une seule erreur, très bien!");
                else if error = nb then 
                    Put_Line ("Tout est faux, volontaire?");
                    else if Float(correct)<= Float(nb)/2.0 then 
                        Put_Line("Seulement " & Integer'Image(correct) & " bonnes réponses, il faut apprendre la table de" & Integer'Image(n) & ".");
                        New_Line;
                    else Put_Line(Integer'Image(error)& " erreurs. Il faut encore travailler la table de" & Integer'Image(n)& ".");
                        New_Line;
                            end if;
                    end if;
                end if;
        end if;
        if Float(maxtemps) > Float(tempsmoyen)+1.0 then          -- Afficher la table conseillée de réviser 
                Put_Line("Des difficultés sur la table de" & Integer'Image(conseildetable)& "." & Float'Image(maxtemps) & " secondes contre" & Float'Image(tempsmoyen) & "en moyenne; il faudrait la réviser.");
            else Put_line("Des temps très rapides, avec une moyenne de" & Float'Image(tempsmoyen) & " secondes. Bravo!");
        end if; 
        New_Line;    
        Put_Line ("On continue? o=oui, autre chose que o sera considéré comme un arrêt de la révision.");    -- Demander à l'utilisateur s'il veut continuer 
        New_Line;
        Get(a);
        if a='o' then
            continuer :=  True;
        else 
        continuer := False;
        end if;
    end loop;
	null;
end Multiplications;
