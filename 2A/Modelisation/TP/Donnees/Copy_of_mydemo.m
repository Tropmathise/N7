clear;
close all;

%% Parametres
k=100; % nombre de superpixels

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

%% SLIC superpxiel segmentation
m = 8;
Seuil = 1;
[nb_lignes, nb_colonnes, ~]=size(im);
nb_pixels = nb_lignes*nb_colonnes;

% Le pas de la grille.
S = floor(sqrt(nb_pixels/k));
centres = [];
[nb_l, nb_c, ~]=size(im);
nb_lignes_sp = floor(nb_l/S);
nb_colonnes_sp = floor(nb_c/S);
centres=[];
S_sur_2 = floor(S/2);

% Initialisation des centres
for i = 1:nb_lignes_sp-1
   for j = 1:nb_colonnes_sp-1
      centres = [centres [i*S + S_sur_2;j*S + S_sur_2]];
   end
end

% Initialisation des variables : 
K=size(centres,2);
label = zeros(nb_l,nb_c);
D = zeros(nb_l,nb_c,K);
coef = m/Seuil;
% Pour éviter de balayer tous les pixels.
imx = (1:nb_l)'.*ones(nb_l,nb_c);
imy = (1:nb_c).*ones(nb_l,nb_c);

for q = 1:10
    for i = 1:K
        d_c = (im-(im(centres(1,i),centres(2,i),:)));
        D(:,:,i) = sqrt(sqrt(d_c(:,:,1).^2 + d_c(:,:,2).^2 + d_c(:,:,3).^2).^2 ...
                            + coef*sqrt((centres(1,i) - imx).^2 + (centres(2,i) - imy).^2).^2);
    end
    [~,label] = min(D,[],3);
    for i = 1:K
        Indices = label == i;
        if (sum(sum((Indices))) ~= 0)
            centres(1,i) = floor(mean(mean(imx(Indices))));
            centres(2,i) = floor(mean(mean(imy(Indices))));
        end
    end
end
label = uint8(label);

listeLabel = unique(label)';
image_sp = zeros(size(label,1),size(label,2),3);
for j = listeLabel
    indice = (label==j);
    for i = 1:3
        segmentation = image_sp(:,:,i);
        couleur_image = im(:,:,i);
        couleur = couleur_image(centres(1,j),centres(2,j));
        segmentation(indice) = couleur;
        image_sp(:,:,i) = segmentation;
    end
end
image_seg = uint8(image_sp);

% Affichage des superpixels
subplot(3,2,3);
imshow(image_seg);
title('image segmentée');

%% Binarisation de l'image segmentée
couleur_plus_claire = rgb2hsv(image_sp);
colors = couleur_plus_claire(:,:,1); 
colors = colors(:);
indice=kmeans(colors,2);

for i = 1:3
    binarisation = image_sp(:,:,i);
    binarisation(indice==1) = uint8(0);
    binarisation(indice~=1) = uint8(255);
    image_sp(:,:,i) = binarisation;
end
im_binarisee = image_sp(:,:,1);
im_binarisee(im_binarisee==255)=1;

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
% 
% figure;
% imshow(image_seg);
% title('image segmentée');
% 
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
