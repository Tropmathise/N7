function [x_gauche,x_droite] = simulation(y,beta_0,gamma_0,moyennes,ecarts_types,d)

X=ecarts_types .* randn(1,2*d-1)+moyennes;
beta_tires=[X(1:d-1), X(end)];
gamma_tires=X(d:end);
x_gauche = bezier(beta_0,beta_tires,X(end),y);
x_droite = bezier(gamma_0, gamma_tires, X(end),y);
