-- PQ (10/12) ; PM (10/14)

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

-- Version FIFO : exclusion mutuelle de tous


package body LR.Synchro.FIFO is

   function Nom_Strategie return String is
   begin
      return "FIFO";
   end Nom_Strategie;

   task LectRedTask is
      entry Demander;
      entry Terminer;
   end LectRedTask;

    task body LectRedTask is
        nbLecteurs : Integer :=0;
   begin
      loop
            select
                accept  Demander  do
                    if nbLecteurs>0 then
                        while nbLecteurs>0 loop
                            accept Terminer;
                            nbLecteurs:=nbLecteurs-1;
                        end loop;
                    end if;
                end Demander;
                nbLecteurs:=nbLecteurs+1;
            or
                accept Terminer;
                nbLecteurs:=nbLecteurs-1;
            or
                terminate;
            end select;
      end loop;
   exception
      when Error: others =>
         Put_Line("**** LectRedTask: exception: " & Ada.Exceptions.Exception_Information(Error));
   end LectRedTask;

   procedure Demander_Lecture is
   begin
      LectRedTask.Demander;
   end Demander_Lecture;

   procedure Demander_Ecriture is
   begin
      LectRedTask.Demander;
   end Demander_Ecriture;

   procedure Terminer_Lecture is
   begin
      LectRedTask.Terminer;
   end Terminer_Lecture;

   procedure Terminer_Ecriture is
   begin
      LectRedTask.Terminer;
   end Terminer_Ecriture;

end LR.Synchro.FIFO;
