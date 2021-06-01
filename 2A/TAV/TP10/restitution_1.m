load exercice_1;

% Restitution du signal à partir de la transformée de Gabor :
signal_restitue = real(ifft(TG));		% Le signal restitué doit être réel
signal_restitue = signal_restitue(:);		% Le signal restitué doit être un vecteur
sound(signal_restitue,f_ech);

disp('Apres suppression de la partie imaginaire du spectre : tapez entree');
pause;

% Restitution du signal en n'utilisant que la partie réelle de TG :
signal_restitue = real(ifft(real(TG)));		% Le signal restitué doit être réel
signal_restitue = signal_restitue(:);		% Le signal restitué doit être un vecteur
sound(signal_restitue,f_ech);

disp('Apres suppression de la phase du spectre : tapez entree');
pause;

% Restitution du signal en n'utilisant que le module complexe de TG :
signal_restitue = real(ifft(abs(TG)));		% Le signal restitué doit être réel
signal_restitue = signal_restitue(:);		% Le signal restitué doit être un vecteur
sound(signal_restitue,f_ech);
