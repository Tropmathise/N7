load exercice_3;

% Restitution du signal à partir du sonagramme reconstitué :
TG_reconstituee = zeros(nb_lignes,nb_colonnes);
TG_reconstituee(1:size(SG_reconstitue,1),:) = SG_reconstitue;
signal_restitue = real(ifft(TG_reconstituee));		% Le signal restitué doit être réel
signal_restitue = signal_restitue(:);			% Le signal restitué doit être un vecteur
sound(signal_restitue,f_ech);
