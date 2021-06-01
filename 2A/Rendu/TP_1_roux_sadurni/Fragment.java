
import java.awt.*;
import algebra.*;

/**
 * The Fragment class represents an attributed 'pixel' as generated
 * by a Rasterizer.
 * @author cdehais
 */

public class Fragment {
    private int x;
    private int y;
    private int numAttributes;

    /* attributes placement:
     * 0: depth  
     * 1-3: color
     * 4-6: normal
     * 7-8: (u,v) texture coordinates
     */
    double[] attributes;

    public Fragment (int x, int y) { // int numAdditionalAttributes) {
        this.x = x;
        this.y = y;
        numAttributes = 9;
        attributes = new double[numAttributes];
    }

    public int getNumAttributes () {
        return numAttributes;
    }

    /**
     * Gets a scalar attribute at index.
     */
    public double getAttribute (int index) {
        return attributes[index];
    }

    /**
     * Gets a vector attribute at the given starting location and with the given dimension.
     */
    public double[] getAttribute (int index, int dimension) {
        double[] attr = new double[dimension];

        for (int i = 0; i < dimension; i++) {
            attr[i] = attributes[index+i];
        }

        return attr;
    }
    
    public void setAttribute (int index, double value) {
        attributes[index] = value;
    }

    /**
     * Gets the x pixel coordinate of the Fragment
     */
    public int getX () {
        return x;
    }
    /**
     * Gets the y pixel coordinate of the Fragment
     */
    public int getY () {
        return y;
    }

    /**
     * Gets the pixel coordinates (x, y) of the Fragment as a size 2 array 
     */
    public int[] getPosition () {
        int[] position = new int[2];

        position[0] = x;
        position[1] = y;

        return position;
    }

    public void setPosition (int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public double getDepth () {
        return attributes[0];
    }

    public void setDepth (double z) {
        attributes[0] = z;
    }

    public Vector3 getNormal () {
        return new Vector3 (attributes[0], attributes[1], attributes[2]);
    }

    public void setNormal (Vector normal) {
        attributes[4] = normal.get (0);
        attributes[5] = normal.get (1);
        attributes[6] = normal.get (2);
    }

    public void setNormal (double nx, double ny, double nz) {
        attributes[4] = nx;
        attributes[5] = ny;
        attributes[6] = nz;
    }

    public Color getColor () {
        int r = (int) Math.min (255, Math.max (255 * attributes[1], 0));
        int g = (int) Math.min (255, Math.max (255 * attributes[2], 0));
        int b = (int) Math.min (255, Math.max (255 * attributes[3], 0));
        return new Color (r, g, b);
    }

    public void setColor (Color color) {
        attributes[1] = color.getRed ();
        attributes[2] = color.getGreen ();
        attributes[3] = color.getBlue ();
    }

    public void setColor (double r, double g, double b) {
        attributes[1] = r;
        attributes[2] = g;
        attributes[3] = b;
    }


    public String toString () {
        return "(" + x + "," + y + ")";
    }
}
