function liste_scores = calcul_liste_scores(ES,titres_auteurs_empreintes,T_fenetre,nb_colonnes)
    liste_scores=[];
    for i=1:length(titres_auteurs_empreintes)
        ES_i=titres_auteurs_empreintes{i}.empreinte;
        mesures_i=floor(max(ES_i(:,1))/T_fenetre);
        pas=5;
        score=Inf;
        for j=0:pas:mesures_i-nb_colonnes
            delta_t=j*T_fenetre;
            [~,score_i]=decalage_ES(ES,delta_t,ES_i);
            if score_i<score
                score=score_i;
            end
        end
        liste_scores=[liste_scores score];
    end
end


