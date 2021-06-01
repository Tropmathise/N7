function u = collage_naif(r,s,interieur)

% Calcul de l'imagette résultat, canal par canal :
u = r;
for k = 1:size(r,3)
	u_k = u(:,:,k);
	s_k = s(:,:,k);
	u_k(interieur) = s_k(interieur);
	u(:,:,k) = u_k;
end
