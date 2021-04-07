function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)
costheta=cos(theta);
sintheta=sin(theta);
A(:,1)=costheta;
A(:,2)=sintheta;
B=rho;
X=pinv(A)*B;
x_F=X(1);
y_F=X(2);
rho_F=sqrt(x_F^2+y_F^2);
theta_F=atan2(y_F,x_F);
m=length(theta);
ecart_moyen=sum(abs(rho-rho_F*cos(theta-theta_F)))/m;