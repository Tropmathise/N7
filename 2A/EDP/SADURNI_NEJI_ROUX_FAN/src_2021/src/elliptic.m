clear;
close all;

n=15;
%% Triangles
figure();
elliptic_f(0,n);
title('Validation sur le premier type de maillage')

%% Quadrangles
figure();
elliptic_f(1,0);
title('Validation sur le deuxième type de maillage')

%% Evolution de l'ecart
figure()
trace_log_log(n);
title("Evolution de l'écart entre les solutions en fonction du maillage")

%% Resolution par méthode directe
figure()
direct(n);
title("Evolution du nombre des élements non nuls en fonction de la taille de la matrice")