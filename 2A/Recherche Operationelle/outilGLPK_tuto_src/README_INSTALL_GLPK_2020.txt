
REMARQUE IMPORTANTE: GLPSOL/GLPK ne se manipule qu’en lignes de commande à partir du terminal.

********************************************************************************************


FOR LINUX OS

Pour compiler/installer (après téléchargement de glpk-4.65.tar et avant la 1ère utilisation):
============================================================================================

tar -xvf glpk-4.65.tar.gz
cd glpk
cd glpk-4.65/
chmod +x configure
./configure --disable-shared
make

make check
cd ../..
mkdir executables
cp sources/glpk-4.65/examples/glpsol executables/. 
cp sources/glpk-4.65/doc/glpk.pdf executables/. 
cp sources/glpk-4.65/doc/gmpl.pdf executables/.  
cd executables 
./glpsol --help



Pour utiliser GLPSOL (l’exécutable-solveur disponible dans GLPK):
================================================================

1) Essayer:
glpsol --help

si cela fonctionne, c'est que tt est bien installé et glpk a été installé au moins à la racine de votre répertoire, vous pourrez donc l'utiliser quelque soit le dossier où vous vous trouver

2) Essayer:
cd examples/
./glpsol --help

si cela fonctionne, c'est que tt est bien installé et l'exécutable glpsol se trouve dans le dossier examples. Vous pourrez copier cet exécutable pour le mettre dans n'importe quel dossier d'où vous voudrez utiliser glpk.


3) Essayer:
locate glpsol

pour localiser où se trouverait l'exécutable glpsol sur votre machine


4) Si aucune des 2 manips précédentes ne fonctionne c'est qu'il y a peut-être eu un pb au moment de l'installation de glpk


Déplacer l’exécutable GLPSOL vers un autre dossier:
===================================================

aller dans le dossier examples, copier "glpsol" et le coller dans le dossier à partir duquel on veut l’utiliser.

Puis aller dans ce dossier (grâce à l’instruction cd ) et taper « ./glpsol --help »

si cela fonctionne, c'est que tt est bien installé


Documentation:
=============
Lien vers un tutoriel bien documenté: http://connect.ed-diamond.com/GNU-Linux-Magazine/GLMF-135/Decouverte-du-solveur-GLPK

Fichiers de documentation à récupérer: glpk.pdf et gmpl.pdf (situés dans le dossier « doc » de GLPK



********************************************************************************************


FOR WINDOWS OS



REMARQUE IMPORTANTE: GLPSOL/GLPK ne se manipule qu’en lignes de commande à partir du terminal.

Télécharger WinGlpk, car le soldeur glpsol y est déjà compilé.


Déplacer l’exécutable GLPSOL vers un autre dossier:
===================================================

aller dans le dossier examples, copier "glpsol" et le coller dans le dossier à partir duquel on veut l’utiliser.

Puis aller dans ce dossier (grâce à l’instruction cd ) et taper « ./glpsol --help »

si cela fonctionne, c'est que tt est bien installé


Documentation:
=============
Lien vers un tutoriel bien documenté: http://connect.ed-diamond.com/GNU-Linux-Magazine/GLMF-135/Decouverte-du-solveur-GLPK

Fichiers de documentation à récupérer: glpk.pdf et gmpl.pdf (situés dans le dossier « doc » de GLPK


