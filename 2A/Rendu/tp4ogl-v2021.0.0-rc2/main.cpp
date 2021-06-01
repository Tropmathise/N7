/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */


#include "ObjModel.hpp"

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
#include <fstream>
#include <utility>
#include <vector>
#include <cstdio>
#include <cstring>
#include <cassert>


#define KEY_ESCAPE 27

#define DELTA_ANGLE_X   5
#define DELTA_ANGLE_Y   5
#define DELTA_DISTANCE  0.3
#define DISTANCE_MIN    0.0

using namespace std;


//  Window

struct glutWindow
{
    int width{1024};
    int height{760};
    string title;

    float field_of_view_angle{45};
    float z_near{0.25f};
    float z_far{500.0f};

    glutWindow() = default;

    explicit glutWindow(string &winName) : title(winName) { }

} ;



//************************************
// global variable containing the OBJ model
//************************************
ObjModel obj;


int angle_y = 0;
int angle_x = 0;
float camDistance = 5;
RenderingParameters params;

glutWindow win;


// Function called every time the main window is resized
void reshape( int width, int height );
void DrawAxis( float scale );
// initialize the opengl
void initialize( );

// define a material in terms of its components

void define_material( GLfloat ar, GLfloat ag, GLfloat ab, // ambient
                      GLfloat dr, GLfloat dg, GLfloat db, // diffuse
                      GLfloat sr, GLfloat sg, GLfloat sb, // specular
                      GLfloat sh // shininess
                      )
{
    GLfloat mat_ambient[4];
    GLfloat mat_diffuse[4];
    GLfloat mat_specular[4];

    mat_ambient[0] = ar;
    mat_ambient[1] = ag;
    mat_ambient[2] = ab;
    mat_ambient[3] = 1.0;
    glMaterialfv( GL_FRONT, GL_AMBIENT, mat_ambient );

    mat_diffuse[0] = dr;
    mat_diffuse[1] = dg;
    mat_diffuse[2] = db;
    mat_diffuse[3] = 1.0;
    glMaterialfv( GL_FRONT, GL_DIFFUSE, mat_diffuse );

    mat_specular[0] = sr;
    mat_specular[1] = sg;
    mat_specular[2] = sb;
    mat_specular[3] = 1.0;
    glMaterialfv( GL_FRONT, GL_SPECULAR, mat_specular );

    glMaterialf( GL_FRONT, GL_SHININESS, sh );
}




// place the light in x,y,z

void place_light( GLfloat x, GLfloat y, GLfloat z )
{

    GLfloat light_position[4];
    GLfloat light_ambient[] = { 0.2, 0.2, 0.2, 1.0 };
    GLfloat light_diffuse[] = { 1.0, 1.0, 1.0, 1.0 };
    GLfloat light_specular[] = { 1.0, 1.0, 1.0, 1.0 };


    light_position[0] = x;
    light_position[1] = y;
    light_position[2] = z;
    light_position[3] = 1.0;

    glLightfv( GL_LIGHT0, GL_AMBIENT, light_ambient );
    glLightfv( GL_LIGHT0, GL_DIFFUSE, light_diffuse );
    glLightfv( GL_LIGHT0, GL_SPECULAR, light_specular );
    glLightfv( GL_LIGHT0, GL_POSITION, light_position );

    glEnable( GL_LIGHT0 );
    glEnable( GL_LIGHTING );

}

void display( )
{
    glClearColor(0.5, .5, .75, 1.);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

    glMatrixMode( GL_MODELVIEW );
    glLoadIdentity( );

    glPushMatrix( );
    place_light( 0, 0, 140 );
    glTranslatef( 0, 0, -camDistance );
    glRotatef( angle_x, 1, 0, 0 );
    glRotatef( angle_y, 0, 1, 0 );

    //        angle_y += 1;

    DrawAxis( 1.0f );

    define_material(
                     0.2, 0.2, 0.2,
                     0.8, 0.8, 0.8,
                     1.0, 0.8, 0.8,
                     100 );
    //***********************************************
    // draw the model
    //***********************************************
    obj.render( params );

    glPopMatrix( );

    glutSwapBuffers( );
}

