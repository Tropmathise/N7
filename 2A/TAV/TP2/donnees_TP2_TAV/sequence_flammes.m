clear;
close all;

load exercice_4;
load texture;
figure('Name','Simulation d''une flamme de bougie','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);

% Estimation des lois normales :
[moyennes,ecarts_types] = estimation_lois_n(X);

% Simulation de flammes :
I_max = 255;
[nb_lignes_texture,nb_colonnes_texture] = size(texture);
largeur = 1000;				% Largeur de l'image
echelle_en_largeur = 0.5*largeur/(limites(4)-limites(3));
hauteur = 1000;				% Hauteur de l'image
h = round(0.85*hauteur);		% Hauteur de la flamme
y = 0:1/(h-1):1;			% Ordonnees normalisees entre 0 et 1
x_centre = (beta_0+gamma_0)/2;		% Abscisse du centre de la flamme
N = 40;					% Longueur de la sequence
for r = 1:N
	I = zeros(hauteur,largeur);
	[x_gauche,x_droite] = simulation(y,beta_0,gamma_0,moyennes,ecarts_types,d);

	if length(find(x_gauche>x_droite))==0
		for j = 1:h
			num_ligne_texture = round((nb_lignes_texture*(h-j)+j-1)/(h-1));
			num_colonne_image_min = floor(largeur/2+echelle_en_largeur*(x_gauche(j)-x_centre));
			num_colonne_image_max = ceil(largeur/2+echelle_en_largeur*(x_droite(j)-x_centre));
			largeur_flamme = num_colonne_image_max-num_colonne_image_min;
			for num_colonne_image = max(num_colonne_image_min,1):min(num_colonne_image_max,largeur)
				colonne_texture = round((num_colonne_image-num_colonne_image_min)*(nb_colonnes_texture-1)/largeur_flamme+1);
				I(j,num_colonne_image) = round(texture(num_ligne_texture,colonne_texture)*I_max);
			end
		end
		imagesc(I);
		axis xy;
		axis off;
		colormap(hot);		% Table de couleurs donnant des couleurs chaudes (doc colormap)
		pause(10);
	end
end
