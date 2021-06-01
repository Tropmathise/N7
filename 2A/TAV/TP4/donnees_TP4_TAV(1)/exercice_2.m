clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Paramètres :
R = 10;					% Rayon des disques
nb_points_affichage_disque = 30;
increment_angulaire = 2*pi/nb_points_affichage_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
k_max = 1000;
nb_affichages = 300;
pas_entre_affichages = floor(k_max/nb_affichages);
temps_pause = 0.0005;

% Paramètres ajoutés
beta=1.0;
S=130;
gamma=5;
T_0=0.1;
lambda_0=100;
alpha=0.99;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2gray(I);
I = double(I);
I = I(1:400,100:450);
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de flamants roses'],'Position',[0.25*L,0,0.75*L,0.5*H]);

%Configuration initiale
AD=[];
U=0;
I_moyen=[];
c = [];
liste_k = 0;

% Courbe d'évolution de l'energie:
subplot(1,2,2);
plot(liste_k,U,'.','Color',rose);
axis([0 k_max -400 0]);
set(gca,'FontSize',20);
xlabel('Nombre d''iterations','FontSize',30);
ylabel('Energie','FontSize',30);

% Initialisation 
lambda=lambda_0;
T=T_0;

% Recherche de la configuration optimale :
for k = 1:k_max
    
    %pour les tests de convergence à la fin
    c_debut = c;
    
    %% naissance 
    N_tilde = poissrnd(lambda);

	% Tirage aléatoire de N_tilde nouveaux disques et calcul du niveau de gris moyen :
    I_moyen_nouv=zeros(1,N_tilde);
    c_nouv=[];
    for i=1:N_tilde
        c_alea = [nb_colonnes*rand nb_lignes*rand];
        I_moyen_nouv(i)=calcul_I_moyen(I,c_alea,R);
        c_nouv = [c_nouv; c_alea];
    end
    c=[c; c_nouv];
    I_moyen=[I_moyen I_moyen_nouv];
    
    
    %% Tri des disques 
    % Attache aux données
    AD_new=zeros(1,N_tilde);
    for i=1:N_tilde
        AD_new(i)=1-(2/(1+exp(-gamma*((I_moyen_nouv(i)/S)-1))));
    end
    AD=[AD AD_new];
    % Tri 
    [AD_triee,indices_tries]=sort(AD, 'descend');
    %c=c(indices_tries,:);
    
    %% Morts
    morts=[];
    U_snd=0;
    %second membre 

    taille=length(AD_triee);
    for i=1:taille
        ind=indices_tries(i);
        c_tmp=c;
        c_tmp(morts,:)=[];
        somme = sum(sqrt((c(ind,1)-c_tmp(:,1)).^2 + (c(ind,2)-c_tmp(:,2)).^2) <= sqrt(2)*R)-1;
        p=lambda/(lambda+exp(-(AD(ind)+beta*somme)/T));
        if rand<p
            morts=[morts ind];
        else
            U_snd=U_snd+beta*somme;
        end
    end
    % suppression des mort
    c(morts,:)=[];
    AD(morts)=[];
    I_moyen(morts)=[];
    U_snd=U_snd+sum(AD);
    
    %% Test de convergence
    if length(c)~=length(c_debut)
        T=T*alpha;
        lambda=lambda*alpha;
    end	
		
        %% Affichage
		hold off;
		subplot(1,2,1);
		imagesc(I);
        N=size(I_moyen,2);
        title([num2str(N) ' flamants détéctés '],'Fontsize', 20);
		axis image;
		axis off;
		colormap gray;
		hold on;
		for j = 1:length(c(:,1))
			x_affich = c(j,1)+R*cos(theta);
			y_affich = c(j,2)+R*sin(theta);
			indices = find(x_affich>0 & x_affich<nb_colonnes & y_affich>0 & y_affich<nb_lignes);
			plot(x_affich(indices),y_affich(indices),'Color',rose,'LineWidth',3);
		end
		pause(temps_pause);

	% Courbe d'évolution de l'energie :
	if rem(k,pas_entre_affichages)==0
		liste_k = [liste_k k];
        U=[U U_snd];
		subplot(1,2,2);
		plot(liste_k,U,'.-','Color',rose,'LineWidth',3);
		axis([0 k_max -300 0]);
		set(gca,'FontSize',20);
		xlabel('Nombre d''iterations','FontSize',30);
		ylabel('Energie','FontSize',30);
	end
end
