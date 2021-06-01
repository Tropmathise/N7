function [SG,taux_compression] = sonagramme(signal,T_ech,T_fenetre,proportion)
    TG = t_Gabor(signal,T_ech,T_fenetre);
    milieu = round(size(TG,1)/2);
    SG = TG(1:milieu,:);
    SG = SG(1:round(proportion*end), :);
    taux_compression = (size(TG,1)*size(TG,2))/(2*size(SG,1)*size(SG,2));
end
