function [x_min,x_max,probabilite] = calcul_proba(E_nouveau_repere,p)
n=size(E_nouveau_repere,1);
x_min = min(E_nouveau_repere(:,1));
x_max = max(E_nouveau_repere(:,1));
N=length(E_nouveau_repere(:,1))*length(E_nouveau_repere(:,2));
probabilite=binocdf(n,N,p);
end
