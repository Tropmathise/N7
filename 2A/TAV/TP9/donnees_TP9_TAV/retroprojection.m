function f = retroprojection(sinogramme,theta,nb_rayons,nb_lignes,nb_colonnes)
    f=zeros(nb_lignes,nb_colonnes);
    for i=1:nb_lignes
        for j=1:nb_colonnes
            s=0;
            for k=1:length(theta)
                x=j-round(nb_colonnes/2);
                y=round(nb_lignes/2)-i;
                truc=round(x*cos(theta(k)*pi/180)+y*sin(theta(k)*pi/180)+(nb_rayons/2));
                s=s+sinogramme(truc,k)*truc;
            end
            f(i,j)=1/nb_rayons*s;
        end
    end
end

