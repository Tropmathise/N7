function direct(nbmax)
%DIRECT Summary of this function goes here
    % Tracé de l'evolution du nombre d'elements non nuls de R en fonvtion 
    % de la taille de la matrice
    trace=zeros(2,nbmax-2);
    for i=3:nbmax
        [coordinates,~,~,dirichlet,~] = maillage_carre(i);
        [~,A]=elliptic_f(0,i);
        non_dir=[1:length(coordinates)];
        non_dir(dirichlet)=[];
        AA=A(non_dir,non_dir);
        R=chol(AA);
        taille=length(coordinates(:,1));
        nonNuls=sum(sum(R(:,:)~=0));
        trace(:,i-2)=[taille^2;nonNuls];
    end
    plot(trace(1,:),trace(2,:));
end

