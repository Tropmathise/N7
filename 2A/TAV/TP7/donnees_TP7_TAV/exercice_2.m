clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load force_externe;
% Paramètres du modèle :
alpha = 0.001;				% Poids de la pénalisation de la longueur
beta = 0.01;				% Poids de la pénalisation de la courbure

% Paramètre de la descente de gradient :
gamma = 0.5;				% Pas de la descente de gradient
nb_iterations_max = 1000000;		% Nombre d'itérations maximal
seuil_convergence = 1e-8;		% Critère d'arrêt sur l'écart quadratique relatif entre deux affichages

% Paramètre du filtrage gaussien :
sigma = 5;				% Variance
T = ceil(3*sigma);			% Taille du noyau gaussien

% Autres paramètres :
N = 200;				% Nombre de points du contour actif
pas_affichage = 1000;			% Nombre d'itérations entre deux affichages

% Affichage de l'image à segmenter :
figure('Name','Segmentation par contour actif','Position',[0.1*L,0.1*H,0.9*L,0.7*H]);
subplot(1,2,1);
imagesc(I);
colormap gray;
axis image off;
axis xy;
hold on;

% Définition des points de contrôle :
fprintf('Definissez des points de controle par clics, puis tapez Entree !\n');
[x_P,y_P] = ginput;
plot(x_P,y_P,'r*','MarkerSize',10,'LineWidth',3);

% Coordonnées initiales (x0,y0) du contour actif par interpolation des points de contrôle :
x_P = [x_P ; x_P(1)];			% Duplication du premier point de controle
y_P = [y_P ; y_P(1)];			% Idem
nb_P = length(x_P);
xy_0 = interp1(1:nb_P,[x_P,y_P],1:(nb_P-1)/N:nb_P,'spline');
x_0 = xy_0(:,1);
y_0 = xy_0(:,2);

% Affichage du contour actif initial :
plot(x_0,y_0,'b-','LineWidth',2);
drawnow;
title('Iteration 0','FontSize',20);

% Calcul de la matrice A :
A = matrice_A(N,alpha,beta,gamma);

% Évolution du contour actif :
x = x_0(1:end-1);
y = y_0(1:end-1);
x_precedent = x;
y_precedent = y;
convergence = 0;
ii = 1;
while ~convergence
	ii = ii+1;

	% Mise à jour du contour actif :
	[x,y] = iteration(x,y,Fx,Fy,gamma,A);
	
	% Affichage du contour actif courant, toutes les pas_affichage itérations :
	if mod(ii,pas_affichage)==1
		plot([x ; x(1)],[y ; y(1)],'b-','LineWidth',1);
		drawnow;
		title(['Iteration ' num2str(ii-1)],'FontSize',20);
				
		% Test de convergence (maximum de la différence relative inférieure à un seuil) :
		if max(((x-x_precedent).^2+(y-y_precedent).^2)./(x.^2+y.^2))<seuil_convergence
			convergence = 1;
		end		
		x_precedent = x;
		y_precedent = y;
	end
	
	if ii>nb_iterations_max
		convergence = 1;
	end
end

% Affichage du résultat :
subplot(1,2,2);
imagesc(I);
axis image off;
axis xy;
colormap gray;
hold on;
plot([x ; x(1)],[y ; y(1)],'r-','LineWidth',2);
title('Resultat de la segmentation','FontSize',20);
