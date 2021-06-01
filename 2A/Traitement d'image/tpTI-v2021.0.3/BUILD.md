# Dependencies

This projet requires:

* opencv >= 3.4.4
* cmake >= 3.10

## Installing the dependencies

* [Linux](DEP_LINUX.md)
* [Windows](DEP_WINDOWS.md)
* [OSx](DEP_OSX.md)

# Building

## Linux & OSX

From the root of the project:

```
mkdir build
cd build
cmake .. -DOpenCV_DIR=${tpTIBasePath}/opencv-3.4.13/build/install/share/OpenCV/ 
```

and then to compile

```
make -j$(nproc) 
```

All the executables are placed in `build/bin`

## Windows

### Create the Visual Studio Solution. 

* open a Terminal and go to the directory containing the code.

* execute:

  * `md build`
  
  * `cd build`
  
  * `cmake -G "Visual Studio 16 2019" -A x64 -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_PREFIX_PATH:PATH=<opencv install path> ..`
  
    Replace `<opencv install path>` with the location where you installed opencv (e.g. C:/User/Toto/Opencv)
  
  * `dir`
  
  > if you had a different version of VS installed (not the latest) you may need to adapt the string `Visual Studio 16 2019` to your version: e.g. Visual Studio 15 2017, Visual Studio 14 2015, Visual Studio 12 2013
  
* if everything went well you should find a file named `tpTI.sln` inside the directory.


### Compile, build, execute 

* open `tpTI.sln` inside VS either by double clicking on it or opening from inside VS

* build the solution (**Build Solution** from the **Build menu**)


