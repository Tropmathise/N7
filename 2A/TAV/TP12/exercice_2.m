clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load parametres;

% Lecture du signal :
signal = audioread('Audio/piano_1.wav');
%signal = audioread('Audio/chateau.wav');
if size(signal,2)>1
	signal = mean(signal,2);
end
%sound(signal,f_ech);

% Calcul du sonagramme :
S = sonagramme(signal,T_ech,T_mesure,proportion);
m = size(S,2);

% Affichage du sonagramme :
figure('Name','Decomposition matricielle NMF','Position',[0.3*L,0,0.7*L,H]);
subplot(2,2,4);
imagesc(1:m,valeurs_f,abs(S));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
title('Sonagramme $\mathbf{S}$','Interpreter','Latex','FontSize',30);

% Algorithme NMF :
[S_abs,n,D_abs,A] = initialisations(S);
valeurs_objectif = [];
it_max = 100;					% Valeur à ajuster
for it = 1:it_max

	% Calcul de l'objectif :
	objectif = sum(sum((D_abs*A-S_abs).^2));
	valeurs_objectif = [valeurs_objectif objectif];

	% Affichage du dictionnaire à l'itération it :
	subplot(2,2,3);
	imagesc(1:n,valeurs_f,D_abs);
	axis xy;
	set(gca,'FontSize',20);
	xlabel('Notes','Interpreter','Latex','FontSize',25);
	ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',25);
	title('Dictionnaire $\mathbf{D}$','Interpreter','Latex','FontSize',30);

	% Affichage de la matrice d'activation à l'itération it :
	subplot(2,2,2);
	A_binarise = A>max(max(A))/3;
	imagesc(1:m,1:n,A_binarise);
	axis xy;
	set(gca,'FontSize',20);
	xlabel('Temps ($s$)','Interpreter','Latex','FontSize',25);
	ylabel('Notes','Interpreter','Latex','FontSize',25);
	title('Matrice d''activation $\mathbf{A}$','Interpreter','Latex','FontSize',30);

	% Affichage de l'évolution de l'objectif :
	subplot(2,2,1);
	plot(1:it,valeurs_objectif,'r','LineWidth',3);
	axis([1,it_max,0,1.05*max(valeurs_objectif)]);
	set(gca,'FontSize',20);
	xlabel('Iteration','Interpreter','Latex','FontSize',25);
	ylabel('Objectif','Interpreter','Latex','FontSize',25);
	title('Evolution de l''objectif','Interpreter','Latex','FontSize',30);
	drawnow;

	% Mise à jour de A et de D_abs :
	[A,D_abs] = mises_a_jour(A,D_abs,S_abs);

end

save NMF D_abs A;
