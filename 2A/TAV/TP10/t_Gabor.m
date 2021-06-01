function TG = t_Gabor(signal,T_ech,T_fenetre)
    echant_par_fenetre=floor(T_fenetre/T_ech);
    TG=[];
    for i=1:echant_par_fenetre:(length(signal)-echant_par_fenetre)
        TG=[TG fft(signal(i:i+echant_par_fenetre))];
    end
end

