function indice_f_max = f_fondamentale(note_dictionnaire)

facteur_min = 2;
facteur_max = 4;

sous_echantillonnage = [];
produit_spectral = note_dictionnaire;
for facteur = facteur_min:facteur_max
	sous_echantillonnage = downsample(note_dictionnaire,facteur);
	taille_fft = length(note_dictionnaire);
	nb_zeros = floor((1-(1/facteur))*taille_fft);
	sous_echantillonnage = [sous_echantillonnage ; zeros(nb_zeros,1)];
	produit_spectral = produit_spectral.*sous_echantillonnage;
end

[~,indice_f_max] = max(produit_spectral);
