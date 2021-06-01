clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture de l'enregistrement 'solo.wav' :
[signal,f_ech] = audioread('Audio/solo.wav');
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

% Recalage sur le morceau complet :
figure('Name','Recalage d''un extrait musical','Position',[0,0,L,0.5*H]);
load nuages;					% Lecture de l'empreinte sonore du morceau complet
T_max = max(ES_complet(:,1));
nb_colonnes_ES_complet = floor(T_max/T_fenetre);
pas = floor(1/T_fenetre);			% Décalage égal à 1 seconde environ
i_min = -1;
score_min = Inf;
for i = 0:pas:nb_colonnes_ES_complet-nb_colonnes

	% Décalage temporel :
	delta_t = i*T_fenetre;

	% Affichage de l'empreinte sonore du morceau complet :
	clf;
	plot(ES_complet(:,1),log(ES_complet(:,2)/f_min),'o','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',5);
	axis([0 T_max 0 log(f_max_SG/f_min)]);
	set(gca,'FontSize',20);
	xlabel('$t$ ($s$)','Interpreter','Latex','FontSize',30);
	ylabel('$\log\left(f/f_{\min}\right)$','Interpreter','Latex','FontSize',30);
	hold on;
    
	% Affichage de l'empreinte sonore de l'extrait après décalage, et calcul du score :
	[ES_decalee,score] = decalage_ES(ES,delta_t,ES_complet);
	plot(ES_decalee(:,1),log(ES_decalee(:,2)/f_min),'o','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);

	% Sauvegarde du meilleur score :
	if score<score_min
		i_min = i;
		score_min = score;
	end
	pause(0.001);
end

% Affichage de l'empreinte sonore du morceau complet :
clf;
plot(ES_complet(:,1),log(ES_complet(:,2)/f_min),'o','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',5);
axis([0 T_max 0 log(f_max_SG/f_min)]);
set(gca,'FontSize',20);
xlabel('$t$ ($s$)','Interpreter','Latex','FontSize',30);
ylabel('$\log\left(f/f_{\min}\right)$','Interpreter','Latex','FontSize',30);
hold on;

% Calcul et affichage du meilleur recalage de l'extrait sur le morceau complet :
delta_t_min = i_min*T_fenetre;
fprintf('Decalage optimal : %.1f secondes\n',delta_t_min);
ES_decalee = ES;
ES_decalee(:,1) = ES_decalee(:,1)+delta_t_min;
plot(ES_decalee(:,1),log(ES_decalee(:,2)/f_min),'o','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
