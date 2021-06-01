
import java.security.spec.ECFieldF2m;

import algebra.*;

/**
 * author: cdehais
 */
public class Transformation  {

    Matrix worldToCamera;
    Matrix projection;
    Matrix calibration;

    public Transformation () {
        try {
            worldToCamera = new Matrix ("W2C", 4, 4);
            projection = new Matrix ("P", 3, 4);
            calibration = Matrix.createIdentity (3);
            calibration.setName ("K");
        } catch (InstantiationException e) {
            /* should not reach */
        }
    }

    public void setLookAt (Vector3 cam, Vector3 lookAt, Vector3 up) {
        try {
        // compute rotation
            Vector3 e3c = new Vector3(lookAt);
            // plan image
            e3c.substract(cam);
            e3c.normalize();
            Vector3 e1c = up.cross(e3c);
            e1c.normalize();
            Vector3 e2c = e3c.cross(e1c);
            e2c.normalize();

            // création de la matrice N du cours
            Matrix N = Matrix.concatenate(true, Matrix.vectorToMatrix(e1c),Matrix.vectorToMatrix(e2c));
            N = Matrix.concatenate(true, N, Matrix.vectorToMatrix(e3c));
            Matrix Nt = N.transpose();

            // compute translation
            Vector3 moinst= new Vector3(Nt.multiply(cam));
            moinst.scale(-1);
            worldToCamera = Matrix.concatenate(true, Nt, Matrix.vectorToMatrix(moinst));
            Matrix derniereLigne = new Matrix(1,4);
            derniereLigne.set(0,0,0);
            derniereLigne.set(0,1,0);
            derniereLigne.set(0, 2, 0);
            derniereLigne.set(0,3,1);
            worldToCamera = Matrix.concatenate(false, worldToCamera, derniereLigne);
            worldToCamera.setName("W2C");

        } catch (Exception e) { /* unreached */ };
        
        System.out.println ("Modelview matrix:\n" + worldToCamera);
    }

    public void setProjection () {
        Vector3 zeros = new Vector3(0,0,0);
        try {
            projection = Matrix.concatenate(true, Matrix.createIdentity(3), Matrix.vectorToMatrix(zeros));
        } catch (Exception e) { /* unreached */ };
        System.out.println ("Projection matrix:\n" + projection);
    }

    public void setCalibration (double focal, double width, double height) {


	/* à compléter */
		calibration.set(0,0,focal);
		calibration.set(0,2,width/2);
		calibration.set(1,1,focal);
		calibration.set(1,2,height/2);
    	System.out.println ("Calibration matrix:\n" + calibration);
    }

    /**
     * Projects the given homogeneous, 4 dimensional point onto the screen.
     * The resulting Vector as its (x,y) coordinates in pixel, and its z coordinate
     * is the depth of the point in the camera coordinate system.
     */  
    public Vector3 projectPoint (Vector p)
        throws SizeMismatchException, InstantiationException {
		Vector ps = new Vector(3);
		ps = projection.multiply(worldToCamera.multiply(p));
		double zc = ps.get(2);
		if (zc!=0) {
			ps.scale(1/zc);
			ps = calibration.multiply(ps);
			ps.set(2,zc);
		}
		return new Vector3 (ps);
    }
    
    /**
     * Transform a vector from world to camera coordinates.
     */
    public Vector3 transformVector (Vector3 v)
        throws SizeMismatchException, InstantiationException {
        /* Doing nothing special here because there is no scaling */
        Matrix R = worldToCamera.getSubMatrix (0, 0, 3, 3);
        Vector tv = R.multiply (v);
        return new Vector3 (tv);
    }
    
}

