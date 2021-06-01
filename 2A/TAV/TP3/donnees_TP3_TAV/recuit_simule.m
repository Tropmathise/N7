function [U,k] = recuit_simule(U,k,AD,T,beta)
[l,c,N]=size(AD);
for i=1:l
    for j=1:c
        new_k = k;
        while(new_k==k)
            new_k=randi(N);
        end
        U_p=AD(i,j,new_k)+beta*regularisation(i,j,k,new_k);
        if (U_p<U(i,j))
            k(i,j)=new_k;
            U(i,j)=U_p;
        else
            if (rand()<exp(-(U_p-U(i,j))/T))
                k(i,j)=new_k;
                U(i,j)=U_p;
            end
        end
    end
end
end
