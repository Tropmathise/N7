function [lambda_optimal,sigma_estime] = estimation_lambda_sigma(liste_lambda,liste_VC);
[minimum,indice]=min(liste_VC);
lambda_optimal=liste_lambda(indice);
sigma_estime=sqrt(minimum);
end