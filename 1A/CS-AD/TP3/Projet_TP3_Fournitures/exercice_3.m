clear;
close all;
load donnees;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Seuil de reconnaissance a regler convenablement
s = 50 ; %% Le seuil me semble dépendre de K, de N et du nombre d'images dans la base d'apprentissage. Il faut donc le changer à chaque fois :/

% Pourcentage d'information 
per = 0.95;

% Matrice de confusion
M_confusion = zeros(37);

% nombres utiles pour les pourcentages
nb_reconnus = 0;
nb_non_reconnus = 0;

for individu = 1:37
    disp(['Reconnaissance de l individu n°' num2str(individu+3)]);
    for posture = 6 % On essaie de ne pas mettre d'images de tests qui ont été utilisées pour l'apprentissage
        close all;
        % Tirage aleatoire d'une image de test :
        %individu = numeros_individus(randi(length(numeros_individus)));
        %posture = 4 + randi(2); % pour que les images de tests ne soient pas les mêmes que les images de la base d'apprentissage
        chemin = './Images_Projet_2020';
        fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
        Im=importdata(fichier);
        I=rgb2gray(Im);
        I=im2double(I);
        image_test=I(:)';

        % Affichage de l'image de test :
        colormap gray;
        imagesc(I);
        axis image;
        axis off;

        % Nombre N de composantes principales a prendre en compte 
        % [dans un second temps, N peut etre calcule pour atteindre le pourcentage
        % d'information avec N valeurs propres] :
        N = 8;

        % Composantes principales des donnees d'apprentissage
        C = X_c*W;

        % N premieres composantes principales des images d'apprentissage :
        CP_appr = C(:,1:N);

        % N premieres composantes principales de l'image de test :
        image_test_c = image_test - individu_moyen;
        CP_TEST = image_test_c*W;
        CP_test = CP_TEST(1:N);

        % Determination de l'image d'apprentissage la plus proche (plus proche voisin) :

        K = min(2,n); % Paramètre K de l'algorithme des plus proches voisins

        % Calcul des distances entre les vecteurs de test et les vecteurs d'apprentissage (voisins)
        D = zeros(1,n); % Matrice des distances
        for img_app = 1:n
            D(img_app) = sqrt(sum((CP_test - CP_appr(img_app,:)).^2));
        end

        % On garde les K plus proches voisins
        [erreurs_min,Indices] = sort(D);
        Indices_K = Indices(1:K);

        % On compte parmi les plus proches voisins le nombre de fois que les
        % individus de la base d'apprentissages sont trouvés
        Nb_apparitions = zeros(1,n/nb_postures);
        min_par_individu = Inf + zeros(1,n/nb_postures);

        for voisin = 1:K
            % On incrémente le nombre d'apparitions
            Nb_apparitions(ceil(Indices_K(voisin)/nb_postures)) = Nb_apparitions(ceil(Indices_K(voisin)/nb_postures)) + 1;

            % On met à jour le minimum d'erreur de l'individu si il y a lieu
            if D(Indices_K(voisin)) < min_par_individu(ceil(Indices_K(voisin)/nb_postures))
                min_par_individu(ceil(Indices_K(voisin)/nb_postures)) = D(Indices_K(voisin));
            end
        end

        % On garde l'individu le + présent parmi les K plus proches voisins
        [max_apparitions,individu_r] = max(Nb_apparitions);
        MAX = find(Nb_apparitions==max_apparitions);
        if length(MAX)>1
            % si le max d'apparitions est atteint pour plusieurs individus, on
            % choisit celui qui correspond au voisin le + proche
            [min_max,indice] = min(min_par_individu(MAX));
            individu_r = MAX(indice);
        end
        
        % Affichage du resultat :
        if  erreurs_min(1) < s
            individu_reconnu = numeros_individus(individu_r);
            M_confusion(individu_reconnu,individu) = M_confusion(individu_reconnu,individu) + 1;
            nb_reconnus = nb_reconnus + 1;
            title({strcat('Posture numero ',num2str(posture), ' de l''individu numero ', num2str(individu+3));...
                ['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
        else
            nb_non_reconnus = nb_non_reconnus + 1;
            title({strcat('Posture numero ', num2str(posture), ' de l''individu numero ', num2str(individu+3));...
                'Je ne reconnais pas cet individu !'},'FontSize',20);
        end
    end
end

taux_erreur = 100*nnz(M_confusion - diag(diag(M_confusion)))/nb_reconnus;
disp(['Le taux d erreur est de ' num2str(taux_erreur) ' %.']);
disp(['Le taux de non reconnaissance est de ' num2str(100*nb_non_reconnus/37) ' %.']);