function Phi = calcul_Phi(nb_lignes,nb_colonnes,eta)
    [f_x,f_y] = meshgrid(1:nb_colonnes,1:nb_lignes);
    f_x = f_x/nb_colonnes-0.5;
    f_y = f_y/nb_lignes-0.5;
    Phi = 1./(1+(f_x.^2+f_y.^2)/eta);
end

