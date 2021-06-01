function u = collage(r,s,interieur)

% Calcul de l'imagette résultat, canal par canal :
r=double(r);
s=double(s);
u = r;

[nb_lignes, nb_colonnes,nb_canaux]=size(r);
nb_pixels=nb_lignes*nb_colonnes;

e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(end-nb_lignes+1:end,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:end,:) = 0;
A = -Dx'*Dx-Dy'*Dy;

bord_r=ones(nb_lignes, nb_colonnes);
bord_r(2:nb_lignes-1,2:nb_colonnes-1)=zeros(nb_lignes-2, nb_colonnes-2);
indices_bord_r=find(bord_r==1);
n_bord_r=length(indices_bord_r);
A(indices_bord_r,:) = sparse(1:n_bord_r,indices_bord_r,ones(n_bord_r,1),n_bord_r,nb_pixels);

for k = 1:nb_canaux
	u_k = u(:,:,k);
	s_k = s(:,:,k);

    g_x = Dx*u_k(:);
    g_y = Dy*u_k(:);
    
    div_s_x=Dx*s_k(:);
    div_s_y=Dy*s_k(:);
    
    g_x(interieur)=div_s_x(interieur);
    g_y(interieur)=div_s_y(interieur);
    
    b_k = -Dx'*g_x-Dy'*g_y;
    b_k(indices_bord_r)=u_k(indices_bord_r);
    
    u_k=A\b_k;
    u(:,:,k) = reshape(u_k,nb_lignes,nb_colonnes);
    
end
