function ecriture_partition(A,frequences_du_morceau,taille_ecran)
	silences = sum(A)<eps;
	ordonnees_notes = frequences_ordonnees(frequences_du_morceau);
	affichage_partition(ordonnees_notes,silences,taille_ecran);
end

function ordonnees_notes = frequences_ordonnees(frequences_notes)
	decalage_positif = [0.5 0.5 1 1 1.5 2 2 2.5 2.5 3 3 3.5];
	decalage_negatif = [0 0.5 0.5 1 1 1.5 2 2 2.5 2.5 3 3.5];
	ordonnees_notes = [];
	for i = 1:length(frequences_notes)
		note = round(12*log(frequences_notes(i)/440)/log(2))+49;
		if note>=51
			% Si note est plus aigue que le si du milieu de la portee :
			ecart_note = note-51;
			ecart_note_divise_par_12 = floor(ecart_note/12);
			ecart_note_modulo_12 = mod(ecart_note,12);
			if ecart_note_modulo_12>0
				ordonnee_note = 4+3.5*ecart_note_divise_par_12+decalage_positif(ecart_note_modulo_12);
			else
				ordonnee_note = 4+3.5*ecart_note_divise_par_12;
			end
		else
			ecart_note = 51-note;
			ecart_note_divise_par_12 = floor(ecart_note/12);
			ecart_note_modulo_12 = mod(ecart_note,12);
			if ecart_note_modulo_12>0
				ordonnee_note = 4-3.5*ecart_note_divise_par_12-decalage_negatif(ecart_note_modulo_12);
			else
				ordonnee_note = 4-3.5*ecart_note_divise_par_12;
			end
		end
		ordonnees_notes = [ordonnees_notes ordonnee_note];
	end
end

function affichage_partition(ordonnees_notes,silences,taille_ecran)
	[ordonnees_notes_apres_fusion,durees_notes_apres_fusion,silences_apres_fusion] = fusion_notes(ordonnees_notes,silences);
	affichage_portee(max(length(ordonnees_notes_apres_fusion),15),taille_ecran);
	for i = 1:length(ordonnees_notes_apres_fusion)
		if silences_apres_fusion(i)
			affichage_silence(i);
		else
			affichage_note(ordonnees_notes_apres_fusion(i),durees_notes_apres_fusion(i),i);
		end
	end
end

function affichage_portee(longueur_portee,taille_ecran)
	L = taille_ecran(3);
	H = taille_ecran(4);
	figure('Name','Partition','Position',[0,0,0.8*L,0.4*H]);
	axis([0 3*(longueur_portee+1) -10 12]);
	hold on;
	axis equal;
	axis off;
	for k=2:6
		plot([0 3*(longueur_portee+1)],[k k],'k-');
	end
end

function [ordonnees_notes_apres_fusion,durees_notes_apres_fusion,silences_apres_fusion] = fusion_notes(ordonnees_notes,silences)
	ordonnees_notes_apres_fusion = [];
	durees_notes_apres_fusion = [];
	silences_apres_fusion = [];
	i = 1;
	j = 0;
	while i<=length(ordonnees_notes)
		ordonnee_note_courante = ordonnees_notes(i);
		if ~silences(i)
			silences_apres_fusion = [silences_apres_fusion 0];
			duree_note_courante = 1;
			j = i+1;
			fusion_en_cours = 1;
			while j<=length(ordonnees_notes) && fusion_en_cours && ~silences(j)
				ordonnee_note_suivante = ordonnees_notes(j);
				if ordonnee_note_suivante==ordonnee_note_courante
					duree_note_courante = duree_note_courante+1;
					j = j+1;
				else
					fusion_en_cours = 0;
				end
			end
			ordonnees_notes_apres_fusion = [ordonnees_notes_apres_fusion ordonnee_note_courante];
			durees_notes_apres_fusion = [durees_notes_apres_fusion duree_note_courante];
			if j<=length(ordonnees_notes)
				if silences(j) || ~fusion_en_cours
					j = j-1;
				end
			end
		else
			silences_apres_fusion = [silences_apres_fusion 1];
			ordonnees_notes_apres_fusion = [ordonnees_notes_apres_fusion ordonnee_note_courante];
			durees_notes_apres_fusion = [durees_notes_apres_fusion 1];
			j = j+1;
		end
		i = j+1;
	end
end

function affichage_note(ordonnee_note,duree_note,indice)
	% Calcul des coordonnees du centre de la note :
	y = ordonnee_note;
	x = 3*indice;
	switch(duree_note)
		case 1,
			affichage_croche(x,y);
		case 2,
			affichage_noire(x,y);
		case 3,
			affichage_noire_pointee(x,y);
		case 4,
			affichage_blanche(x,y);
		case 6,
			affichage_blanche_pointee(x,y);
		case 8,
			affichage_ronde(x,y);
	end 
	% Si la note est trop grave ou trop aigue, on ajoute des barres :
	ajout_barres(x,y);
end

function affichage_croche(x,y)
	affichage_noire(x,y);
	if (y<4)
		plot([x+0.5 x+1.5],[y+2.5 y+2],'k-');
	else
		plot([x-0.5 x+0.5],[y-2.5 y-2],'k-');
	end
end

function affichage_noire(x,y)
	affichage_disque([x y],0.5,100,'k');
	if (y<4)
		plot([x+0.5 x+0.5],[y y+2.5],'k-');
	else
		plot([x-0.5 x-0.5],[y y-2.5],'k-');
	end
end

function affichage_noire_pointee(x,y)
	affichage_noire(x,y);
	plot(x+1,y,'k.');
end

function affichage_blanche(x,y)
	affichage_ronde(x,y);
	if (y<4)
		plot([x+0.5 x+0.5],[y y+2.5],'k-');
	else
		plot([x-0.5 x-0.5],[y y-2.5],'k-');
	end
end

function affichage_blanche_pointee(x,y)
	affichage_blanche(x,y);
	plot(x+1,y,'k.');
end

function affichage_ronde(x,y)
	affichage_cercle([x y],0.5,100,'k');
end

function ajout_barres(x,y)
	if (y<=1) 				% Note trop grave
		for k=1:-1:ceil(y)
			 plot([x-1 x+1],[k k],'k-');
		end
	elseif (y>=7) 				% Note trop aigue
		 for k=7:floor(y)
			 plot([x-1 x+1],[k k],'k-');
		 end
	end
end

function affichage_cercle(centre_cercle,rayon_cercle,n,couleur)
	theta_cercle = linspace(0,2*pi,n);
	rho_cercle = rayon_cercle*ones(1,n);
	[x_cercle,y_cercle] = pol2cart(theta_cercle,rho_cercle);
	x_cercle = x_cercle+centre_cercle(1);
	y_cercle = y_cercle+centre_cercle(2);
	plot(x_cercle,y_cercle,couleur);
end

function affichage_disque(centre_cercle,rayon_cercle,n,couleur)
	theta_cercle = linspace(0,2*pi,n);
	rho_cercle = rayon_cercle*ones(1,n);
	[x_cercle,y_cercle] = pol2cart(theta_cercle,rho_cercle);
	x_cercle = x_cercle+centre_cercle(1);
	y_cercle = y_cercle+centre_cercle(2);
	fill(x_cercle,y_cercle,couleur);
end

function affichage_silence(indice)
	x = 3*indice;
	plot([x x+1],[4.5 5],'k-');
	plot([x+1 x],[5 2.5],'k-');
end
