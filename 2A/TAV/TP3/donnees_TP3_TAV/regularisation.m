function regu = regularisation(i,j,k,ks)
coef=[-1,0,1];
regu=0;
for indi=1:3
   for indj=1:3
        if ((coef(indi) ~= 0 || coef(indj) ~= 0) && (i+coef(indi) >= 1) && (i+coef(indi) <= 100) && (j+coef(indj) >=1 ) && (j+coef(indj) <= 100))
            regu=regu+(1-(ks==k(i+coef(indi),j+coef(indj))));
        end
    end
end
end