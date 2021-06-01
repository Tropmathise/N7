
import algebra.*;
import java.lang.Math.*;

/**
 * The PerspectiveCorrectRasterizer class extends Rasterizer to perform Persepctive Correct interpolation
 * of attributes.
 *
 * @author cdehais
 */
public class PerspectiveCorrectRasterizer extends Rasterizer {

    public PerspectiveCorrectRasterizer (Shader shader) {
        super(shader);
    }

    /**
     * Rasterizes the triangular face made of the Fragment v1, v2 and v3
     */
    public void rasterizeFace (Fragment v1, Fragment v2, Fragment v3) {
        Matrix C = makeBarycentricCoordsMatrix (v1, v2, v3);

        /* iterate over the triangle's bounding box */
        int xmin = Math.min (v1.getX (), Math.min (v2.getX (), v3.getX ()));
        int ymin = Math.min (v1.getY (), Math.min (v2.getY (), v3.getY ()));
        int xmax = Math.max (v1.getX (), Math.max (v2.getX (), v3.getX ()));
        int ymax = Math.max (v1.getY (), Math.max (v2.getY (), v3.getY ()));
        
        Fragment fragment = new Fragment (0, 0);
        int numAttributes = fragment.getNumAttributes ();
        try {
        for (int x = xmin; x <= xmax; x++) {
            for (int y = ymin; y <= ymax; y++) {
                
                /* setup position now to allow early clipping */
                fragment.setPosition (x, y);
                if (!shader.isClipped (fragment)) {

                    Vector3 v = new Vector3 (1.0, (double)x, (double)y);
                    Vector bar = C.multiply (v);
                    if ((bar.get (0) >= 0.0) && (bar.get (1) >= 0.0) && (bar.get (2) >= 0.0)) {
                        double oneOverZ = bar.get (0) / v1.getDepth () +
                                            bar.get (1) / v2.getDepth () +
                                            bar.get (2) / v3.getDepth ();
                        for (int i = 0; i < numAttributes; i++) {
                            double aOverZ = bar.get (0) * v1.getAttribute (i) / v1.getDepth () +
                                            bar.get (1) * v2.getAttribute (i) / v2.getDepth () +
                                            bar.get (2) * v3.getAttribute (i) / v3.getDepth ();

                            fragment.setAttribute (i, aOverZ / oneOverZ);
                        }
                        shader.shade (fragment);
                    }
                }
            }
        }
        } catch (SizeMismatchException e) {
            /* should not reach */
            e.printStackTrace ();
        }
    }
}
