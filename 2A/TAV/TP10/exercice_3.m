clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load exercice_1;

% Paramètres à ajuster :
proportion = 0.3;
m = 20;

% Calcul du sonagramme :
SG = sonagramme(signal,T_ech,T_fenetre,proportion);

% Calcul des valeurs de f (en Hertz) :
f_max_SG = proportion*f_max;
nb_lignes = floor(T_fenetre/T_ech);
valeurs_f = 0:f_max_SG/(floor(proportion*nb_lignes/2)-1):f_max_SG;

% Sélection des m coefficients de Fourier les plus grands :
[valeurs_max,indices_max,taux_compression] = mp3(signal,T_ech,T_fenetre,proportion,m);
fprintf('Coefficient de compression : %.1f\n',taux_compression);

% Affichage du sonagramme original, en guise de comparaison :
figure('Name',['Compression audio : ' num2str(taux_compression,'%.1f')],'Position',[0,0,L,0.6*H]);
subplot(1,2,1);
imagesc(valeurs_t,valeurs_f,abs(SG));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme original','FontSize',20);

% Reconstitution du sonagramme à partir de indices_max et valeurs_max :
SG_reconstitue = zeros(size(SG));
for i = 1:nb_colonnes
	indices_max_i = indices_max(:,i);
	SG_reconstitue(indices_max_i,i) = valeurs_max(:,i);
end

% Affichage du sonagramme reconstitué :
subplot(1,2,2);
imagesc(valeurs_t,valeurs_f,abs(SG_reconstitue));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme reconstitue','FontSize',20);
drawnow;

save exercice_3;
