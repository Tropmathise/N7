%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Calcul scientifique
% TP1 - Orthogonalisation de Gram-Schmidt
% mgs.m
%--------------------------------------------------------------------------

function Q = mgs(A)

    % Recuperation du nombre de colonnes de A
    [~, m] = size(A);
    
    % Initialisation de la matrice Q avec la matrice A
    Q = A;
    
    %------------------------------------------------
    % A remplir
    % Algorithme de Gram-Schmidt modifie
    %------------------------------------------------
    for i=1:m
        y=A(:,i);
        for j=1:(i-1)
            R(j,i)=Q(:,j)'*y;
            y=y-R(j,i)*Q(:,j);
        end
        R(i,i)=norm(y);
        Q(:,i)=y/R(i,i);
    end      
end