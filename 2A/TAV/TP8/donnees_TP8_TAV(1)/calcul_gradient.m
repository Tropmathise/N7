function [Dx,Dy] = calcul_gradient(nb_lignes,nb_colonnes)
    
    nb_pixels=nb_lignes*nb_colonnes;
    e = ones(nb_pixels,1);
    Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
    Dx(end-nb_lignes+1:end,:) = 0;
    Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
    Dy(nb_lignes:nb_lignes:end,:) = 0;

end

