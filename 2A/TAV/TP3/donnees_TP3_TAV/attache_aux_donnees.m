function AD = attache_aux_donnees(I,moyennes,variances)
[l,c,d]=size(I);
if (d==1)
    N=length(moyennes);
    AD=zeros(l,c,N);
    variances=reshape(variances,1,N);
    for i=1:l
        for j=1:c
            AD(i,j,:)=(log(variances)+((I(i,j)-moyennes).^2)./variances)/2;
        end
    end
else
    N=size(moyennes,2);
    AD=zeros(l,c,N);
    for k=1:N
        for i=1:l
            for j=1:c
                x_moy = zeros(3,1);
                x_moy(1,1) = I(i,j,1) - moyennes(1,k);
                x_moy(2,1) = I(i,j,2) - moyennes(2,k);
                x_moy(3,1) = I(i,j,3) - moyennes(3,k);
                AD(i,j,k) = 0.5*log(det(variances(:,:,k))) + 0.5*(x_moy'*(variances(:,:,k)\x_moy));
            end
        end
    end
end

end