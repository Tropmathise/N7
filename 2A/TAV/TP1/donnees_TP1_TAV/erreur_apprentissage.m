function erreur = erreur_apprentissage(D_app,beta_0,beta_d,d)
beta_estime=moindres_carres(D_app,beta_0,beta_d,d);
y_estime=bezier(beta_0,beta_estime,beta_d,D_app(1,:));
erreur = sum((y_estime-D_app(2,:)).^2);
end