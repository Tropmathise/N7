
import java.util.*;
import java.awt.*;
import java.lang.Math.*;

public class TestGraphicWrapper {

    static int width = 128;
    static int height = 128;
    static GraphicsWrapper screen;

    private static void checker (int polarity, double r, double g, double b) {
        screen.clearBuffer();

        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {

                if (((i / 8) % 2 == 1) == ((j / 8) % 2 == polarity)) {
                    screen.setPixel (j, i, r, g, b);
                }
            }
        }        
    }

    static void init () {
        screen = new GraphicsWrapper (width, height, 1);
    }

    static int countNeighbours (int x0, int y0) {
        int count = 0;

        for (int y = y0 - 1; y <= y0 + 1; y++) {
            for (int x = x0 - 1; x <= x0 + 1; x++) {
                if ((x != x0) || (y != y0)) {
                    int _x = x % width;
                    int _y = y % height;
                    Color pix = screen.getFrontPixel (_x, _y);
                    if (pix.getRed () != 0) {
                        count++;
                    }
                }
            }    
        }

        return count;
    }

    static void evolve () {

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int c = countNeighbours (x, y);
                Color pix = screen.getFrontPixel (x, y);
                Color bpix = screen.getPixel (x, y);
                if (pix.getRed () == 0)  {
                    //System.out.println (x + " " + y + " : dead (" + c + " nbrs) "
                    //                + ((bpix.getRed () == 0) ? "dead" : "alive")
                    //                );
                    if (c == 3) {
                        /* born */
                        screen.setPixel (x, y, 255, 255, 255);
                    } else {
                        screen.setPixel (x, y, 0, 0, 0);
                    }
                } else {
                    //System.out.println (x + " " + y + " : alive (" + c + " nbrs) "
                    //                + ((bpix.getRed() == 0) ? "dead" : "alive"));
                    if ((c >= 2) && (c <= 3)) {
                        /* survive */
                        screen.setPixel (x, y, 255, 255, 255);
                    } else {
                        /* die */
                        screen.setPixel (x, y, 0, 0, 0);
                    }
                }
            }
        }
    }
 
    public static void testChecker () throws Exception {
   
        for (int k = 0; k < 10; k++) {
   
            checker (1, 1.0, 1.0, 1.0);
            screen.swapBuffers ();
            Thread.sleep (100);
            
            checker (0, 1.0, 1.0, 1.0);
            screen.swapBuffers ();
            Thread.sleep (100);
        }
    }

    public static void testConway () throws Exception {
        
        screen.clearBuffer ();
        //screen.swapBuffers ();
        //screen.clearBuffer ();
        //screen.swapBuffers ();
        /*
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (Math.random() < 0.3) {
                    screen.setPixel (x, y, 255, 255, 255);
                }
            }
        }
        */
        screen.setPixel (20, 10, 255, 255, 255);
        screen.setPixel (21, 11, 255, 255, 255);
        screen.setPixel (19, 12, 255, 255, 255);
        screen.setPixel (20, 12, 255, 255, 255);
        screen.setPixel (21, 12, 255, 255, 255);

        screen.swapBuffers ();
        Thread.sleep (1000);

        for (int k = 0; k < 100; k++) {
            evolve ();
            screen.swapBuffers ();
            Thread.sleep (30);
        }

  	screen.destroy() ;
        System.exit(0);
    }

    public static void main(String[] args) {

        try {
            init ();
            //testChecker () ;
            testConway () ;
        } catch (Exception e) {
            System.out.println("EXCEPTION: " + e) ;
            e.printStackTrace() ;
        }
    }

}

