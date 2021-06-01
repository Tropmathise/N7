# Windows

These are the steps to build all you need for the TP.


## Prerequisites

The building process requires CMake and MS Visual Studio.
You may already have it installed on your machine since the opengl tp of last semester.

If it is not the case:

* download and install the latest version of CMake

    * download here: https://github.com/Kitware/CMake/releases/download/v3.17.1/cmake-3.17.1-win64-x64.msi

    * !!! When installing make sure that the checkbox "ne pas ajouter cmake au PATH" is **NOT** checked


* if you don't have it already, download and install MS Visual Studio Community Edition (free for students): https://visualstudio.microsoft.com/downloads/

    * install instructions here: https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=vs-2019

    * !!! install the "Desktop development with C++"

    * If you have VS already installed, you can go in **Tools** --> **Get Tools and Features...** to install "Desktop development with C++" if it is missing.


## Setting up your working environment

* create a folder `tpTI` where you will have all the dependencies and the sources of the tp.
  Please avoid paths containing spaces, weird characters or accents.

* to make your life easier, set up an environment variable that refer to this location

    * from the prompt (`cmd.exe`) execute `c:\Windows\System32\SystemPropertiesAdvanced.exe `

    * click `Environment Variables...`  (`Variables d'environnement...`)

    * in `User Variables for ...` ( `Variables utilisateur pour...`) click `New...` and set a new variable named
      `tpTIBasePath` and set its value to the full path to the working directory, e.g. `C:\Users\Simone\source\tpTI`

    * once you set it, in order to be usable at command line you need to open a new session of prompt/powershell

    * if you open the session you can check it is working by running `echo %tpTIBasePath%`  in command prompt (or `$env:tpTIBasePath` in powershell)
      This should display the whole path to tpTI.
      

## opencv

OpenCV is a computer vision library that contains some of the algorithms we are using for image processing and pose estimation.
To install it:

* download the library from the repository https://github.com/opencv/opencv/archive/3.4.13.zip

* unzip the file into %tpTIBasePath% (a folder named `opencv-3.4.13` should appear).

* from `%tpTIBasePath%\opencv-3.4.13` create a `build` directory (`mkdir build`)

* from the terminal/prompt, go to `%tpTIBasePath%\opencv-3.4.13\build` and execute the following:

    ```
    cmake .. -G "Visual Studio 16 2019" -A x64 -DCMAKE_BUILD_TYPE=Release -DWITH_CUDA:BOOL=OFF -DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF
    ```

> if you had a different version of VS installed (not the latest) you may need to adapt the string `Visual Studio 16 2019` to your version: e.g. `Visual Studio 15 2017`, `Visual Studio 14 2015`, `Visual Studio 12 2013` etc

* then execute

    ```
    cmake --build . --config Release 
    ```

  and go grab a cup of coffee or a beverage of your choice ;-)


## Setting up the runtime environment variables

The last step before start working on the TP is to set up the environment variables that allows the system to find the libraries you just installed/built.

* from the prompt execute `c:\Windows\System32\SystemPropertiesAdvanced.exe `

    * click `Environment Variables...`  (`Variables d'environnement...`)

    * in `User Variables for ...` (`Variables utilisateur pour...`), select the variable `Path` and then click `Edit...`

    * add at the bottom of the list the following paths:

        * `%tpTIBasePath%\opencv-2.4.13.4\build\bin\Release`
