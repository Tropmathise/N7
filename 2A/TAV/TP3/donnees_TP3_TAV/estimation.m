function [moyennes,variances_covariances] = estimation(I,N,couleur_classes)

fprintf('Selectionnez %d echantillons\n',N);
[nb_lignes,nb_colonnes,nb_canaux] = size(I);
moyennes = zeros(nb_canaux,N);
variances_covariances = zeros(nb_canaux,nb_canaux,N);
for k = 1:N
	[x1,y1] = ginput(1);
	while (x1<1)||(x1>nb_colonnes)||(y1<1)||(y1>nb_lignes)
		[x1,y1] = ginput(1);
	end
	[x2,y2] = ginput(1);
	while (x2<1)||(x2>nb_colonnes)||(y2<1)||(y2>nb_lignes)||(x2==x1)||(y2==y1)
		[x2,y2] = ginput(1);
	end
	line([x1,x1],[y1,y2],'Color',couleur_classes(k,:),'Linewidth',2);
	line([x1,x2],[y2,y2],'Color',couleur_classes(k,:),'Linewidth',2);
	line([x2,x2],[y2,y1],'Color',couleur_classes(k,:),'Linewidth',2);
	line([x2,x1],[y1,y1],'Color',couleur_classes(k,:),'Linewidth',2);
	drawnow;

	echantillons = [];
	for i = floor(min([y1,y2])):ceil(max([y1,y2]))
		for j = floor(min([x1,x2])):ceil(max([x1,x2]))
			echantillons = [echantillons reshape(I(i,j,:),nb_canaux,1)];
		end
	end
	moyenne = mean(echantillons,2);
	moyennes(:,k) = moyenne;
	nb_donnees = size(echantillons,2);
	echantillons_centres = echantillons-moyenne*ones(1,nb_donnees);
	variances_covariances(:,:,k) = echantillons_centres*transpose(echantillons_centres)/nb_donnees;
end
