/**
 * A "virtual" screen, where only "setPixel" is available
 * (It is a JFrame, and JFrame.EXIT_ON_CLOSE is set)
 * @author smondet
 */


import java.awt.*;
import java.awt.geom.*;
import java.awt.image.*;
import javax.swing.*;
import java.lang.Math;


class ImageComponent extends Component {

  BufferedImage renderedImage = null;

  public ImageComponent (BufferedImage init) {
    renderedImage = init;
  }

  public BufferedImage swapImage (BufferedImage bi) {
    BufferedImage ret = renderedImage ;
    renderedImage = bi ;
    return ret ;
  }

  public void paint(Graphics g) {

    if (renderedImage != null) {
      ((Graphics2D)g).drawImage(renderedImage, new AffineTransform(1f,0f,0f,1f,0,0), null);
    }
  }

}




public class GraphicsWrapper {

  private int height = 0;
  private int width = 0;
  private int pixelSize = 0;

  private JFrame myFrame ;

  private ImageComponent drawComp = null;

  private BufferedImage backBuffer = null ;
  private BufferedImage frontBuffer = null ;

  private void init() {
    backBuffer = new BufferedImage (width * pixelSize, height * pixelSize, BufferedImage.TYPE_INT_ARGB) ;

    frontBuffer = new BufferedImage (width * pixelSize, height * pixelSize, BufferedImage.TYPE_3BYTE_BGR) ;

    /*
    Graphics2D gd = initial.createGraphics ();
    gd.setColor (Color.BLACK) ;
    gd.fillRect (0,0, width * pixelSize, height * pixelSize) ;
    gd = drawingImage.createGraphics ();
    gd.setColor (Color.BLACK) ;
    gd.fillRect (0,0, width * pixelSize, height * pixelSize) ;
    */

    drawComp = new ImageComponent (frontBuffer);
    drawComp.setPreferredSize (new Dimension (width * pixelSize, height * pixelSize)) ;
    drawComp.setVisible (true);

    myFrame = new JFrame("Simple Inverse Rasterization Renderer (TSI)");
    myFrame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE) ;
    myFrame.add("Center", drawComp );
    myFrame.pack();
    myFrame.setVisible(true);
  }

  /**
   * Build a virtual screen of size width x height
   * And set its window visible.
   */
  public GraphicsWrapper(int width, int height) {
    this.height = height;
    this.width = width;
    this.pixelSize = 1;
    init();
  }

  /**
   * Build a virtual screen of size width x height, where one virtual pixel is represented by
   * a pixelSize x pixelSize square.
   * And set its window visible.
   */
  public GraphicsWrapper(int width, int height, int pixelSize) {
    this.height = height;
    this.width = width;
    this.pixelSize = pixelSize ;
    init();
  }

  /**
   * Lights the pixel (x,y) with color (r, g, b) (values clamped to [0,1])
   * on the current draw buffer.
   * Does nothing for pixels out of the screen.
   */
  public void setPixel (int x, int y, double r, double g, double b) {
    
    r = Math.min (1.0, Math.max (0.0, r));
    g = Math.min (1.0, Math.max (0.0, g));
    b = Math.min (1.0, Math.max (0.0, b));

    setPixel(x, y, (char) (r * 255), (char) (g * 255), (char) (b * 255));
  }

  /**
   * Lights the pixel (x,y) with color (r, g, b) (values clamped to [0, 255])
   * on the current draw buffer.    
   * Does nothing for pixels out of the screen.
   */
    public void setPixel(int x, int y, char r, char g, char b) {

        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) {
            int argb = 0xFF000000 ;
            argb += ((int)r) << (8 * 2) ;
            argb += ((int)g) << (8 * 1) ;
            argb += ((int)b);
      
            for (int i = 0 ; i < pixelSize ; i++ ) {
                for (int j = 0 ; j < pixelSize ; j++ ) {
                    backBuffer.setRGB(i + (x * pixelSize) , j + (y * pixelSize),  argb) ;
                }
            }
        }
    }

  /**
   * Lights the pixel (x,y) with the given color.
   * Does nothing for pixels out of the screen.
   */
    public void setPixel(int x, int y, Color color) {

        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) {
            int rgb = color.getRGB ();
            for (int i = 0 ; i < pixelSize ; i++ ) {
                for (int j = 0 ; j < pixelSize ; j++ ) {
                    backBuffer.setRGB(i + (x * pixelSize) , j + (y * pixelSize), rgb);
                }
            }
        }
    }

  /**
   * Gets the pixel in the back buffer
   */ 
    public Color getPixel (int x, int y) {
        Color color;

        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) {
            color = new Color (backBuffer.getRGB (x, y), false);
        } else {
            color = Color.BLACK;
        }

        return color;
    }

    public Color getFrontPixel (int x, int y) {
        Color color;

        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) {
            color = new Color (frontBuffer.getRGB (x, y), false);
        } else {
            color = Color.BLACK;
        }

        return color;
    }
    /**
     *
     */
    int getWidth () {
        return width;
    }

    int getHeight () {
        return height;
    }

  /**
   * Clear current draw-buffer (ie Paint it black)
   *
   */
  public void clearBuffer() {
    Graphics2D gd = backBuffer.createGraphics ();
    gd.setColor (Color.BLACK) ;
    gd.fillRect (0,0, width * pixelSize, height * pixelSize) ;
  }

  /**
   * Draw current draw-buffer on the window.
   *
   */
  public void swapBuffers() {
    frontBuffer = drawComp.swapImage (backBuffer) ;
    myFrame.repaint ();
  }

  /**
   * Destroy window.
   */
  public void destroy() {
    myFrame.dispose();
  }


}
