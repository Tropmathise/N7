/**
 * @author: cdehais 
 */

package algebra;

import java.lang.Math;

public class Vector3 extends Vector {

    public Vector3 (double x, double y, double z) {
        super();
        try {
            allocValues (3);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
        }
        this.values[0] = x;
        this.values[1] = y;
        this.values[2] = z;
    }

    public Vector3 () {
        this (0.0, 0.0, 0.0);
    }

    public Vector3 (String name) {
        this (0.0, 0.0, 0.0);
        this.setName (name);
    }

    /**
     * Creates a new named 3D vector with coordinates (x, y, z). 
     */
    public Vector3 (String name, double x, double y, double z) {
        super ();
        try {
            allocValues (4);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
        }

        this.values[0] = x;
        this.values[1] = y;
        this.values[2] = z;
    }

    /**
     * Copy constructor from a Vector of size 3 or 4.
     * For a vector of size 4, divide the 3 first coordinates by the fourth.
     */
    public Vector3 (Vector v) throws InstantiationException {
        this ();
        if ((v.size != 3) && (v.size != 4)) {
            throw new InstantiationException ("Can only build 3D vector from vector of size 3 or 4");
        }

        if (v.size == 3) {
            set (v.get (0), v.get (1), v.get (2));
        } else {
            double w = v.get (3);
            set (v.get (0) / w, v.get (1) / w, v.get (2) / w);
        }
    }

    /**
     * Makes the x, y, and z coordinates of the Vector3 cartesian, by dividing them by
     * the homogeneous coordinate w.
     */ 
    public void makeCartesian () throws java.lang.ArithmeticException {
        this.values[0] /= this.values[3];
        this.values[1] /= this.values[3];
        this.values[2] /= this.values[3];
        this.values[3] = 1.0;
    }

    public void set (double x, double y, double z) {
        this.values[0] = x;
        this.values[1] = y;
        this.values[2] = z;
    }


    /**
     * Computes the cross product between the Vector3 and the given vector.
     */
    public Vector3 cross (Vector3 v) {
        double rx = this.getY () * v.getZ () - this.getZ() * v.getY();
        double ry = this.getZ () * v.getX () - this.getX() * v.getZ();
        double rz = this.getX () * v.getY () - this.getY() * v.getX();

        return new Vector3 (rx, ry, rz);
    }

    public double dot (Vector3 v) {
        double r = 0.0;
        return (values[0] * v.values[0] + values[1] * v.values[1] + values[2] * v.values[2]);
    }

    public double norm () {
        double r = (values[0] *values[0] + values[1] * values[1] + values[2] * values[2]);
        return Math.sqrt (r);
    }

    /**
     * Gets the x coordinates of the Vector3
     */
    public double getX () {
        return this.values[0];
    } 

    /**
     * Gets the w coordinates of the Vector3
     */
    public double getY () {
        return this.values[1];
    } 

    /**
     * Gets the w coordinates of the Vector3
     */
    public double getZ () {
        return this.values[2];
    }
}
