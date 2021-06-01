donnees_test;
close all;

% Calcul de la validation croisee Leave-one-out :
liste_d = 2:20;
liste_VC = [];
tic;
for d = liste_d
	VC = calcul_VC(D_app,beta_0,beta_d,d);
	liste_VC = [liste_VC VC];
end
toc;

% Trace de la validation croisee Leave-one-out en fonction de d :
figure('Name','Validation croisee','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);
plot(liste_d,liste_VC,'sr-','LineWidth',2);
set(gca,'FontSize',20);
xlabel('$d$','Interpreter','Latex','FontSize',30);
ylabel('$VC$','Interpreter','Latex','FontSize',30);

% Estimation du degre d et de l'ecart-type sigma :
[d_estime,sigma_estime] = estimation_2_d_sigma(liste_d,liste_VC);
fprintf('Estimation du degre : d = %d\n',d_estime);
fprintf('Estimation de l''ecart-type du bruit sur les donnees : %.3f\n',sigma_estime);
