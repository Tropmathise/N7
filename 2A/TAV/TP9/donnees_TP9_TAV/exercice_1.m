clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load donnees;

figure('Name','Tomographie : resolution algebrique','Position',[0.2*L,0,0.8*L,0.5*H]);

% Affichage de l'image originale :
% subplot(1,3,1);
imagesc(I);
colormap gray;
axis off;
axis equal;
title('Image d''origine','FontSize',20);

% Affichage du sinogramme :
% subplot(1,3,2);
imagesc(sinogramme);
colormap gray;
axis off;
axis equal;
title('Sinogramme','FontSize',20);
drawnow;

% Algorithme de Kaczmarz :
k_max = 5;			% Nombre de parcours de l'ensemble des équations
f = kaczmarz(p,W,k_max);

% Affichage de la solution :
% subplot(1,3,3);
figure;
imagesc(reshape(f,nb_lignes,nb_colonnes));
colormap gray;
axis off;
axis equal;
title('Resultat de la tomographie','FontSize',20);
