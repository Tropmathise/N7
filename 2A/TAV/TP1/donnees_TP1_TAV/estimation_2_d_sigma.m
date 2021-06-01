function [d_estime,sigma_estime] = estimation_2_d_sigma(liste_d,liste_VC)
[minimum,indice]=min(liste_VC);
d_estime=liste_d(indice);
sigma_estime=sqrt(minimum);
end