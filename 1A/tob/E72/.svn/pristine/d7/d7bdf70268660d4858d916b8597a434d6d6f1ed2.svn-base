echo ""
echo ------------ LISTE DES SOURCES ------------
echo ""
find -name *.java -print > sources.txt
mkdir -p classes
echo ""
echo ------------ COMPILATION ------------
echo ""
javac @sources.txt -d classes
cp -r ./monopoly/divers/res ./classes/monopoly/divers
echo ""
echo ---------- CREATION DU JAR ----------
echo ""
jar cvfm monopoly.jar ./MANIFEST.MF -C classes monopoly
echo ""
echo ------------- LANCEMENT -------------
echo ""
java -jar ./monopoly.jar
