function [d_estime,sigma_estime] = estimation_1_d_sigma(liste_d,liste_erreurs_generalisation)
[minimum,indice]=min(liste_erreurs_generalisation);
d_estime=liste_d(indice);
sigma_estime=sqrt(minimum);
end