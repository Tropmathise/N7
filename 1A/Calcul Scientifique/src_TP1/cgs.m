%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% cgs.m
%--------------------------------------------------------------------------

function Q = cgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt classique
    %------------------------------------------------
    R=zeros(m);
    R(1,1)=norm(A(:,1));
    Q(:,1)=A(:,1)/R(1,1);
    for i=2:m;
        R(1:i-1,i)=Q(:,1:i-1)'*A(:,i)
        Q(:,i)=A(:,i)-Q(:,1:i-1)*R(1:i-1,i)
        R(i,i)=norm(Q(:,i))
        Q(:,i)=Q(:,i)/R(i,i)
    end
end