%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de données
% TP3 - Classification bayésienne
% exercice_3.m
%--------------------------------------------------------------------------

clear
close all
clc

% Chargement des données de l'exercice 2
load resultats_ex2

%% Classifieur par maximum de vraisemblance
% code_classe est la matrice contenant des 1 pour les chrysanthemes
%                                          2 pour les oeillets
%                                          3 pour les pensees
% l'attribution de 1,2 ou 3 correspond au maximum des trois vraisemblances

V_max=max(V_pensees,V_oeillets);
V_max=max(V_max, V_chrysanthemes);
pensees_max=find(V_pensees==V_max)
oeillets_max=find(V_oeillets==V_max);
chrysanthenes_max=find(V_chrysanthemes==V_max);
code_classe(pensees_max)=1;
code_classe(oeillets_max)=2;
code_classe(chrysanthenes_max)=3;
code_classe=reshape(code_classe, [101,101]);

%% Affichage des classes

figure('Name','Classification par maximum de vraisemblance',...
       'Position',[0.25*L,0.1*H,0.5*L,0.8*H])
axis equal ij
axis([r(1) r(end) v(1) v(end)]);
hold on
imagesc(r,v,code_classe)
carte_couleurs = [.45 .45 .65 ; .45 .65 .45 ; .65 .45 .45];
colormap(carte_couleurs)
hx = xlabel('$\overline{r}$','FontSize',20);
set(hx,'Interpreter','Latex')
hy = ylabel('$\bar{v}$','FontSize',20);
set(hy,'Interpreter','Latex')
view(-90,90)

%% Comptage des images correctement classees

%Initialisation des compteurs 
cpt_images=0;
cpt_images_correctement_classees=0;

%Comptage des images de pensees correctement classées
for i=1:nb_images_pensees
    cpt_images=cpt_images+1;
    r_i=X_pensees(i,1);
    v_i=X_pensees(i,2);
    x_centre=[r_i;v_i]-mu_pensees;
    V_classe_pensees=exp(-(x_centre')*(Sigma_pensees\x_centre)/2)/denominateur_classe_pensees;
    x_centre=[r_i;v_i]-mu_oeillets;
    V_classe_oeillets=exp(-(x_centre')*(Sigma_oeillets\x_centre)/2)/denominateur_classe_oeillets;
    x_centre=[r_i;v_i]-mu_chrysanthemes;
    V_classe_chrysanthenes=exp(-(x_centre')*(Sigma_chrysanthemes\x_centre)/2)/denominateur_classe_chrysanthemes;
    if(V_classe_pensees>=V_classe_chrysanthenes)
        cpt_images_correctement_classees=cpt_images_correctement_classees+1;
        plot3(r_i,v_i,4,'r*','MarkerSize',10,'Linewidth',2)
    else
        plot3(r_i,v_i,4,'k*','MarkerSize',10,'Linewidth',2)
    end
end 

for i=1:nb_images_oeillets
    cpt_images=cpt_images+1;
    r_i=X_oeillets(i,1);
    v_i=X_oeillets(i,2);
    x_centre=[r_i;v_i]-mu_pensees;
    V_classe_pensees=exp(-(x_centre')*(Sigma_pensees\x_centre)/2)/denominateur_classe_pensees;
    x_centre=[r_i;v_i]-mu_oeillets;
    V_classe_oeillets=exp(-(x_centre')*(Sigma_oeillets\x_centre)/2)/denominateur_classe_oeillets;
    x_centre=[r_i;v_i]-mu_chrysanthemes;
    V_classe_chrysanthenes=exp(-(x_centre')*(Sigma_chrysanthemes\x_centre)/2)/denominateur_classe_chrysanthemes;
    if(V_classe_oeillets>=V_classe_chrysanthenes)
        cpt_images_correctement_classees=cpt_images_correctement_classees+1;
        plot3(r_i,v_i,4,'g*','MarkerSize',10,'Linewidth',2)
    else
        plot3(r_i,v_i,4,'y*','MarkerSize',10,'Linewidth',2)
    end
end 

for i=1:nb_images_pensees
    cpt_images=cpt_images+1;
    r_i=X_chrysanthemes(i,1);
    v_i=X_chrysanthemes(i,2);
    x_centre=[r_i;v_i]-mu_pensees;
    V_classe_pensees=exp(-(x_centre')*(Sigma_pensees\x_centre)/2)/denominateur_classe_pensees;
    x_centre=[r_i;v_i]-mu_oeillets;
    V_classe_oeillets=exp(-(x_centre')*(Sigma_oeillets\x_centre)/2)/denominateur_classe_oeillets;
    x_centre=[r_i;v_i]-mu_chrysanthemes;
    V_classe_chrysanthenes=exp(-(x_centre')*(Sigma_chrysanthemes\x_centre)/2)/denominateur_classe_chrysanthemes;
    if(V_classe_chrysanthenes>=V_classe_pensees)
        cpt_images_correctement_classees=cpt_images_correctement_classees+1;
        plot3(r_i,v_i,4,'b*','MarkerSize',10,'Linewidth',2)
    else
        plot3(r_i,v_i,4,'k*','MarkerSize',10,'Linewidth',2)
    end
end 