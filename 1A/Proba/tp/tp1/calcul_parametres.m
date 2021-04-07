function [r,a,b]=calcul_parametres(X,Y)
[nbl,nbc]=size(X)
ecartx=sqrt(mean(X.*X)-mean(X)^2)
ecarty=sqrt(mean(Y.*Y)-mean(Y)^2)
covxy=mean(X.*Y)-mean(X)*mean(Y)
r=covxy/(ecartx*ecarty)
a=covxy/(ecartx^2)
b=mean(Y)-covxy*mean(X)/ecartx^2


