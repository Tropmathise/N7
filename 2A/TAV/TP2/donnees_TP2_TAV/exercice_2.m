exercice_1;
close all;

% Calcul de la validation croisee Leave-one-out :
d = 18;
liste_lambda = 0.01:0.001:0.11;
tic;
liste_VC = [];
for lambda = liste_lambda
	VC = calcul_VC_bis(D_app,beta_0,beta_d,d,lambda);
	liste_VC = [liste_VC VC];
end
toc;

% Trace de la validation croisee Leave-one-out en fonction de lambda :
figure('Name','Estimation de lambda par validation croisee','Position',[0,0.05*H,0.4*L,0.4*H]);
plot(liste_lambda,liste_VC,'sr-','LineWidth',2);
set(gca,'FontSize',20);
xlabel('$\lambda$','Interpreter','Latex','FontSize',30);
ylabel('$VC$','Interpreter','Latex','FontSize',30);
amplitude_VC = max(liste_VC)-min(liste_VC);
axis([min(liste_lambda) max(liste_lambda) min(liste_VC)-0.1*amplitude_VC max(liste_VC)+0.1*amplitude_VC]);

% Estimation de l'hyper-parametre lambda optimal et de l'ecart-type sigma :
[lambda_optimal,sigma_estime] = estimation_lambda_sigma(liste_lambda,liste_VC);
fprintf('Estimation de l''hyper-parametre : lambda = %.3f\n',lambda_optimal);
fprintf('Estimation de l''ecart-type du bruit sur les donnees : %.3f\n',sigma_estime);

% Estimation des parametres avec la valeur optimale de lambda :
beta_estime = moindres_carres_ecretes(D_app,beta_0,beta_d,d,lambda_optimal);

% Trace du modele exact (trait noir) :
figure('Name','Controle de la complexite par regularisation','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);
plot(x,y,'-k','LineWidth',2);
set(gca,'FontSize',20);
xlabel('$x$','Interpreter','Latex','FontSize',30);
ylabel('$y$','Interpreter','Latex','FontSize',30);
hold on;

% Trace des donnees d'apprentissage (croix bleues) :
plot(x_j,y_j,'+b','MarkerSize',10,'LineWidth',3);

% Trace de la courbe de Bezier optimale (trait rouge) :
y_estime = bezier(beta_0,beta_estime,beta_d,x);
plot(x,y_estime,'-r','MarkerSize',10,'LineWidth',3);
lg = legend(' Modele exact',' Donnees d''apprentissage',...
		[' Modele optimal pour $d =' num2str(d) '$ ($\lambda=' num2str(lambda_optimal) '$)'],'Location','SouthEast');
set(lg,'Interpreter','Latex');
