clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

couleurs_classes = [0 0.1250 1.0 ; 0.1750 1.0 0.2250 ; 1.0 1.0 0 ; 1.0 0.3750 0 ; 0.85 0 0 ; 0.5 0 0.3 ; 0.5 0.5 0.1];

% Paramètres de la méthode de segmentation :
T_0 = 2.0;
alpha = 0.90;
q_max = 75;
beta = 1.0;

% Lecture et affichage de l'image RVB a segmenter :
nb_pixels_max = 200^2;
I = imread('coca.jpg');
[nb_lignes,nb_colonnes,nb_canaux] = size(I);
if nb_lignes*nb_colonnes>nb_pixels_max
	I = imresize(I,0.5);
	[nb_lignes,nb_colonnes,nb_canaux] = size(I);
end
I = double(I);
I = I/max(I(:));
figure('Name','Segmentation par classification','Position',[0.2*L,0,0.8*L,0.4*L]);
subplot(1,2,1);
imagesc(I);
axis equal;
axis off;

% Estimation des paramètres des N classes :
N = 5;
[moyennes,variances_covariances] = estimation(I,N,couleurs_classes);

% Calcul de l'attache aux données (vraisemblance) :
AD = attache_aux_donnees(I,moyennes,variances_covariances);

% Initialisation des classes :
couleurs_pixels = zeros(nb_lignes,nb_colonnes,3);
[U,k] = min(AD,[],3);
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
	end
end
subplot(1,2,2);
imagesc(couleurs_pixels);
axis equal;
axis off;
title('Maximum de vraisemblance','FontSize',20);
fprintf('Tapez un caractere pour lancer le recuit simule\n');
pause;

% Calcul de l'énergie initiale :
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		U(i,j) = U(i,j)+beta*regularisation(i,j,k,k(i,j));
	end
end

% Minimisation de l'énergie par recuit simulé :
temps_affichage = 0.05;
T = T_0;
for q = 1:q_max

	% Boucle du recuit simulé :
	[U,k] = recuit_simule(U,k,AD,T,beta);

	% Mise à jour de l'affichage :
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
		end
	end
	imagesc(couleurs_pixels);
	axis equal;
	axis off;
	title(['Recuit simule : iteration ' num2str(q) '/' num2str(q_max)],'FontSize',20);
	pause(temps_affichage);

	% Mise à jour de la température :
	T = alpha*T;
end
