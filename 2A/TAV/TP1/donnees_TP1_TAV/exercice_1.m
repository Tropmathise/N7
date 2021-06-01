donnees_apprentissage;

% Degre de la courbe de Bezier utilisee comme modele (testez plusieurs valeurs de d entre 2 et 20) :
d = 19;

% Estimation des parametres de la courbe de Bezier (sauf beta_0 et beta_d) :
beta_estime = moindres_carres(D_app,beta_0,beta_d,d);

% Trace de la courbe de Bezier estimee, de degre d (trait rouge) :
y_estime = bezier(beta_0,beta_estime,beta_d,x);
plot(x,y_estime,'-r','MarkerSize',10,'LineWidth',3);
lg = legend(' Modele exact',' Donnees d''apprentissage',[' Modele estime ($d=' num2str(d) '$)'],'Location','Best');
set(lg,'Interpreter','Latex');
