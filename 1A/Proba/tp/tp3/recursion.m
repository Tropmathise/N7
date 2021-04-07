function [E,contour,G_somme] = recursion(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)
% Fonction recursive permettant de construire un ensemble candidat E

contour(i,j) = 0;
G_somme_normalise = G_somme/norm(G_somme);
nb_voisins = size(voisins,1);
k = 1;
while k<=nb_voisins & size(E,1)<=card_max
	i_voisin = i+voisins(k,1)	;			% A completer
	j_voisin = j+voisins(k,2)	;		% A completer
	if contour(i_voisin,j_voisin)

		% Dans cette boucle, il vous faut :
		% - Calculer le produit scalaire entre G_somme_normalise et le gradient normalise de I au pixel voisin
		% - Si ce produit scalaire est superieur a cos_alpha :
		%	+ Mettre a jour "E" par concatenation
		%	+ Mettre a jour "G_somme"
		%	+ Lancer l'appel recursif sur le voisin
        G_v =[G_x(i_voisin,j_voisin) G_y(i_voisin,j_voisin)];
        p_scalaire = G_somme_normalise*G_v';
        if p_scalaire > cos_alpha
            E=[E; i_voisin j_voisin];
            G_somme=G_somme + G_v;
            [E,contour,G_somme]=recursion(E,contour,G_somme,i_voisin,j_voisin,voisins,G_x,G_y,card_max,cos_alpha);
		end
	end
	k = k+1;
end
