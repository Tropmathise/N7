clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load parametres;
load dictionnaires;

% Reconstitution du dictionnaire de piano :
nb_notes = length(piano);				% Nombre de notes du dictionnaire
D = [];
for i = 1:nb_notes
	D = [D piano{i}];
end

% Lecture du signal :
signal = audioread('Audio/piano_1.wav');
if size(signal,2)>1
	signal = mean(signal,2);
end
%sound(signal,f_ech);

% Calcul du sonagramme :
S = sonagramme(signal,T_ech,T_mesure,proportion);
m = size(S,2);						% Nombre de mesures du signal

% Affichage du sonagramme :
figure('Name','Ecriture automatique de partitions','Position',[0.3*L,0,0.7*L,H]);
subplot(2,2,4);
imagesc(1:m,valeurs_f,abs(S));
axis xy;
set(gca,'FontSize',25);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Sonagramme $\mathbf{S}$','Interpreter','Latex','FontSize',30);

% Affichage du dictionnaire :
subplot(2,2,3);
imagesc(1:nb_notes,valeurs_f,abs(D));
axis xy;
set(gca,'FontSize',25);
xlabel('Notes','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Dictionnaire $\mathbf{D}$','Interpreter','Latex','FontSize',30);

% Calcul et affichage de la matrice d'activation :
A = pinv(D)*S;
subplot(2,2,2);
imagesc(1:m,1:nb_notes,real(A));
axis xy;
set(gca,'FontSize',25);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Notes','Interpreter','Latex','FontSize',25);
title('Matrice d''activation $\mathbf{A}$','Interpreter','Latex','FontSize',30);
