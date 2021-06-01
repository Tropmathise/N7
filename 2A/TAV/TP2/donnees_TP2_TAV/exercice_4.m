clear;
close all;

load exercice_3;
figure('Name','Simulation d''une flamme de bougie','Position',[0.4*L,0.05*H,0.6*L,0.7*H]);

% Estimation des lois normales :
[moyennes,ecarts_types] = estimation_lois_n(X);

% Simulation de silhouettes par tirages aleatoires :
N = 40;				% Longueur de la sequence simulee
for r = 1:N
	[x_gauche,x_droite] = simulation(y,beta_0,gamma_0,moyennes,ecarts_types,d);

	if length(find(x_gauche>x_droite))==0
		plot(x_droite,y,'Color','r','LineWidth',2);
		axis([limites(3:4) limites(1:2)]);
		set(gca,'FontSize',20);
		xlabel('$y$','FontSize',30,'Interpreter','Latex');
		ylabel('$x$','FontSize',30,'Interpreter','Latex','Rotation',0);
		hold on;
		plot(x_gauche,y,'Color','r','LineWidth',2);
		for p = 1:m
			plot([x_gauche(p) x_droite(p)],[y(p) y(p)],'Color','r','LineWidth',2);
		end

		pause(0.1);
		hold off;
	end
end

save exercice_4;
