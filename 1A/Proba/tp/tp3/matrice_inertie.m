function [C_x,C_y,M] = matrice_inertie(E_x,E_y,G_norme_E)
    gpi=sum(G_norme_E);
    C_x=sum(E_x.*G_norme_E)/gpi;
    C_y=sum(E_y.*G_norme_E)/gpi;
    M(1,1)=G_norme_E'*((E_x-C_x).^2);
    M(2,2)=G_norme_E'*((E_y-C_y).^2);
    M(1,2)=G_norme_E'*((E_x-C_x).*(E_y-C_y));
    M(2,1)=G_norme_E'*((E_x-C_x).*(E_y-C_y));
    M=M/gpi;
end 
  