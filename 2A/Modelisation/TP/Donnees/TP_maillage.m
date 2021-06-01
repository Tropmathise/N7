clear;
close all;
nb_images = 36; % Nombre d'images

% chargement des images
for i = 1:nb_images
    if i<=10
        nom = sprintf('images/viff.00%d.ppm',i-1);
    else
        nom = sprintf('images/viff.0%d.ppm',i-1);
    end;
    % L'ensemble des images de taille : nb_lignes x nb_colonnes x nb_canaux
    % x nb_images
    im(:,:,:,i) = imread(nom); 
end;
% chargement des points 2D suivis
% pts de taille nb_points x (2 x nb_images)
% sur chaque ligne de pts 
% tous les appariements possibles pour un point 3D donne
% on affiche les coordonnees (xi,yi) de Pi dans les colonnes 2i-1 et 2i
% tout le reste vaut -1
pts = load('viff.xy');
% Chargement des matrices de projection
% Chaque P{i} contient la matrice de projection associee a l'image i 
% RAPPEL : P{i} est de taille 3 x 4
load dino_Ps;
% chargement des masques (pour l'elimination des fonds bleus)
% de taille nb_lignes x nb_colonnes x nb_images
% A COMPLETER quand vous aurez termine la premiere partie permettant de
% binariser les images
load mask;
fprintf('Chargement des données terminé\n');

% Affichage des images
figure; 
subplot(2,2,1); imshow(im(:,:,:,1)); title('Image 1');
subplot(2,2,2); imshow(im(:,:,:,9)); title('Image 9');
subplot(2,2,3); imshow(im(:,:,:,17)); title('Image 17');
subplot(2,2,4); imshow(im(:,:,:,25)); title('Image 25');

% Affichage des masques associes
figure;
subplot(2,2,1); imshow(im_mask(:,:,1)); title('Masque image 1');
subplot(2,2,2); imshow(im_mask(:,:,9)); title('Masque image 9');
subplot(2,2,3); imshow(im_mask(:,:,17)); title('Masque image 17');
subplot(2,2,4); imshow(im_mask(:,:,25)); title('Masque image 25');

% Reconstruction des points 3D
X = []; % Contient les coordonnees des points en 3D
color = []; % Contient la couleur associee
% Pour chaque coupple de points apparies
for i = 1:size(pts,1)
    % Recuperation des ensembles de points apparies
    l = find(pts(i,1:2:end)~=-1);
    % Verification qu'il existe bien des points apparies dans cette image
    if size(l,2) > 1 & max(l)-min(l) > 1 & max(l)-min(l) < 36
        A = [];
        R = 0;
        G = 0;
        B = 0;
        % Pour chaque point recupere, calcul des coordonnees en 3D
        for j = l
            A = [A;P{j}(1,:)-pts(i,(j-1)*2+1)*P{j}(3,:);
            P{j}(2,:)-pts(i,(j-1)*2+2)*P{j}(3,:)];
            R = R + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),1,j));
            G = G + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),2,j));
            B = B + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),3,j));
        end;
        [U,S,V] = svd(A);
        X = [X V(:,end)/V(end,end)];
        color = [color [R/size(l,2);G/size(l,2);B/size(l,2)]];
    end;
end;
fprintf('Calcul des points 3D termine : %d points trouves. \n',size(X,2));

%affichage du nuage de points 3D
figure;
hold on;
for i = 1:size(X,2)
    plot3(X(1,i),X(2,i),X(3,i),'.','col',color(:,i)/255);
end;
axis equal;

% A COMPLETER
% Tetraedrisation de Delaunay
T = DelaunayTri(X(1,:)',X(2,:)',X(3,:)')

% A DECOMMENTER POUR AFFICHER LE MAILLAGE
fprintf('Tetraedrisation terminee : %d tetraedres trouves. \n',size(T,1));
% Affichage de la tetraedrisation de Delaunay
%figure;
%tetramesh(T);

% A DECOMMENTER ET A COMPLETER

% Calcul des barycentres de chacun des tetraedres
poids = [1 1 1 1; 15 1 1 1; 1 15 1 1;1 1 15 1; 1 1 1 15];
nb_barycentres = size(poids,1); 
for i = 1:size(T,1)
    % Calcul des barycentres differents en fonction des poids differents
    % En commencant par le barycentre avec poids uniformes
    numeros_points=T(i,:);
    points=T.X(numeros_points,:);
    for p = 1:nb_barycentres 
        poids_courant = poids(p,:);
        C_g(:,i,p)=[sum(points.*poids_courant',1)/sum(poids_courant) 1];
    end
end

% A DECOMMENTER POUR VERIFICATION 
% A RE-COMMENTER UNE FOIS LA VERIFICATION FAITE
% Visualisation pour vérifier le bon calcul des barycentres
% for i = 1:nb_images
%    for k = 1:nb_barycentres
%        o = P{i}*C_g(:,:,k);
%        o = o./repmat(o(3,:),3,1);
%        imshow(im_mask(:,:,i));
%        hold on;
%        plot(o(2,:),o(1,:),'rx');
%        pause;
%        close;
%    end
% end


% A DECOMMENTER ET A COMPLETER
% Copie de la triangulation pour pouvoir supprimer des tetraedres
tri=T.Triangulation;
% Retrait des tetraedres dont au moins un des barycentres 
% ne se trouvent pas dans au moins un des masques des images de travail
% Pour chaque barycentre
t_a_retirer =[];

for k=1:nb_barycentres
	for i=1:nb_images
        for tetra=1:size(tri,1)
            o = P{i}*C_g(:,tetra,k);
            o = o./repmat(o(3,:),3,1);
            x=round(o(1));
            y=round(o(2));
            % On retire les barycentres qui ne sont pas dans l'image une fois
            % projetés
            if(x<=size(im_mask,1) && x>0 && y>0 && y<=size(im_mask,2))
                if (im_mask(x,y,i)==1)
                    t_a_retirer=[t_a_retirer; tetra];
                end
            end
        end
    end
end
t_a_retirer=unique(t_a_retirer);
tri(t_a_retirer,:)=[];

% A DECOMMENTER POUR AFFICHER LE MAILLAGE RESULTAT
% Affichage des tetraedres restants
fprintf('Retrait des tetraedres exterieurs a la forme 3D termine : %d tetraedres restants. \n',size(tri,1));
figure;
trisurf(tri,X(1,:),X(2,:),X(3,:));

% Sauvegarde des donnees
save donnees;
