cmake_minimum_required(VERSION 3.1)

project( tp4 LANGUAGES CXX VERSION 2021.0.0)

option(BUILD_TESTS "Build tests" OFF)

#########################################################
#
# EXTERNAL LIBRARIES
#
#########################################################

#########################################################
# FIND OPENGL
#########################################################
set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)
message(STATUS "OPENGL_gl_LIBRARY: ${OPENGL_gl_LIBRARY}")

#########################################################
# FIND GLUT
#########################################################
if(MSVC)
    set(GLUT_ROOT_PATH "${CMAKE_SOURCE_DIR}/freeglut")
    message(STATUS "GLUT_ROOT_PATH: ${GLUT_ROOT_PATH}")
endif()
find_package(GLUT REQUIRED)
message(STATUS "GLUT_FOUND: ${GLUT_FOUND}")
message(STATUS "GLUT_INCLUDE_DIR: ${GLUT_INCLUDE_DIR}")
message(STATUS "GLUT_LIBRARIES: ${GLUT_LIBRARIES}")

if(CMAKE_SYSTEM_NAME STREQUAL Linux)
    #########################################################
    # FIND Threads, not used but necessary for linkning on linux
    # funny story, even if it is not used it is needed by other
    # dependencies which do not propagate their dependencies (?)
    #########################################################
    find_package(Threads REQUIRED)
    # this force all libs to be include even if not directly used
    set(CMAKE_EXE_LINKER_FLAGS  "-Wl,--no-as-needed")
endif()


#########################################################
# SET COMPILATION FLAGS FOR C++11 
#########################################################
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable( visualizer main.cpp ObjModel.cpp core.cpp)
#target_include_directories(visualizer PUBLIC ${OPENGL_INCLUDE_DIR} ${GLUT_INCLUDE_DIR})
#target_link_libraries( visualizer ${OPENGL_opengl_LIBRARY} ${OPENGL_glu_LIBRARY} ${GLUT_LIBRARIES} )
target_link_libraries( visualizer OpenGL::GL OpenGL::GLU GLUT::GLUT )
if(CMAKE_SYSTEM_NAME STREQUAL Linux)
    target_link_libraries( visualizer ${CMAKE_THREAD_LIBS_INIT} )
endif()

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    target_compile_options(visualizer PRIVATE -Wno-deprecated-declarations)
endif()
if (CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(visualizer PRIVATE -Wall -Wextra -pedantic -Wno-comment)
endif()
if(MSVC)
    target_compile_definitions(visualizer PUBLIC -DNOMINMAX)
endif()

if(BUILD_TESTS)
    add_executable( testEdge testEdge.cpp core.cpp)
    target_include_directories(testEdge PUBLIC ${OPENGL_INCLUDE_DIR} ${GLUT_INCLUDE_DIR})
    target_link_libraries( testEdge ${OPENGL_opengl_LIBRARY} ${OPENGL_glu_LIBRARY} ${GLUT_LIBRARIES} )

    add_executable( testEdgeList testEdgeList.cpp core.cpp)
    target_include_directories(testEdgeList PUBLIC ${OPENGL_INCLUDE_DIR} ${GLUT_INCLUDE_DIR})
    target_link_libraries( testEdgeList ${OPENGL_opengl_LIBRARY} ${OPENGL_glu_LIBRARY} ${GLUT_LIBRARIES} )
    if(CMAKE_SYSTEM_NAME STREQUAL Linux)
        target_link_libraries( testEdge ${CMAKE_THREAD_LIBS_INIT} )
        target_link_libraries( testEdgeList ${CMAKE_THREAD_LIBS_INIT} )
    endif()
    enable_testing()
    add_test( testEdgeList bin/testEdgeList 1000 )
endif()
