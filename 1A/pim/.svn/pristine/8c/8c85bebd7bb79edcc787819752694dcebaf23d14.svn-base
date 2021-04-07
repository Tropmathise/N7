with Text_IO;
use Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

-- Afficher le menu jusqu'à l'action quitter lu au clavier ou jusqu'à l'altitude maximale atteinte

procedure Drone is 
	commande: String --la lettre qui sert de commande lue au clavier
	min, max: Integer --altitude minimal et maximal du drone
begin 
	min := 0,max := 5
	--Afficher le menu
	--Saisir la commande
	Put("Altitude:", min);
	New_Line;
	Put("Que faire? d--Demarrer, m--Monter, s-- Descendre, q--Quitter  Votre Choix:");
	Get(commande);
	
	if commande /= "d" then --commencer par démarrer le drone
		Put_Line("Le drone n'est pas démarré, veuillez le démarer en tapant 'd'");
		Get(commande);
		while commande /= "q" loop --tant que la commande quitter n'est pas demandée
			if commande = "m" and min<5 then --monter le drone
				min := min+1 
				Put("Altitude:", min);
				New_Line;
				Put("Que faire? d--Demarrer, m--Monter, s-- Descendre, q--Quitter  Votre Choix:");
			elsif commande = 'm' and min=5 then 
				Put_Line("Altitude maximale atteinte, entrez une autre commande")
				Put("Que faire? d--Demarrer, m--Monter, s-- Descendre, q--Quitter  Votre Choix:");
				Get(commande);


		
	



