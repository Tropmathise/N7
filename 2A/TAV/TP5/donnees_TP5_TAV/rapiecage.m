function [u_nouv,D_nouv] = rapiecage(bornes_V_p,bornes_V_q_chapeau,u_k,D);

nb_canaux = size(u_k,3);

	% Bornes du voisinage de p :
	i_min_p = bornes_V_p(1);
	i_max_p = bornes_V_p(2);
	j_min_p = bornes_V_p(3);
	j_max_p = bornes_V_p(4);

	% Bornes du voisinage de q :
	i_min_q = bornes_V_q_chapeau(1);
	i_max_q = bornes_V_q_chapeau(2);
	j_min_q = bornes_V_q_chapeau(3);
	j_max_q = bornes_V_q_chapeau(4);

	% Initialisations :
	u_nouv = u_k;
	D_nouv = D;

	% Mise a jour de u :
	D_p = D(i_min_p:i_max_p,j_min_p:j_max_p);
	piece = repmat(D_p,[1,1,nb_canaux]).*u_k(i_min_q:i_max_q,j_min_q:j_max_q,:);
	u_nouv(i_min_p:i_max_p,j_min_p:j_max_p,:) = u_k(i_min_p:i_max_p,j_min_p:j_max_p,:) + piece;

	D_nouv(i_min_p:i_max_p,j_min_p:j_max_p) = 0;
    
    	
end

