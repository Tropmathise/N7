function beta_estime = moindres_carres(D_app,beta_0,beta_d,d)
A=[];
B=(D_app(2,:)-beta_0*(1-D_app(1,:)).^d-beta_d*D_app(1,:).^d)';
for j=1:d-1
    A=[A,nchoosek(d,j)*D_app(1,:)'.^(j).*(1-D_app(1,:)').^(d-j)]
end 
beta_estime=A\B;
end