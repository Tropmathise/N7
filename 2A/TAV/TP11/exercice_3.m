clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Tirage aléatoire d'un extrait musical :
repertoire = dir('Extraits/');
taille_repertoire = length(repertoire);
nb_extraits = taille_repertoire(1)-2;		% Attention : les fichiers . et .. sont comptabilisés !
numero_extrait = randi(nb_extraits);

% Lecture de cet extrait musical :
[signal,f_ech] = audioread(['Extraits/extrait_' num2str(numero_extrait,'%03.f') '.wav']);
sound(signal,f_ech);
if size(signal,2)>1
	signal = mean(signal,2);		% Conversion stéréo -> mono
end
f_max = f_ech/2;

% Proportion de fréquences conservées :
f_max_SG = 2000;				% Limitation des fréquences à 2000 Hz
proportion = f_max_SG/f_max;			% Proportion de fréquences positives conservées

% Calcul du sonagramme :
T_ech = 1/f_ech;				% Durée entre échantillons successifs (en secondes)
T_fenetre = 0.2;				% Largeur de la fenêtre (en secondes)
SG = sonagramme(signal,T_ech,T_fenetre,proportion);

% Calcul des valeurs de f (en Hertz) :
nb_lignes = size(SG,1);
valeurs_f = 0:f_max_SG/(nb_lignes-1):f_max_SG;

% Calcul des valeurs de t (en secondes) :
nb_ech = length(signal);
duree_totale = nb_ech*T_ech;
nb_colonnes = floor(duree_totale/T_fenetre);
valeurs_t = 0:duree_totale/(nb_colonnes-1):duree_totale;

% Calcul de la partition fréquentielle :
f_min = 20;
m = 6;
partition = exp(log(f_min):(log(f_max_SG)-log(f_min))/m:log(f_max_SG));
indices_partition = zeros(1,m+1);
for i = 1:m
	indices_partition(i) = min(find(valeurs_f>partition(i)));
end
indices_partition(end) = length(valeurs_f)+1;

% Calcul de l'empreinte sonore :
ES = calcul_ES(SG,indices_partition,valeurs_t,valeurs_f);

% Lecture de la base d'empreintes sonores :
load base_donnees;

% Recherche du meilleur recalage avec chacun des morceaux de la base de données :
liste_scores = calcul_liste_scores(ES,titres_auteurs_empreintes,T_fenetre,nb_colonnes);

% Recherche du meilleur des meilleurs recalages :
[~,indice_min] = min(liste_scores);
disp(['Vous ecoutez ' titres_auteurs_empreintes{indice_min}.titre ' de ' titres_auteurs_empreintes{indice_min}.auteur]);
