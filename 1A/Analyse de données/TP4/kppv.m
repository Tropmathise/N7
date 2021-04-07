%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA,DataT,labelA,labelT,K,ListeClass)

[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = 100; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
Matrice = zeros(Nt_test)
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    % A COMPLÉTER
    D = zeros(1,Na);
    for j = 1:Na
        D(j) = sqrt(sum((DataT(i,:)-DataA(j,:)).^2));
    end
    % On ne garde que les indices des K + proches voisins
    % A COMPLÉTER
    [D_trie , vect] = sort(D, 'ascend')
    
    % Comptage du nombre de voisins appartenant à chaque classe
    % A COMPLÉTER
    vecteurs = vect(1:K);
    C = zeros(1,length(ListeClass));
    for p = 1:K
        C(labelA(vecteurs(p))+1) = C(labelA(vecteurs(p))+1)+ 1;
    end
    % Recherche de la classe contenant le maximum de voisins
    % A COMPLÉTER
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    % A COMPLÉTER
    [~,vect_max] = max(C);
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % A COMPLÉTER
    Partition(i) = vect_max(1)-1;
    
    % Matrice de confusion
    Matrice(labelT(i)+1,vect_max(1)) = Matrice(labelT(i)+1,vect_max(1)) + 1;
end

Newmat =  Matrice - diag(diag(Matrice));
taux_erreur = 100*length(find(Newmat~=0))/Nt_test;
disp(['Le taux d erreur est de ' num2str(taux_erreur) ' %.']);
end

