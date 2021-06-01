clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture des notes de piano :
[signal_p,f_ech] = audioread('Audio/notes_piano.wav');
if size(signal_p,2)>1
	signal_p = mean(signal_p,2);
end
%sound(signal_p,f_ech);

% Lecture des notes de guitare :
signal_g = audioread('Audio/notes_guitare.wav');
if size(signal_g,2)>1
	signal_g = mean(signal_g,2);
end
%sound(signal_g,f_ech);

% Lecture des notes de marimba :
signal_m = audioread('Audio/notes_marimba.wav');
if size(signal_m,2)>1
	signal_m = mean(signal_m,2);
end
%sound(signal_m,f_ech);

% Lecture des notes de trompette :
signal_t = audioread('Audio/notes_trompette.wav');
if size(signal_t,2)>1
	signal_t = mean(signal_t,2);
end
%sound(signal_t,f_ech);

% Paramètres communs aux différents instruments :
f_max = f_ech/2;
f_max_S = 4000;						% Limitation des fréquences à 2000 Hz
proportion = f_max_S/f_max;				% Proportion de fréquences positives conservées
T_ech = 1/f_ech;					% Durée entre échantillons successifs (en secondes)
T_mesure = 0.5;						% Durée de chaque mesure (en secondes)
nb_ech_par_mesure = floor(T_mesure/T_ech);		% Nombre d'échantillons par mesure
nb_frequences_S = floor(proportion*nb_ech_par_mesure/2);% Nombre de fréquences des sonagrammes
valeurs_f = 0:f_max_S/(nb_frequences_S-1):f_max_S;	% Valeurs des fréquences (en Hertz)

% Calcul du sonagramme de piano :
signal_p = signal_p(1:end-3*nb_ech_par_mesure);		% Les trois dernières notes ne sont pas utiles
S_p = sonagramme(signal_p,T_ech,T_mesure,proportion);
nb_notes_p = size(S_p,2);				% Nombre de notes de piano

% Calcul du sonagramme de guitare :
signal_g = signal_g(1:end-3*nb_ech_par_mesure);
S_g = sonagramme(signal_g,T_ech,T_mesure,proportion);
nb_notes_g = size(S_g,2);				% Nombre de notes de guitare

% Calcul du sonagramme de marimba :
signal_m = signal_m(1:end-3*nb_ech_par_mesure);
S_m = sonagramme(signal_m,T_ech,T_mesure,proportion);
nb_notes_m = size(S_m,2);				% Nombre de notes de marimba

% Calcul du sonagramme de trompette :
signal_t = signal_t(1:end-3*nb_ech_par_mesure);
signal_t = signal_t(16*nb_ech_par_mesure+1:end);	% Il manque les 16 premières notes de trompette
S_t = sonagramme(signal_t,T_ech,T_mesure,proportion);
nb_notes_t = size(S_t,2);				% Nombre de notes de trompette

% Affichage du dictionnaire de notes de piano :
figure('Name','Dictionnaires de notes','Position',[0.3*L,0,0.7*L,H]);
subplot(2,2,1);
imagesc(1:nb_notes_p,valeurs_f,abs(S_p));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Notes de piano','Interpreter','Latex','FontSize',30);

% Affichage du dictionnaire de notes de guitare :
subplot(2,2,2);
imagesc(1:nb_notes_g,valeurs_f,abs(S_g));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Notes de guitare','Interpreter','Latex','FontSize',30);

% Affichage du dictionnaire de notes de marimba :
subplot(2,2,3);
imagesc(1:nb_notes_g,valeurs_f,abs(S_m));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Notes de marimba','Interpreter','Latex','FontSize',30);

% Affichage du dictionnaire de notes de trompette :
subplot(2,2,4);
imagesc(1:nb_notes_t,valeurs_f,abs(S_t));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Notes de trompette','Interpreter','Latex','FontSize',30);
drawnow;

% Création du dictionnaire de piano :
piano = {};
for i = 1:nb_notes_p
	piano = cat(1,piano,S_p(:,i));
end

% Création du dictionnaire de guitare :
guitare = {};
for i = 1:nb_notes_g
	guitare = cat(1,guitare,S_g(:,i));
end

% Création du dictionnaire de marimba :
marimba = {};
for i = 1:nb_notes_m
	marimba = cat(1,marimba,S_m(:,i));
end

% Création du dictionnaire de trompette :
trompette = {};
for i = 1:nb_notes_t
	trompette = cat(1,trompette,S_t(:,i));
end

save dictionnaires piano guitare marimba trompette;
save parametres f_ech f_max f_max_S proportion T_ech T_mesure nb_ech_par_mesure valeurs_f;
