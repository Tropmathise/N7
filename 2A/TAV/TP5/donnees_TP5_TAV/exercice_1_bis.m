%--------------------------------------------------------------------------
% ENSEEIHT - 2SN MM - Traitement des données audio-visuelles
% TP5 - Restauration d'images
% exercice_1 : débruitage avec variation totale (niveaux de gris)
%--------------------------------------------------------------------------

clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage par variation totale',...
	'Position',[0.06*L,0.1*H,0.9*L,0.7*H]);

% Lecture de l'image :
u0 = double(imread('Images/lena_avec_bruit.bmp'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

% Affichage de l'image :
subplot(1,2,1)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)   

% Affichage de l'image restaurée à l'itération 0 :
subplot(1,2,2)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	axis image off
	title('Image restauree (iteration 0)','FontSize',20)
drawnow nocallbacks

% Vectorisation de u0 :
nb_pixels = nb_lignes*nb_colonnes;
u0 = reshape(u0,[nb_pixels nb_canaux]);

% Paramètre pour garantir la différentiabilité de la variation totale :
epsilon = 0.01;

% Opérateur gradient :
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(end-nb_lignes+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:end,:) = 0;

% Second membre b du système :
b = u0;

% Point fixe :
lambda = 15;			% Poids de la régularisation
u_k = u0;
convergence = +Inf;
iteration = 0;

while convergence > 1e-3
	
	% Incrémentation du nombre d'itérations :
	iteration = iteration + 1;

	% Itération (6) :
	u_kp1= debruitage(u0,u_k,lambda,Dx,Dy,epsilon);
    
	% Test de convergence :
	convergence = norm(u_kp1-u_k)/norm(u_k);
	
	% Mise à jour de l'image courante u_k :
	u_k = u_kp1;

    drawnow nocallbacks;
	% Affichage de l'image restaurée a chaque itération :
	subplot(1,2,2)
		imagesc(max(0,min(1,reshape(u_k,[nb_lignes nb_colonnes nb_canaux])/u_max)),[0 1])
		colormap gray
		axis image off
		title(['Image restauree (iteration ' num2str(iteration) ')'],'FontSize',20)
	drawnow nocallbacks
	pause(0.2)
	
end
