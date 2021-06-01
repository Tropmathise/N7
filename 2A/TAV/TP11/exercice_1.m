clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture de l'enregistrement '007.wav' :
[signal,f_ech] = audioread('Audio/007.wav');
if size(signal,2)>1
	signal = mean(signal,2);		% Conversion stéréo -> mono
end
f_max = f_ech/2;

% Proportion de fréquences conservées :
f_max_SG = 2000;				% Limitation des fréquences à 2000 Hz
proportion = f_max_SG/f_max;			% Proportion de fréquences positives conservées

% Calcul du sonagramme :
T_ech = 1/f_ech;				% Durée entre échantillons successifs (en secondes)
T_fenetre = 0.2;				% Largeur de la fenêtre (en secondes)
SG = sonagramme(signal,T_ech,T_fenetre,proportion);

% Calcul des valeurs de f (en Hertz) :
nb_lignes = size(SG,1);
valeurs_f = 0:f_max_SG/(nb_lignes-1):f_max_SG;

% Calcul des valeurs de t (en secondes) :
nb_ech = length(signal);
duree_totale = nb_ech*T_ech;
nb_colonnes = floor(duree_totale/T_fenetre);
valeurs_t = 0:duree_totale/(nb_colonnes-1):duree_totale;

% Affichage du sonagramme :
figure('Name','Sonagramme','Position',[0,0,0.5*L,0.5*H]);
imagesc(valeurs_t,valeurs_f,abs(SG));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

% Calcul de la partition fréquentielle :
f_min = 20;
m = 6;
partition = exp(log(f_min):(log(f_max_SG)-log(f_min))/m:log(f_max_SG));
indices_partition = zeros(1,m+1);
for i = 1:m
	indices_partition(i) = min(find(valeurs_f>partition(i)));
end
indices_partition(end) = length(valeurs_f)+1;

% Calcul de l'empreinte sonore :
ES = calcul_ES(SG,indices_partition,valeurs_t,valeurs_f);

% Affichage de l'empreinte sonore :
figure('Name','Empreinte sonore','Position',[0.5*L,0,0.5*L,0.5*H]);
plot(ES(:,1),log(ES(:,2)/f_min),'o','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'FontSize',20);
xlabel('$t$ ($s$)','Interpreter','Latex','FontSize',30);
ylabel('$\ln\left(f/f_{\min}\right)$','Interpreter','Latex','FontSize',30);
axis([valeurs_t(1) valeurs_t(end) 0 log(f_max_SG/f_min)]);
hold on;
for i = 2:length(indices_partition)-1
	plot([valeurs_t(1) valeurs_t(end)],[log(partition(i)/partition(1)) log(partition(i)/partition(1))],'-r');
end
