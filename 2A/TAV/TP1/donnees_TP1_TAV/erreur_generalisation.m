function erreur = erreur_generalisation(D_test,D_app,beta_0,beta_d,d);
beta_estime=moindres_carres(D_app,beta_0,beta_d,d);
y_estime=bezier(beta_0,beta_estime,beta_d,D_test(1,:));
erreur=sum((y_estime-D_test(2,:)).^2);
end