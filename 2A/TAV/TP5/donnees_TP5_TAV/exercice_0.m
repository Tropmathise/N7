%--------------------------------------------------------------------------
% ENSEEIHT - 2SN MM - Traitement des données audio-visuelles
% TP5 - Restauration d'images
% exercice_0 : débruitage avec modèle de Tikhonov (niveaux de gris)
%--------------------------------------------------------------------------

clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage avec le modele de Tikhonov', ...
	'Position',[0.06*L,0.1*H,0.9*L,0.7*H])

% Lecture de l'image :
u0 = double(imread('Images/cameraman_avec_bruit.tif'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

% Affichage de l'image :
subplot(1,2,1)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)
    
% Vectorisation de u0 :
nb_pixels = nb_lignes*nb_colonnes;
u0 = reshape(u0,[nb_pixels 1]);

% Operateur gradient :
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(end-nb_lignes+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:end,:) = 0;

% Second membre b du système :
b = u0;

% Matrice A du système :
Lap = -Dx'*Dx - Dy'*Dy;
lambda = 13;				% Poids de la régularisation
A = speye(nb_pixels) - lambda*Lap;

% Résolution du système A*u = b :
u = A\b;

% Affichage de l'image restaurée :
subplot(1,2,2)
	imagesc(max(0,min(1,reshape(u,[nb_lignes nb_colonnes])/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)
