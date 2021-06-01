cmake_minimum_required(VERSION 3.10)
project(tp3 VERSION 2021.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)

set(OpenGL_GL_PREFERENCE "GLVND")
find_package(OpenGL REQUIRED)
message(STATUS "OPENGL_gl_LIBRARY: ${OPENGL_gl_LIBRARY}")

if(MSVC)
    set(GLUT_ROOT_PATH "${CMAKE_SOURCE_DIR}/freeglut")
    message(STATUS "GLUT_ROOT_PATH: ${GLUT_ROOT_PATH}")
endif()
find_package(GLUT REQUIRED)
message(STATUS "GLUT_FOUND: ${GLUT_FOUND}")
message(STATUS "GLUT_INCLUDE_DIR: ${GLUT_INCLUDE_DIR}")
message(STATUS "GLUT_LIBRARIES: ${GLUT_LIBRARIES}")

if(APPLE)
  add_definitions(-Wno-deprecated-declarations)
endif()

add_executable(lumiere lumiere.c)
#target_include_directories(lumiere PUBLIC ${OPENGL_INCLUDE_DIR} ${GLUT_INCLUDE_DIR})
#target_link_libraries(lumiere PUBLIC ${OPENGL_opengl_LIBRARY} ${OPENGL_glu_LIBRARY} ${GLUT_LIBRARIES})
target_link_libraries(lumiere OpenGL::GL OpenGL::GLU GLUT::GLUT)

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(lumiere PRIVATE -Wall -Wextra -pedantic -Wno-comment)
endif()
if(MSVC)
    target_compile_definitions(lumiere PUBLIC -DNOMINMAX)
endif()
