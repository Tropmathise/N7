function [ES_decalee,score] = decalage_ES(ES,delta_t,ES_complet)
    ES(:,1)=ES(:,1)+delta_t;
    ES_decalee=ES;
    [~,distances]=dsearchn(ES_complet, ES_decalee);
    score=mean(distances);
end

