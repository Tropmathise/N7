clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture et affichage de l'image source s :
figure('Name','Photomontage naif','Position',[0.1*L,0.1*H,0.9*L,0.7*H]);
s = imread('Images/orque.jpg');
[nb_lignes_s,nb_colonnes_s,nb_canaux] = size(s);
subplot(1,2,1);
imagesc(s);
axis image off;
title('Image source','FontSize',20);
hold on;

% Sélection et affichage d'un polygone p dans s :
disp('Selectionnez un polygone (double-clic pour valider)');
[p,x_p,y_p] = roipoly(s);
for k = 1:length(x_p)-1
	line([x_p(k) x_p(k+1)],[y_p(k) y_p(k+1)],'Color','r','LineWidth',2);
end

% Bornes du rectangle englobant de p :
i_p = min(max(round(y_p),1),nb_lignes_s);
j_p = min(max(round(x_p),1),nb_colonnes_s);
i_p_min = min(i_p(:));
i_p_max = max(i_p(:));
j_p_min = min(j_p(:));
j_p_max = max(j_p(:));

% Lecture et affichage de l'image cible c :
c = imread('Images/montagne.jpg');
c = c(:,1:770,:);
[nb_lignes_c,nb_colonnes_c,nb_canaux] = size(c);
subplot(1,2,2);
imagesc(c);
axis image off;
title('Image cible','FontSize',20);
hold on;

% Sélection et affichage d'un rectangle r dans c :
disp('Cliquez les deux extremites de la zone cible');
[x_r,y_r] = ginput(2);
i_r = min(max(round(y_r),1),nb_lignes_c);
j_r = min(max(round(x_r),1),nb_colonnes_c);
j_r_min = min(j_r(:));
j_r_max = max(j_r(:));
i_r_min = min(i_r(:));
i_r_max = max(i_r(:));
line([j_r_min j_r_max],[i_r_min,i_r_min],'Color','r','LineWidth',2);
line([j_r_min j_r_max],[i_r_max,i_r_max],'Color','r','LineWidth',2);
line([j_r_min j_r_min],[i_r_min,i_r_max],'Color','r','LineWidth',2);
line([j_r_max j_r_max],[i_r_min,i_r_max],'Color','r','LineWidth',2);

% Sous-matrice de c correspondant au rectangle r :
r = c(i_r_min:i_r_max,j_r_min:j_r_max,:);

% Seules les sous-matrices à l'intérieur du rectangle englobant de p sont conservées :
s = s(i_p_min:i_p_max,j_p_min:j_p_max,:);
p = p(i_p_min:i_p_max,j_p_min:j_p_max);

% Redimensionnement de s et p aux dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);
s = imresize(s,[nb_lignes_r,nb_colonnes_r]);
p = imresize(p,[nb_lignes_r,nb_colonnes_r]);

% Calcul et affichage de l'image résultat u :
u = c;
interieur = find(p>0);
u(i_r_min:i_r_max,j_r_min:j_r_max,:) = collage_naif(r,s,interieur);
hold off;
imagesc(u);
axis image off;
title('Resultat du photomontage','FontSize',20);
