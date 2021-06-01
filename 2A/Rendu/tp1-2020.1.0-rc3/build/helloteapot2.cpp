#include <stdlib.h>

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

bool pressw = true;

// function called everytime the windows is refreshed
void display()
{

    // clear window 
    glClear(GL_COLOR_BUFFER_BIT);

    // draw scene 

    if (pressw) {
        glutWireTeapot(.5);
    }
    else {
        glutSolidTeapot(.5);
    }

    // flush drawing routines to the window 
    glFlush();

}

// Function called everytime a key is pressed
void key(unsigned char key, int x, int y)
{
    switch (key)
    {
        // the 'esc' key
    case 27:
        // the 'q' key
    case 'q':
        exit(EXIT_SUCCESS);
        break;
        // the 'w' press
    case 'w':
        pressw = !pressw;
        break;
    default:
        break;
    }
    glutPostRedisplay();
}

// Function called every time the main window is resized
void reshape(int width, int height)
{
    double min = min(width, height);
    double max = min(width, height);
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
    glutKeyboardFunc(key);
    // for reshaping
    glutReshapeFunc(reshape);

    // define the projection transformation
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60, 1, 2.1, 10);
    // define the viewing transformation
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    gluLookAt(0, 0, -3, 0.0, 0.0, 0.0, 1.0, 1, 0);

    // tell GLUT to wait for events 
    glutMainLoop();
}
