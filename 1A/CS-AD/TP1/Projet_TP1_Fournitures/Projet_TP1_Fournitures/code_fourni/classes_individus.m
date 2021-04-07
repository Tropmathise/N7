clear variables
close all

% chargement du jeu de donn�es
load('dataset.mat')

%% Matrice de variance / covariance
n=size(X,1);
X_barre=X'*ones(n,1)/n;
X_c=X-ones(n,1)*X_barre';
Sigma=(X_c')*X_c/n;

%% Composantes principales
[W,D] = eig(Sigma);
[~, indices] = sort(diag(D), 'descend');
W = W(:, indices);
C = X_c*W;
Sigma_CP=(C')*C/n;

figure(3),clf
plot3(C(1:n,1), C(1:n,4), C(1:n,6), 'r*');
title('Projection des données sur les 1°,4° et 6° CP');

figure(4),clf
plot(100*diag(Sigma_CP)/sum(diag(Sigma_CP)), 'k*')
title('Pourcentage d info contenue sur chaque composante ppale --6 classes')
xlabel('num de la comp. ppale');ylabel('pourcentage d info');

figure(5),clf
subplot(6,1,1)
plot(C(1:n,1), zeros(n, 1), 'r*');
title('Projection des données sur la 1°CP');

subplot(6,1,2)
plot(C(1:n,2), zeros(n, 1), 'b*');
title('Projection des données sur la 2°CP');

subplot(6,1,3)
plot(C(1:n,3), zeros(n, 1), 'g*');
title('Projection des données sur la 3°CP');

subplot(6,1,4)
plot(C(1:n,4), zeros(n, 1), 'c*');
title('Projection des données sur la 4°CP');

subplot(6,1,5)
plot(C(1:n,5), zeros(n, 1), 'm*');
title('Projection des données sur la 5°CP');

subplot(6,1,6)
plot(C(1:n,6), zeros(n, 1), 'y*');
title('Projection des données sur la 6°CP');