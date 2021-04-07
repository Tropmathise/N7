clear variables
close all

% chargement du jeu de donn�es
load('dataset.mat')

n=size(X,1);
X_barre=X'*ones(n,1)/n;
X_c=X-ones(n,1)*X_barre';
Sigma=(X_c')*X_c/n;

[W,D] = eig(Sigma);
[D_trier, indices] = sort(diag(D), 'descend');
W = W(:, indices);
C = X_c*W;
Sigma_CP=(C')*C/n;

figure(1),clf
plot(C(1:n,1), zeros(n, 1), 'r*');

figure(2),clf
plot(C(1:n,1), C(1:n,2), 'r*');

figure(3),clf
plot3(C(1:n,1), C(1:n,2), C(1:n,3), 'r*');