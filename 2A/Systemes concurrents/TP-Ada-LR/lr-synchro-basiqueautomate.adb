with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

-- Lecteurs concurrents, approche automate. Pas de politique d'accès.
package body LR.Synchro.BasiqueAutomate is

   function Nom_Strategie return String is
   begin
      return "Automate, lecteurs concurrents, sans politique d'accès";
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
            select
                when etat=lecture =>
                    accept Demander_Lecture;
                    nbLecteurs:=nbLecteurs+1;
            or
                accept Terminer_Lecture;
                nbLecteurs:=nbLecteurs-1;
                if nbLecteurs=0 then
                    etat := libre;
                else
                    etat :=lecture;
                end if;
            or
                when etat=ecriture =>
                    accept Terminer_Ecriture;
                    etat:=libre;
            or
                when etat = libre =>
                    accept Demander_Lecture;
                    nbLecteurs:=nbLecteurs+1;
                    etat:=lecture;
            or
                when etat = libre and Demander_Lecture'Count = 0 =>
                    accept Demander_Ecriture;
                    etat := ecriture;
            end select;
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

end LR.Synchro.BasiqueAutomate;
