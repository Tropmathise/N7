clear;
close all;

load donnees;
figure('Name','Modelisation de la silhouette par deux courbes de Bezier couplees','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);

% Modelisation de chaque silhouette par deux courbes de Bezier couplees :
d = 5;
X = [];
for k = 1:n
	X_estime = moindres_carres_bis(d,y,bords(:,1,k),beta_0,bords(:,2,k),gamma_0);
	X_estime_T = transpose(X_estime);
	beta_estime = [X_estime_T(1:d-1) X_estime_T(2*d-1)];
	gamma_estime = [X_estime_T(d:2*(d-1)) X_estime_T(2*d-1)];
	x_gauche = bezier(beta_0,beta_estime(1:end-1),beta_estime(end),y);
	x_droite = bezier(gamma_0,gamma_estime(1:end-1),gamma_estime(end),y);

	plot(y,bords(:,1,k),'k-','LineWidth',2);
	axis(limites);
	axis ij;
	set(gca,'FontSize',20);
	xlabel('$y$','FontSize',30,'Interpreter','Latex');
	ylabel('$x$','FontSize',30,'Interpreter','Latex','Rotation',0);
	hold on;
	plot(y,x_gauche,'r','LineWidth',3);
	plot(y,bords(:,2,k),'k-','LineWidth',2);
	plot(y,x_droite,'r','LineWidth',3);

	pause(0.5);
	hold off;
	X = [X ; transpose(X_estime)];		% Stockage dans X de tous les paramètres estimes
end

save exercice_3;
