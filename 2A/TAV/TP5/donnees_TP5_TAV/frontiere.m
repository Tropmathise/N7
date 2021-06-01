function delta_D = frontiere(D)

% Forme pour la transformation morphologique :
SE = strel('diamond',1);

% Frontière de la zone contenant des 1 (i.e. le masque) :
delta_D = D - imerode(D,SE);
