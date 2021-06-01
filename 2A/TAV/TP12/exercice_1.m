clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load parametres;
load dictionnaires;

% Reconstitution du dictionnaire de piano :
nb_notes_piano = length(piano);				% Nombre de notes du dictionnaire
D_piano = [];
for i = 1:nb_notes_piano
	D_piano = [D_piano piano{i}];
end
nb_notes_trompette = length(trompette);				% Nombre de notes du dictionnaire
D_trompette=[];
for i = 1:nb_notes_trompette
	D_trompette = [D_trompette trompette{i}];
end
D=[D_piano D_trompette];
nb_notes=size(D,2);

% Lecture du signal :
signal = audioread('Audio/chateau.wav');
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

A_p = A(1:nb_notes_piano,:);
A_t = A(nb_notes_piano+1:end,:);
S_p=D_piano*A_p;
S_t=D_trompette*A_t;

nb_lignes=floor(T_mesure/T_ech);
nb_ech = length(signal);
duree_totale = nb_ech*T_ech;
nb_colonnes = floor(duree_totale/T_mesure);

TG_p = zeros(nb_lignes,nb_colonnes);
TG_p(1:size(S_p,1),:) = S_p;

TG_t = zeros(nb_lignes,nb_colonnes);
TG_t(1:size(S_t,1),:) = S_t;

signal_trompette = real(ifft(TG_t));
signal_piano = real(ifft(TG_p));

exemple = input('Choisissez le morceau de piano (1) ou de la trompette (2) : ');
switch exemple
	case 1
        sonchoisi=signal_piano(:);
    case 2
        sonchoisi=signal_trompette(:);
end
sound(sonchoisi, 1/T_ech);