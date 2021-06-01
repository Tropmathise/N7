#include <cstdlib>

// for mac osx
#ifdef __APPLE__
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>
#else
// only for windows
#ifdef _WIN32
#include <windows.h>
#endif
// for windows and linux
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/freeglut.h>
#endif


#include <iostream>
using namespace std;

#define SPEED 0.1 //OpenGL unit
#define ANG_SPEED 1.5 //degrees

bool pressw = true;
float camX = 0;
float camY = 0;
float camZ = 5.0;
float ROTX = 0;
float ROTY = 0;

// function called everytime the windows is refreshed
void display()
{
    /* clear window */
    glClear(GL_COLOR_BUFFER_BIT);

    glMatrixMode(GL_MODELVIEW);         // set current matrix as GL_MODELVIEW

    glLoadIdentity();
    gluLookAt(camX, camY, camZ, camX, camY, -1, 0, 1, 0);
    glRotatef(ROTX, 1.0f, 0.0f, 0.0f);    // rotate 90 deg around x
    glRotatef(ROTY, 0.0f, 1.0f, 0.0f);
    // draw scene  
    glutWireTeapot(1); 


    /* flush drawing routines to the window */
    glFlush();

}

void specialKeys(int key, int x, int y) {
    switch (key)
    {
    case GLUT_KEY_UP:
        ROTX = ROTX + ANG_SPEED;
        break;
    case GLUT_KEY_DOWN:
        ROTX = ROTX - ANG_SPEED;
        break;
    case GLUT_KEY_RIGHT:
        ROTY = ROTY + ANG_SPEED;
        break;
    case GLUT_KEY_LEFT:
        ROTY = ROTY - ANG_SPEED;
        break;
    default:
        break;
    }
    glutPostRedisplay();
}


// Function called everytime a key is pressed
void keys(unsigned char key, int x, int y)
{
    switch (key)
    {
     //the 'esc' key
    case 27:
        exit(EXIT_SUCCESS);
    case 'z':
        camZ = camZ + SPEED;
        break;
    case 'q':
        camX = camX - SPEED;
        break;
    case 's':
        camZ = camZ - SPEED;
        break;
    case 'd':
        camX = camX + SPEED;
        break;
    case 'a':
        camY = camY + SPEED;
        break;
    case 'w':
        camY = camY - SPEED;
        break;
    default:
        break;
    }
    glutPostRedisplay();
}


// Function called every time the main window is resized
void reshape(int width, int height)
{
    float min = min(width, height);
    float max = min(width, height);
    glViewport((width - height) / 2, 0, min, min);
    // define the viewport transformation;
    // glViewport(0,0,width,height);
}

// Main routine
int main(int argc, char* argv[])
{

    // initialize GLUT, using any commandline parameters passed to the 
    //   program 
    glutInit(&argc, argv);

    // setup the size, position, and display mode for new windows 
    glutInitWindowSize(500, 500);
    glutInitWindowPosition(0, 0);
    glutInitDisplayMode(GLUT_RGB);

    // create and set up a window 
    glutCreateWindow("Hello, teapot!");

    // Set up the callback functions:
    // for display
    glutDisplayFunc(display);
    // for the keyboard
    glutKeyboardFunc(keys);
    glutSpecialFunc(specialKeys);
    // for reshaping
    glutReshapeFunc(reshape);

    /* define the projection transformation */
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60, 1, 1, 10);

    /* define the viewing transformation */
    glMatrixMode(GL_MODELVIEW);
    // glLoadIdentity();
    gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);

    // tell GLUT to wait for events 
    glutMainLoop();
}