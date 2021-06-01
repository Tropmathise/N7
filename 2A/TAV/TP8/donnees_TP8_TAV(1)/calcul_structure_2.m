function u_barre_new = calcul_structure_2(u_barre,b,Dx,Dy,lambda,epsilon)

    [nb_lignes,nb_colonnes, nb_canaux]=size(u_barre);
    nb_pixels=nb_colonnes*nb_lignes;
    u_barre=reshape(u_barre, [nb_pixels nb_canaux]);
    W_k = 1./sqrt((Dx*u_barre).^2+(Dy*u_barre).^2 +epsilon);
    W_k = spdiags(W_k,0,nb_pixels,nb_pixels);
    div = -Dx'*W_k*Dx-Dy'*W_k*Dy;
    A_k=speye(nb_pixels)-lambda*div;
    u_barre_new=A_k\b;
    u_barre_new=reshape(u_barre_new, [nb_lignes nb_colonnes nb_canaux]);
    
end

