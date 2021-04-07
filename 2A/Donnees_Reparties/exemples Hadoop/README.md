Cette archive contient les fichiers et répertoires suivants :
- README.md : le fichier que vous êtes en train de lire
- QuasiMonteCarlo.java : calcul de π par une méthode de Monte-Carlo. Le principe est de
tirer des points au hasard dans le pavé [0 1] x [0 1]. Les points à distance inférieure à
1 de l'origine, sont dans le quart de disque de rayon 1 et de centre l'origine. Leur nombre
est proportionnel à l'aire de ce quart de disque, soit π/4.
- WordCount. Ce répertoire contient différentes variantes/extensions autour du comptage 
des mots d'un fichier de texte.
  * WordCount.java : décompte des occurrences des mots de fichiers de texte
  * WordMean.java : calcul de la longueur moyenne des mots de fichiers de texte
  * WordMedian.java : calcul de la longueur médiane des mots de fichiers de texte
  * WordStandardDeviation.java : calcul de l'écart type sur de la longueur des mots
   de fichiers de texte
- Couverture exacte. Ce répertoire contient des solutions à différentes instances 
du problème de la couverture exacte. Ce problème consiste à déterminer à partir d'un
 ensemble X et d'un ensemble donné P de parties de X, un sous ensemble de P qui constitue
 une partition de X. Ce problème, et les algorithmes sous-jacents ne sont pas présentés
 ici, mais la section Projet de l'UE contient une présentation rapide, ainsi que des
 références et ressources documentaires.
  * package.html : quelques indications (en anglais) sur le contenu de ce répertoire
  * DancingLinks.java : l'algorithme général de résolution du problème de la couverture exacte.
  * DistributedPentomino.java, OneSidedPentomino.java Pentomino.java : application à 
  la résolution de problèmes de pentomino
  * Sudoku.java, puzzle1.dta : application à la résolution de problèmes de sudoku. Notez
  que cette résolution n'a pas été parallélisée en MapReduce, la solution séquentielle
  s'avérant déjà rapide pour des tailles moyennes. Le passage en MapReduce serait donc à 
  réaliser, en s'inspirant des solutions pour les pentominos.
- Autres : ce répertoire contient des exemples utilisant des fonctions plus spécifiques
de la bibliothèque MapReduce, et/ou des variantes d'autres exemples. Leur lecture est plus
ardue, car ces exemples font appel à des classes ou des paramétrages qui demandent d'entrer
plus avant dans les modèles, interfaces et possibilités d'Hadoop.
	* DBCountPageView.java : exemple d'application  exploitant un journal comptabilisant
	 le nombre de visites de pages d'un site web. Le journal est engendré au démarrage
	 de l'application, puis un serveur SQL est lancé. Le but est d'illustrer l'interaction
	 avec un SGBD, ainsi que  l'utilisation de 2 formats spécifiques aux BD : DBInputFormat 
	 et  DBOutputFormat
	* Grep.java : décompte d'expressions régulières  de fichiers de texte
	* Join.java : jointure de tables triées. Illustre un paramétrage poussé des jobs.
	* WordCount* : Ce répertoire contient des variantes de Wordcount, utilisant un Mapper
	prédéfini faciltant l'agrégation de valeurs correspondant à une même clé.
	* Pi. Ce répertoire rassemble des alternatives à QuasiMonteCarlo.java pour le calcul
	 des décimales de π.
	   - BaileyBorweinPlouffe.java, préconisé pour le calcul de décimales jusqu'à la 100 
	   millionième
	   - pi. Ce répertoire contient une solution pour le calcul de décimales au delà de
	   la 100 millionième, ainsi que quelques explications, et une référence (fichier 
	   package.html).
	* Tri. Ce répertoire contient... des exemples d'applications de tri et des utilitaires
	associés.
		- RandomTextWriter.java, RandomWriter.java : génération de fichiers de données, par
		MapReduce : la particularité est que les tâches Map sont utilisées pour réaliser
		des écritures (massivement)
		- Sort.java,  SecondarySort.java : tri sur une clé primaire/secondaire. S'appuie sur
		le tri intégré à la phase map.
		- terasort : tri visant des volumes importants de données ; comprend les utilitaires
		de génération et de vérification, ainsi que quelques résultats.