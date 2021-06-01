function [SG,taux_compression] = sonagramme(signal,T_ech,T_fenetre,proportion)
    SG=t_Gabor(signal,T_ech,T_fenetre);
    [nb_l, ~]=size(SG);
    SG=SG(1:round(nb_l*0.5*proportion),:);
    taux_compression=length(signal)/(2*numel(SG));
end