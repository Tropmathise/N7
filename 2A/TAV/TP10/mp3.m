function [valeurs_max,indices_max,taux_compression] = mp3(signal,T_ech,T_fenetre,proportion,m)

    [SG,taux_compression]=sonagramme(signal,T_ech,T_fenetre,proportion);
    
    [valeurs_max, indices_max] =sort(abs(SG),'descend');
   
    valeurs_max=valeurs_max(1:m,:);
    indices_max=indices_max(1:m,:);
    
    taux_compression=taux_compression*size(SG,1)/m;
end

