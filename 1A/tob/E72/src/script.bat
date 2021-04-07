@echo off
echo.
echo ------------ LISTE DES SOURCES ------------
echo.
dir *.java /s /b > sources.txt
if not exist "classes" mkdir classes
echo.
echo ------------ COMPILATION ------------
echo.
javac @sources.txt -d classes
Xcopy /E /I /y .\monopoly\divers\res .\classes\monopoly\divers\res
echo.
echo ---------- CREATION DU JAR ----------
echo.
jar cvfm monopoly.jar .\MANIFEST.MF -C classes monopoly
echo.
echo ------------- LANCEMENT -------------
echo.
java -jar .\monopoly.jar
@echo on
