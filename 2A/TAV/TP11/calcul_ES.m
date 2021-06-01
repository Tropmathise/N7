function ES = calcul_ES(SG,indices_partition,valeurs_t,valeurs_f)
    ES=[];
    for i=2:length(indices_partition)
        [modules,ind] = max(abs(SG(indices_partition(i-1):indices_partition(i)-1,:)));
        maxima = [modules' valeurs_t' valeurs_f(indices_partition(i-1)-1+ind)'];
        seuil= mean(maxima(:,1))+std(maxima(:,1));
        f=maxima((maxima(:,1)>seuil),2:3);
        ES=[ES; f];
    end

end

