function [theta_estime,rho_estime] = estimation_3(x_donnees_bruitees,y_donnees_bruitees,theta_tests)
x_moyenne=mean(x_donnees_bruitees);
y_moyenne=mean(y_donnees_bruitees);
x_new=x_donnees_bruitees-x_moyenne;
y_new=y_donnees_bruitees-y_moyenne;
somme=(x_new.*cos(theta_tests)+y_new.*sin(theta_tests)).^2;
somme=sum(somme');
[m,ind]=min(somme);
theta_estime=theta_tests(ind);
rho_estime=x_moyenne*cos(theta_estime)+y_moyenne*sin(theta_estime);
