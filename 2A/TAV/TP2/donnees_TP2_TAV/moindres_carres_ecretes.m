function beta_estime = moindres_carres_ecretes(D_app,beta_0,beta_d,d,lambda);
A=[];
B=(D_app(2,:)-beta_0*(1-D_app(1,:)).^d-beta_d*D_app(1,:).^d)';
for j=1:d-1
    A=[A,nchoosek(d,j)*D_app(1,:)'.^(j).*(1-D_app(1,:)').^(d-j)];
end 
I=eye(d-1);
alpha=0:1/d:1;
alpha(1)=[];
alpha(d)=[];
beta_barre=(beta_d-beta_0).*alpha+beta_0;
C=B-A*beta_barre';
delta_estime_transpo=inv(A'*A+lambda*I)*A'*C;
delta_estime=delta_estime_transpo';
beta_estime=beta_barre+delta_estime;
end