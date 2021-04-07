function [a_estime,b_estime] = estimation_2(x_donnees_bruitees,y_donnees_bruitees);
A=ones(length(x_donnees_bruitees),2);
A(:,1)=x_donnees_bruitees;
B=y_donnees_bruitees';
X = (inv(A'*A)*A')*B;
a_estime=X(1);
b_estime=X(2);



