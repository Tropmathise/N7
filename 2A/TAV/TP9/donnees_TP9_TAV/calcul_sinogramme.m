clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

figure('Name','Transformation de Radon','Position',[0.4*L,0,0.6*L,0.5*H]);

% Lecture et affichage de l'image (doit être carrée, de côté petit et pair) :
I = imread('image.png');
[nb_lignes,nb_colonnes] = size(I);
subplot(1,2,1);
imagesc(I);
colormap gray;
axis off;
axis equal;
title('Image','FontSize',20);
drawnow;

% Paramètres du sinogramme :
delta_theta = 1;
theta = 0:delta_theta:180-delta_theta;		% Partition de l'intervalle [0,pi[
nb_theta = length(theta);			% Nombre d'angles theta
nb_rayons = 501;				% Nombre de rayons par angle (doit être impair)

% Calcul et affichage du sinogramme :
I_vect = double(I(:))/255;
W = calcul_W(nb_lignes,theta,nb_rayons);
p = W*I_vect;
sinogramme = reshape(p,[nb_rayons,nb_theta]);
subplot(1,2,2);
imagesc(sinogramme);
colormap gray;
axis off;
axis equal;
title('Sinogramme','FontSize',20);

save donnees;
