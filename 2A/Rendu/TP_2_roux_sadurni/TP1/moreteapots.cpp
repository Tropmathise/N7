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

void display () 
{

    /* clear window */
    glClear(GL_COLOR_BUFFER_BIT);

    glMatrixMode(GL_MODELVIEW);         // set current matrix as GL_MODELVIEW

    // draw scene 
    glPushMatrix();                 // add a copy of the curr. matrix to the stack

			glPushMatrix();                 // add a copy of the curr. matrix to the stack
				
				glTranslatef(0, 0, -3);             // translate -3 on the z
				glColor3f(1.0f, 0.0f, 0.0f);        // set drawing color to red
				glutWireTeapot( 1 );                // middle red teapot
				glTranslatef(0, 2, 0);              // translate 2 on the y
				glColor3f(0.0f, 1.0f, 0.0f);        // set drawing color to blue
				glRotatef(90, 1.0f, 0.0f, 0.0f);    // rotate 90 deg around x
				glutWireTeapot( 1 );                // top green teapot
			glPopMatrix();                      // pop the current matrix

		glTranslatef(0, -2, -1);            // translate -2 on y and -1 on z
		glColor3f(0.0f, 0.0f, 1.0f);        // set drawing color to blue
		glutWireTeapot( 1 );                // bottom blue teapot

    glPopMatrix();                      // pop the current matrix
    
    /* flush drawing routines to the window */
    glFlush();

}

// Function called everytime a key is pressed
void key( unsigned char key, int x, int y )
{
    switch ( key )
    {
        case 27:
        case 'q':
            exit( EXIT_SUCCESS );
            break;
        default:
            break;
    }
    glutPostRedisplay( );
}

void reshape ( int width, int height ) 
{

    /* define the viewport transformation */
    glViewport(0,0,width,height);

}

int main ( int argc, char * argv[] ) 
{

    /* initialize GLUT, using any commandline parameters passed to the 
       program */
    glutInit(&argc,argv);

    /* setup the size, position, and display mode for new windows */
    glutInitWindowSize(500,500);
    glutInitWindowPosition(0,0);
    glutInitDisplayMode(GLUT_RGB);

    /* create and set up a window */
    glutCreateWindow("hello, teapot!");
    // Set up the callback functions
    // for display
    glutDisplayFunc( display );
    // for the keyboard
    glutKeyboardFunc( key );
    // for reshaping
    glutReshapeFunc( reshape );

    /* define the projection transformation */
    glMatrixMode(GL_PROJECTION);
    
    gluPerspective(60,1,1,10);

    /* define the viewing transformation */
    glMatrixMode(GL_MODELVIEW);
    // glLoadIdentity();
    gluLookAt(0.0,0.0,5.0,0.0,0.0,-1.0,0.0,1.0,0.0);

    /* tell GLUT to wait for events */
    glutMainLoop();
}
