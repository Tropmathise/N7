donnees;

% Paramètres de la méthode de segmentation :
T_0 = 2.0;
alpha = 0.99;
q_max = 100;
beta = 3; 

% Estimation des paramètres des N classes :
N = 4;
[moyennes,variances] = estimation(I,N,couleurs_classes);

% Permutation des classes pour pouvoir calculer le pourcentage de bonnes classifications :
[~,indices] = sort(moyennes,'ascend');
moyennes = moyennes(indices);
variances = variances(indices);
couleurs_classes = couleurs_classes(indices,:);

% Calcul de l'attache aux données (vraisemblance) :
AD = attache_aux_donnees(I,moyennes,variances);

% Initialisation des classes :
couleurs_pixels = zeros(nb_lignes,nb_colonnes,3);
[U,k] = min(AD,[],3);
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
	end
end
subplot(1,2,2);
imagesc(couleurs_pixels);
axis equal;
axis off;
title(['Maximum de vraisemblance'],'FontSize',20);
fprintf('Tapez un caractere pour lancer le recuit simule\n');
pause;

% Calcul de l'énergie initiale :
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		U(i,j) = U(i,j) + beta*regularisation(i,j,k,k(i,j));
	end
end

% Minimisation de l'énergie par recuit simulé :
temps_affichage = 0.05;
T = T_0;
for q = 1:q_max

	% Boucle du recuit simulé :
	[U,k] = recuit_simule(U,k,AD,T,beta);

	% Mise à jour de l'affichage :
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
		end
	end
	imagesc(couleurs_pixels);
	axis equal;
	axis off;
	title(['Recuit simule : iteration ' num2str(q) '/' num2str(q_max)],'FontSize',20);
	pause(temps_affichage);

	% Mise à jour de la température :
	T = alpha*T;
end

% Calcul du pourcentage de pixels correctement classés :
pixels_correctement_classes = find(k==k_exact);
nb_pixels = nb_lignes*nb_colonnes;
fprintf('Pixels correctement classes : %.2f %%\n',100*length(pixels_correctement_classes(:))/nb_pixels);
