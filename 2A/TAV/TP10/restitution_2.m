load exercice_2;

% Restitution du signal a partir du sonagramme :
TG_reconstituee = zeros(nb_lignes,nb_colonnes);
TG_reconstituee(1:size(SG,1),:) = SG;
signal_restitue = real(ifft(TG_reconstituee));		% Le signal restitué doit être réel
signal_restitue = signal_restitue(:);			% Le signal restitué doit être un vecteur
sound(signal_restitue,f_ech);
