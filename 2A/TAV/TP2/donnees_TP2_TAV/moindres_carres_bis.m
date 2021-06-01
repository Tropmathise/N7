function X_estime = moindres_carres_bis(d,y,bords_g,beta_0,bords_d,gamma_0)
E=bords_g-beta_0*(1-y).^d;
E=[E ; (bords_d-gamma_0*(1-y).^d)];
A=[];
for i=1:d
    A=[A,nchoosek(d,i)*(y).^(i).*((1-(y)).^(d-i))];
end
F=[A(:,1:d-1) zeros(size(A(:,1:d-1))) ; zeros(size(A(:,1:d-1))) A(:,1:d-1)];
fin = [A(:,d) ;A(:,d)];
F=[F,fin];
X_estime=F\E;

end