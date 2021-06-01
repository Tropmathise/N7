# OSX

These are the steps to build all you need for the TP.


## Prerequisites

* If you do not have it already installed, you need to install XCode  from the `Mac App Store`, see here for more details https://developer.apple.com/support/xcode/

* everything will be smoother if you have homebrew installed (https://brew.sh/): it is a package manager similar in spirit to the one you find in Linux.

    * `brew install automake cmake` will install everything you need for building the code.

    * if you don't have homebrew you can install CMake by downloading https://github.com/Kitware/CMake/releases/download/v3.17.1/cmake-3.17.1-Darwin-x86_64.dmg

## Setting up your working environment

* create a folder `tpTI` where you will have all the dependencies and the sources of the tp.
  Please avoid paths containing spaces, weird characters or accents.

* to make your life easier, set up an environment variable that refer to this location

    * You can define it for a single session with (e.g.) `export tpTIBasePath=/home/sgaspari/dev/tpTI`

    * or you can define it once for all by adding the previous instruction to your `~/.profile` file, so that you don't need to run the instruction for each terminal session.

    * you can verify that the variable is set with `echo ${tpTIBasePath}`


## opencv

OpenCV is a computer vision library that contains some of the algorithms we are using for image processing and pose estimation.
To install it:

* download the library from the repository https://github.com/opencv/opencv/archive/3.4.13.zip

* unzip the file into `${tpTIBasePath}` (a folder named `opencv-3.4.13` should appear).

* from `${tpTIBasePath}\opencv-3.4.13` create a `build` directory (`mkdir build`)

* from the shell, go to `${tpTIBasePath}/opencv-3.4.13/build` and execute the following:

    ```
    cmake .. -DCMAKE_INSTALL_PREFIX:PATH=`pwd`/install -DCMAKE_BUILD_TYPE=Release -DWITH_CUDA:BOOL=OFF -DBUILD_PERF_TESTS:BOOL=OFF -DBUILD_TESTS:BOOL=OFF
    ```

* then build and install the library by running

    ```
    make install -j4 
    ```
  You can replace 4 with the number of threads that you machine can support, it will speed up the building.
  Then go grab a cup of coffee or a beverage of your choice ;-)


* in order to run the tp code later on you have to add the built libraries to the `DYLD_LIBRARY_PATH` environment variable.

    ```
    export DYLD_LIBRARY_PATH=${tpTIBasePath}/opencv-3.4.13/build/install/lib:$DYLD_LIBRARY_PATH
    ```

  Again, you can add this to your `~/.profile` file so that you have it available for all shell sessions.