clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load exercice_1;

% Parametre a ajuster :
proportion = 0.1; % si on met plus que 0.5, on perd de l'info et on augmente la place == inutile

% Calcul du sonagramme :
[SG,taux_compression] = sonagramme(signal,T_ech,T_fenetre,proportion);
fprintf('Coefficient de compression : %.1f\n',taux_compression);

% Calcul des valeurs de f (en Hertz) :
f_max_SG = proportion*f_max;
nb_lignes = floor(T_fenetre/T_ech);
valeurs_f = 0:f_max_SG/(floor(proportion*nb_lignes/2)-1):f_max_SG;

% Affichage du sonagramme :
figure('Name','Sonagramme','Position',[0.4*L,0,0.6*L,0.6*H]);
imagesc(valeurs_t,valeurs_f,abs(SG));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

save exercice_2;
