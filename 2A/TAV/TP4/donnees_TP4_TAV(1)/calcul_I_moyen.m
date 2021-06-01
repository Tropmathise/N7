function resultat = calcul_I_moyen(I,c_i,R)

[nb_lignes,nb_colonnes] = size(I);
abscisse = c_i(1);
ordonnee = c_i(2);
R_carre = R*R;
nb_pixels = 0;
somme_nvg = 0;
for j = max(1,floor(abscisse-R)):min(nb_colonnes,ceil(abscisse+R))
	for i = max(1,floor(ordonnee-R)):min(nb_lignes,ceil(ordonnee+R))
		abscisse_relative = j-abscisse;
		ordonnee_relative = i-ordonnee;
		if abscisse_relative*abscisse_relative+ordonnee_relative*ordonnee_relative<=R_carre
			nb_pixels = nb_pixels+1;
			somme_nvg = somme_nvg+I(i,j);
		end
	end
end
resultat = somme_nvg/nb_pixels;
