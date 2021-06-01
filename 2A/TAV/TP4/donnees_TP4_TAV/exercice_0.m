clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Paramètres :
N = 50;					% Nombre de disques d'une configuration
R = 10;					% Rayon des disques
nb_points_disque = 30;
increment_angulaire = 2*pi/nb_points_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
k_max = 50000;
nb_affichages = 1000;
pas_entre_affichages = floor(k_max/nb_affichages);
temps_pause = 0.0005;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2gray(I);
I = double(I);
I = I(1:400,100:450);
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de ' num2str(N) ' flamants roses'],'Position',[0.25*L,0,0.75*L,0.5*H]);

% Tirage aléatoire d'une configuration initiale et calcul des niveaux de gris moyens :
c = zeros(N,2);
I_moyen_disques = zeros(N,1);
for i = 1:N
	c_i = nb_colonnes*rand(1,2);
	c(i,:) = c_i;
	I_moyen_disques(i) = I_moyen(I,c_i,R);
end
liste_k = 0;
I_moyen_config = mean(I_moyen_disques);
liste_I_moyen_config = I_moyen_config;

% Affichage de la configuration initiale :
subplot(1,2,1);
imagesc(I);
axis image;
axis off;
colormap gray;
hold on;
for i = 1:N
	x_affich = c(i,1)+R*cos(theta);
	y_affich = c(i,2)+R*sin(theta);
	indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
	plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
end
pause(temps_pause);

% Courbe d'évolution du niveau de gris moyen :
subplot(1,2,2);
plot(liste_k,liste_I_moyen_config,'.','Color',rose);
axis([0 k_max/1000 100 240]);
set(gca,'FontSize',20);
xlabel('Nombre d''iterations','FontSize',30);
ylabel('Niveau de gris moyen','FontSize',30);

% Recherche de la configuration optimale :
for k = 1:k_max
	i = rem(k,N)+1;					% On parcourt les N disques en boucle
	I_moyen_cour = I_moyen_disques(i);

	% Tirage aléatoire d'un nouveau disque et calcul du niveau de gris moyen :
	c_alea = nb_colonnes*rand(1,2);
	I_moyen_nouv = I_moyen(I,c_alea,R);


	% Si le disque proposé est meilleur, mises à jour :
	if I_moyen_nouv>I_moyen_cour 
		c(i,:) = c_alea;
		I_moyen_disques(i) = I_moyen_nouv;

		hold off;
		subplot(1,2,1);
		imagesc(I);
		axis image;
		axis off;
		colormap gray;
		hold on;
		for j = 1:N
			x_affich = c(j,1)+R*cos(theta);
			y_affich = c(j,2)+R*sin(theta);
			indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
			plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
		end
		pause(temps_pause);
	end

	% Courbe d'évolution du niveau de gris moyen :
	if rem(k,pas_entre_affichages)==0
		liste_k = [liste_k k];
		I_moyen_config = mean(I_moyen_disques);
		liste_I_moyen_config = [liste_I_moyen_config I_moyen_config];
		subplot(1,2,2);
		plot(liste_k,liste_I_moyen_config,'.-','Color',rose,'LineWidth',3);
		axis([0 max(k_max/1000,1.05*k) 100 240]);
		set(gca,'FontSize',20);
		xlabel('Nombre d''iterations','FontSize',30);
		ylabel('Niveau de gris moyen','FontSize',30);
	end
end
