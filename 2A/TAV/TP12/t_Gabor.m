function TG = t_Gabor(signal,T_ech,T_fenetre)
   nb_echantillons = round(T_fenetre/T_ech);
   nb_fenetres = floor(length(signal)/nb_echantillons);
   TG = zeros(nb_echantillons, nb_fenetres);
   for i = 0:nb_fenetres-1
        TG(:,i+1) = signal(1+i*nb_echantillons:(i+1)*nb_echantillons);
   end
   TG = fft(TG);
end