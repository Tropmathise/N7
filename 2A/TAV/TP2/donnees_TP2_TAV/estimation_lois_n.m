function [moyennes,ecarts_types] = estimation_lois_n(X)

moyennes=mean(X);
ecarts_types=sqrt(mean((X-moyennes).^2));