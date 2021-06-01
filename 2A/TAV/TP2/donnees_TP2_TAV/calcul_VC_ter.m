function VC = calcul_VC_ter(D_app,beta_0,beta_d,d,lambda,A)
n_app=length(D_app(1,:));
VC=0;
S=A*inv(A'*A+lambda*eye(d-1))*A';
for j=1:n_app
    D_app_tmp=D_app;
    D_app_tmp(:,j)=[];
    beta_estime=moindres_carres_ecretes(D_app_tmp,beta_0,beta_d,d,lambda);
    y_estime=bezier(beta_0,beta_estime,beta_d,D_app(1,j));
    VC=VC+(D_app(2,j)-y_estime/(1-S(j,j))).^2;
end
    VC=VC/n_app;
end