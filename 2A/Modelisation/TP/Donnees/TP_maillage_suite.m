close all;
clear;

load donnees;
% Calcul des faces du maillage à garder
n=size(tri,1);
Nf=4*n;
%% ETAPE 1
FACES = [];
for i=1:n
    FACES=[FACES; nchoosek(tri(i,:),3)];
end

%% ETAPE 2
FACES=sortrows(FACES,'ascend');

%% ETAPE 3
faces_a_supprimer=[];
for i=1:Nf-1
    if sum(FACES(i,:)==FACES(i+1,:))==3
        faces_a_supprimer=[faces_a_supprimer i+1];
    end
end
faces_a_supprimer = setdiff(1:size(FACES,1),faces_a_supprimer);
FACES=FACES(faces_a_supprimer,:);

%% Affichage
fprintf('Calcul du maillage final termine : %d faces. \n',size(FACES,1));

% Affichage du maillage final
figure;
hold on
for i = 1:size(FACES,1)
   plot3([X(1,FACES(i,1)) X(1,FACES(i,2))],[X(2,FACES(i,1)) X(2,FACES(i,2))],[X(3,FACES(i,1)) X(3,FACES(i,2))],'r');
   plot3([X(1,FACES(i,1)) X(1,FACES(i,3))],[X(2,FACES(i,1)) X(2,FACES(i,3))],[X(3,FACES(i,1)) X(3,FACES(i,3))],'r');
   plot3([X(1,FACES(i,3)) X(1,FACES(i,2))],[X(2,FACES(i,3)) X(2,FACES(i,2))],[X(3,FACES(i,3)) X(3,FACES(i,2))],'r');
end;
