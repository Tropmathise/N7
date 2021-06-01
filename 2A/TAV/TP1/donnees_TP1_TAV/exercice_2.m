donnees_apprentissage;
close all;

% Calcul de l'erreur d'apprentissage en fonction de d :
liste_d = 2:20;
liste_erreurs_apprentissage = [];
for d = liste_d
	erreur = erreur_apprentissage(D_app,beta_0,beta_d,d);
	liste_erreurs_apprentissage = [liste_erreurs_apprentissage erreur];
end

% Trace de l'erreur d'apprentissage en fonction de d :
figure('Name','Erreur d''apprentissage','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);
plot(liste_d,liste_erreurs_apprentissage,'sb-','LineWidth',2);
set(gca,'FontSize',20);
xlabel('$d$','Interpreter','Latex','FontSize',30);
ylabel('Erreur','FontSize',30);
legend(' Erreur d''apprentissage','Location','Best');
