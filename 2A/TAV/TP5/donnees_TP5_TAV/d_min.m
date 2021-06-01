function [existe_q,bornes_Vp,bornes_V_q_chapeau] = d_min(i_p,j_p,u_k,D,t,T)

%voisinage de p
[nb_lignes, nb_colonnes, nb_canaux]=size(u_k);
i_p_min=max(1,i_p-t);
i_p_max=min(nb_lignes,i_p+t);
j_p_min=max(1,j_p-t);
j_p_max=min(nb_colonnes, j_p+t);
bornes_Vp=[i_p_min i_p_max j_p_min j_p_max];

% selection des pixels dans D 
Vp=~repmat(D(i_p_min:i_p_max,j_p_min:j_p_max),[1,1,nb_canaux]);
up=u_k(i_p_min:i_p_max,j_p_min:j_p_max,:);
existe_q=0;
bornes_V_q_chapeau=zeros(1,4);
d_min=inf;

for i = max(1+t,i_p-T+t):min(nb_lignes-t,i_p+T-t)	
	for j = max(1+t,j_p-T+t):min(nb_colonnes-t,j_p+T-t)
        %voisinage de q
        i_q_min = i+i_p_min-i_p;
		i_q_max = i+i_p_max-i_p;
		j_q_min = j+j_p_min-j_p;
		j_q_max = j+j_p_max-j_p;
		D_q = D(i_q_min:i_q_max,j_q_min:j_q_max);
		if max(D_q(:)) == 0
			existe_q = 1;
			uq = u_k(i_q_min:i_q_max,j_q_min:j_q_max,:);
			ecarts = up-Vp.*uq;
			ecarts_vector = ecarts(:);
			dpq = ecarts_vector'*ecarts_vector;
			if dpq < d_min
				d_min = dpq;
				bornes_V_q_chapeau = [i_q_min i_q_max j_q_min j_q_max];
            end	
		end
    end	
end
end