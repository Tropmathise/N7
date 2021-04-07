with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

-- Lecteurs concurrents, approche automate. Pas de politique d'accès.
package body LR.Synchro.Basique is
   
   function Nom_Strategie return String is
   begin
      return "basique, lecteurs concurrents, sans politique d'accès";
   end Nom_Strategie;
   
   task LectRedTask is
      entry Demander_Lecture;
      entry Demander_Ecriture;
      entry Terminer_Lecture;
      entry Terminer_Ecriture;
   end LectRedTask;

    task body LectRedTask is
        type TypeEtat is (libre,ecriture,lecture);
        nbLecteurs : integer := 0;
        red : boolean := false;
        etat : TypeEtat := libre;
   begin
        loop
            --APPROCHE 1
            if etat=libre then 
                select 
                    accept Demander_Lecture;
                    etat := lecture;
                    nbLecteurs := nbLecteurs +1;
                or
                    accept Demander_Ecriture;
                    etat := ecriture;
                or
                    terminate;
                end select;
                
            elsif etat=ecriture then 
                accept Terminer_Ecriture;
                etat:=libre;
                            
            else
                select 
                    accept Demander_Lecture;
                    nbLecteurs := nbLecteurs +1;
                or accept Terminer_Lecture;
                    nbLecteurs := nbLecteurs-1;
                    if nbLecteurs=0 then 
                        etat:=ecriture;
                    else 
                        etat:=libre;
                    end if;
                end select;
            end if;
            --APPROCHE 2
            --select 
            --    when nbLecteurs=0 and not red =>
            --       accept Demander_Ecriture;
            --        red=true;
            --or
            --    when not red => 
            --        accept Demander_Lecture;
            --        nbLecteurs:=nbLecteurs+1;
            --or accept Terminer_Lecture;
            --    nbLecteurs:=nbLecteurs-1;
            --or accept Terminer_Ecriture;
            --    red=false;
            --end select;
                            
      end loop;
   exception
      when Error: others =>
         Put_Line("**** LectRedTask: exception: " & Ada.Exceptions.Exception_Information(Error));
   end LectRedTask;

   procedure Demander_Lecture is
   begin
      LectRedTask.Demander_Lecture;
   end Demander_Lecture;

   procedure Demander_Ecriture is
   begin
      LectRedTask.Demander_Ecriture;
   end Demander_Ecriture;

   procedure Terminer_Lecture is
   begin
      LectRedTask.Terminer_Lecture;
   end Terminer_Lecture;

   procedure Terminer_Ecriture is
   begin
      LectRedTask.Terminer_Ecriture;
   end Terminer_Ecriture;

end LR.Synchro.Basique;
