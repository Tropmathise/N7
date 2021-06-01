clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load enregistrement;

% Calcul de la transformée de Gabor :
T_ech = 1/f_ech;				% Durée entre échantillons successifs (en secondes)
T_fenetre = 0.01;				% Durée de la fenêtre (en secondes)
TG = t_Gabor(signal,T_ech,T_fenetre);

% Calcul des valeurs de t (en secondes) :
nb_ech = length(signal);
duree_totale = nb_ech*T_ech;
nb_colonnes = floor(duree_totale/T_fenetre);
valeurs_t = 0:duree_totale/(nb_colonnes-1):duree_totale;

% Calcul des valeurs de f (en Hertz) :
nb_lignes = floor(T_fenetre/T_ech);
valeurs_f = -f_max:f_max/(nb_lignes-1):f_max;

% Affichage du module de la transformée de Gabor :
figure('Name','Transformee de Gabor','Position',[0.4*L,0,0.6*L,0.6*H]);
imagesc(valeurs_t,valeurs_f,abs(fftshift(TG,1)));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

save exercice_1;