void printKeyboardHelp()
{
  std::cout << "keys:"
            << "\t s - use index rendering\n"
            << "\t w - draw wireframe\n"
            << "\t h - enable/disable subdivision\n"
            << "\t 1-4 - with subdivision enabled, level of subdivision\n"
            << "\t d - enable/disable solid rendering\n"
            << "\t a - enable/disable smooth rendering\n"
            << "\t n - enable/disable normals rendering\n"
            << "\t arrow keys - rotate around the object\n"
            << "\t pg down/up - zoom out/in\n"
            << std::endl;
}

void keyboard( unsigned char key, int , int  )
{
    switch ( key )
    {
        case KEY_ESCAPE:
            exit( 0 );
        case 's':
            params.useIndexRendering = !params.useIndexRendering;
            PRINTVAR( params.useIndexRendering );
            break;
        case 'w':
            params.wireframe = !params.wireframe;
            PRINTVAR( params.wireframe );
            break;
        case 'h':
            params.subdivision = !params.subdivision;
            PRINTVAR( params.subdivision );
            break;
        case 'd':
            params.solid = !params.solid;
            PRINTVAR( params.solid );
            break;
        case 'a':
            params.smooth = !params.smooth;
            PRINTVAR( params.smooth );
            break;
        case 'n':
            params.normals = !params.normals;
            PRINTVAR( params.normals );
            break;
        case '1':
        case '2':
        case '3':
        case '4':
            params.subdivLevel = (key - '0');
            PRINTVAR( params.subdivLevel );
            break;
        default:
            break;
    }
    glutPostRedisplay( );
    printKeyboardHelp();
}

void arrows( int key, int , int )
{
    switch ( key )
    {
        case GLUT_KEY_UP:
            angle_x = (angle_x + DELTA_ANGLE_X) % 360;
            break;
        case GLUT_KEY_DOWN:
            angle_x = (angle_x - DELTA_ANGLE_X) % 360;
            break;
        case GLUT_KEY_LEFT:
            angle_y = (angle_y + DELTA_ANGLE_Y) % 360;
            break;
        case GLUT_KEY_RIGHT:
            angle_y = (angle_y - DELTA_ANGLE_Y) % 360;
            break;
        case GLUT_KEY_PAGE_DOWN:
            camDistance += DELTA_DISTANCE;
            break;
        case GLUT_KEY_PAGE_UP:
            camDistance -= (camDistance > DISTANCE_MIN) ? DELTA_DISTANCE : 0.0;
            break;
        default: break;
    }
    glutPostRedisplay( );
}

int main( int argc, char **argv )
{
    if(argc ==1 )
    {
      std::cout << "No obj file to load, displaying an emply scene with the reference system" << std::endl;
      std::cout << "Usage:\n\t" + std::string(argv[0]) + " <obj file>" << std::endl;
    }

    // set window values
    win.width = 1024;
    win.height = 760;
    win.title = string("OpenGL/GLUT OBJ Loader.");
    win.field_of_view_angle = 45;
    win.z_near = 0.25f;
    win.z_far = 500.0f;

    // initialize and run program
    glutInit( &argc, argv );
    glutInitDisplayMode( GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH );
    glutInitWindowSize( win.width, win.height );
    glutCreateWindow( win.title.c_str() );
    glutDisplayFunc( display );
    glutReshapeFunc( reshape );
    //    glutIdleFunc( display );                                    // register Idle Function
    glutKeyboardFunc( keyboard );
    glutSpecialFunc( arrows );
    initialize( );

    //***********************************************
    // Load the obj model from file
    //***********************************************
    obj.load( argv[1] );

    //***********************************************
    // Make it unitary
    //***********************************************
    obj.unitizeModel( );

    printKeyboardHelp();

    glutMainLoop( );


    return EXIT_SUCCESS;
}



