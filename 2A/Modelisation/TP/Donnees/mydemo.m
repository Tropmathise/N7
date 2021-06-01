clear;
close all;

%% Parametres
k=100; % nombre de superpixels
m=2; % parametre de la distance SLIC
iters_max = 300; % nombre d'itérations maximum

%% Image à changer 
image=imread('images/D007.ppm');
subplot(3,2,1);
imshow(image);
title('image originale');
hold on

% Optionnel
im_filtree = medfilt3(image); % filtrer le bruit
subplot(3, 2, 2);
imshow(im_filtree);
title('image filtrée');

% Conversion en double
im=double(im_filtree);
% Conversion en lab
im=rgb2lab(im/255);

%% Superpixels

% Initialisation des données / mise en format [l a b x y]
[nb_lignes, nb_colonnes, ~]=size(im);
nb_pixels = nb_lignes*nb_colonnes;
X=zeros(nb_pixels,5);
l=1;
for i=1:nb_lignes
    for j=1:nb_colonnes
        X(l,:)=[im(i,j,1) im(i,j,2) im(i,j,3) i j];
        l=l+1;
    end
end

%% SLIC superpxiel segmentation

% S de l'algorithme
S=floor(sqrt(nb_pixels/k));
S_sur_2=ceil(S/2);
% le pas de la grille
step=floor(S/2);
nb_l_spx=ceil(nb_lignes/2);
nb_c_spx=ceil(nb_colonnes/2);
% Initialisation des centres Ck=[lk ak bk xk yk]'
centres=zeros(k,5);
l=1;
for i = 1:nb_l_spx
    for j = 1:nb_c_spx
       minlig_centre = min(step + i*S,nb_l_spx);
       mincol_centre = min(step + j*S, nb_c_spx);
       centres(l, :) = [im(minlig_centre,mincol_centre,1) im(minlig_centre,mincol_centre,2) im(minlig_centre,mincol_centre,3) minlig_centre mincol_centre];
       l=l+1;
       if 10<l
           break;
       end
    end
    if 10<l
        break;
    end
end

% Adaptation de la distance pour le kmeans
X(:,4:5)=X(:,4:5)*m/S;
centres(:,4:5)=centres(:,4:5)*m/S;

% Segmentation par kmeans MATLAB
[idx, image_seg]=kmeans(X,k,'start',centres,'maxiter', iters_max);

% Adapation 
idx=reshape(idx,nb_colonnes,nb_lignes)';

% Image des superpixels
image_sp=zeros(size(im));
for i=1:nb_lignes
    for j=1:nb_colonnes
        val = idx(i,j);
        image_sp(i,j,1)=floor(image_seg(val,1));
        image_sp(i,j,2)=floor(image_seg(val,2));
        image_sp(i,j,3)=floor(image_seg(val,3));
    end
end

% Affichage des superpixels
subplot(3,2,3);
% Conversion en rgb
image_sp=lab2rgb(image_sp);
imshow(image_sp);
title('image segmentée');

%% Binarisation de l'image segmentée
colors = image_seg(:,2:3);
I=kmeans(colors,2);

% image binarisée
im_binarisee=zeros(size(im,1), size(im,2));
for i = 1:nb_lignes
    for j=1:nb_colonnes
        id=I(idx(i,j));
        im_binarisee(i,j)=(id==1);
    end
end

% les points qui correspondent à l'objet sont associés à 1, le reste à 0
ind0=find(im_binarisee==0);
ind1=find(im_binarisee==1);
if length(ind0)<length(ind1)
    im_binarisee=~im_binarisee;
end

% Affichage de l'image binarisée
subplot(3,2,4);
imshow(im_binarisee);
title('image binarisée');

%% Estimation de la frontière 
subplot(3,2,5);
imshow(im_binarisee);
title('image détourée');
indx=round(nb_lignes/2);
indy=1;
while im_binarisee(indx,indy)==0
    indy=indy+1;
end
contour=bwtraceboundary(im_binarisee, [indx indy], 'W');
hold on
plot(contour(:,2),contour(:,1),'g','LineWidth',1);
hold off

%

%% Estimation du squelette
[vx,vy]=voronoi(contour(:,2),contour(:,1));

% On enlève les points en dehors de l'image
points_nuls_x=[find(vx(1,:)>=nb_lignes) find(vx(2,:)>=nb_colonnes) find(vx(1,:)<=0) find(vx(2,:)<=0)];
points_nuls_y=[find(vy(1,:)>=nb_lignes) find(vy(2,:)>=nb_colonnes) find(vy(1,:)<=0) find(vy(2,:)<=0)];
points_a_enlever=[points_nuls_x points_nuls_y];
vx(:,points_a_enlever)=[];
vy(:,points_a_enlever)=[];

points_a_retirer=[];
for i=1:length(vx)
    vx1=min(max(1,round(vx(1,i))),nb_colonnes);
    vx2=min(max(1,round(vx(2,i))),nb_colonnes);
    vy1=min(max(1,round(vy(1,i))),nb_lignes);
    vy2=min(max(1,round(vy(2,i))),nb_lignes);
    if im_binarisee(vy1,vx1)==0 || im_binarisee(vy2,vx2)==0
        points_a_retirer=[points_a_retirer i];
    end
end

vx(:,points_a_retirer)=[];
vy(:,points_a_retirer)=[];

subplot(3,2,6)
imshow(im_binarisee)
hold on
% plot(contour(:,2),contour(:,1),'g','LineWidth',1);
plot(vx,vy)
title('estimation du squelette');
hold off

%% Affichage des images seules 
% figure;
% imshow(im_filtree);
% title('image filtrée');

% figure;
% imshow(image_sp);
% title('image segmentée');

% figure;
% imshow(im_binarisee);
% hold on
% plot(contour(:,2),contour(:,1),'g','LineWidth',1);
% hold off
% title('image binarisée avec contour');
% 
% figure;
% imshow(im_binarisee)
% hold on
% plot(vx,vy)
% title('estimation du squelette');
% hold off