// Function called every time the main window is resized

void reshape( int width, int height )
{
    // define the viewport transformation;
    glViewport( 0, 0, width, height );

    GLfloat aspect = (GLfloat) win.width / win.height;

    if ( aspect > 1.0f ) //w>h
    {
//        if (width < height)
//        {
//            glViewport(0,(height-width/aspect)/2, width, width/aspect);
//            cout << "a" << endl;
//        }
//        else if ( width/height > aspect )
//        {
//            glViewport((width-height*aspect)/2,0,height*aspect,height);
//            cout << "b" << endl;
//        }
//        else
        if ( width / height < aspect )
        {
            glViewport( 0, (height - width / aspect) / 2, width, width / aspect );
//            cout << "c " << (height-width/aspect)/2 << endl;
        }
        else
        {
            glViewport( (width - height * aspect) / 2, 0, height*aspect, height );
//            cout << "d " << (width-height*aspect)/2 << endl;
        }
    }
    else //h>h
    {
//        if (height < width)
//        {
//            glViewport((width-height*aspect)/2,0, height*aspect, height);
//            cout << "d "<< endl;
//        }
//        else if ( width/height > aspect )
//        {
//            glViewport((width-height*aspect)/2,0,height*aspect,height);
//            cout << "e" << endl;
//        }
//        else
        {
            glViewport( (width - height * aspect) / 2, 0, height*aspect, height );
            cout << "d " << (width - height * aspect) / 2 << endl;
        }
    }
}

void DrawAxis( float scale )
{
    glPushMatrix( );
    glDisable( GL_LIGHTING );

    glScalef( scale, scale, scale );

    glBegin( GL_LINES );

    glColor3f( 1.0, 0.0, 0.0 );
    /*  X axis */
    glVertex3f( 0.0, 0.0, 0.0 );
    glVertex3f( 1.0, 0.0, 0.0 );
    /*  Letter X */
    glVertex3f( .8f, 0.05f, 0.0 ); // "backslash""
    glVertex3f( 1.0, 0.25f, 0.0 );
    glVertex3f( 0.8f, .25f, 0.0 ); // "slash"
    glVertex3f( 1.0, 0.05f, 0.0 );

    /*  Y axis */
    glColor3f( 0.0, 1.0, 0.0 );
    glVertex3f( 0.0, 0.0, 0.0 );
    glVertex3f( 0.0, 1.0, 0.0 );

    // z-axis
    glColor3f( 0.0, 0.0, 1.0 );
    glVertex3f( 0.0, 0.0, 0.0 );
    glVertex3f( 0.0, 0.0, 1.0 );
    /*  Letter Z */
    glVertex3f( 0.0, 0.05f, 0.8 ); // bottom horizontal leg
    glVertex3f( 0.0, 0.05f, 1.0 );
    glVertex3f( 0.0, 0.05f, 1.0 ); // slash
    glVertex3f( 0.0, 0.25f, 0.8 );
    glVertex3f( 0.0, 0.25f, 0.8 ); // upper horizontal leg
    glVertex3f( 0.0, 0.25f, 1.0 );

    glEnd( );

    glEnable( GL_LIGHTING );

    glColor3f( 1.0, 1.0, 1.0 );
    glPopMatrix( );
}

void initialize( )
{
    glMatrixMode( GL_MODELVIEW );
    glShadeModel( GL_SMOOTH );

    glEnable( GL_CULL_FACE );

    glEnable( GL_DEPTH_TEST );
    glDepthFunc( GL_LEQUAL );
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

    glEnable( GL_NORMALIZE );

    glMatrixMode( GL_PROJECTION );
    glViewport( 0, 0, win.width, win.height );
    GLfloat aspect = (GLfloat) win.width / win.height;
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity( );
    gluPerspective( win.field_of_view_angle, aspect, win.z_near, win.z_far );
    glMatrixMode( GL_MODELVIEW );
}

