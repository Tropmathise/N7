import java.lang.*; import java.util.*; import algebra.*;
/* * The Lighting class describes a scene lighting environment
 * @author: gmorin, smondet */
public class Lighting {
    static final int NONE = 0 ;    static final int AMBIENT = 1 ;
    static final int POINT = 2 ;
    List lights ;
    /* Internal Class describing a light source */  
    private class Light {
        public int type = NONE;
        public double[] params;
        public Light (int type, double []params) {
            this.type = type;            this.params = params;
        }
    }
    public Lighting() {
        lights = new LinkedList();    }
    /* Adds a new ambient light source of intensity @ia to the environment.   */
    public void addAmbientLight (double ia) {
        double [] v = new double[1];
        v[0] = ia;        lights.add (new Light (AMBIENT, v));    }
    /** Addsa */
    public void addPointLight (double x, double y, double z, double id)
    {
        double[] v = new double[5];
        v[0] = x;        v[1] = y;        v[2] = z;        v[3] = id;
        lights.add (new Light (POINT, v));    }
    /* Computes the illuminated color of a 3D points of given position, normal and color,
     * and given the camera position and material parameters.
     * Returns an array of size 3.     */ 
    public double[] applyLights (Vector3 position, Vector3 normal, double[] color,
                                 Vector3 cameraPosition,
                                 double ka, double kd, double ks, double s) 
    {
        double[] litColor = new double[3];
        /* total light intensity */
        double I = 0.0;
        Iterator it = lights.iterator ();
        while (it.hasNext ()){
            Light light = (Light) it.next ();
            switch (light.type) {
                case AMBIENT:
                    /* Ambient light : A COMPLETER */
                	double Ia = light.params[0];
                	I += Ia *ka;
                    break;
                case POINT:
                    try {
                    /* vector from point to camera center */
                    Vector3 e = new Vector3 (cameraPosition);
                    e.substract (position);
                    e.normalize ();
                    /* vector from point to light*/
                    Vector3 l = new Vector3 (light.params[0], light.params[1], light.params[2]);
                    l.substract (position);
                    l.normalize ();
                    /* half-vector between e and l*/
                    Vector3 h = new Vector3 (e);
                    h.add (l);
                    h.normalize ();
                    /* diffuse contribution */
                    double Id = light.params[3]*kd*normal.dot(l);
                    /* specular contribution */
                    double Is = light.params[3]*ks*Math.pow(h.dot(normal),s);
                    I += Id + Is;
                    } catch (InstantiationException ex) { /* should not reach*/ }
                      catch (SizeMismatchException  ex) { /* should not reach*/ }
                    break;
                default:
                    /* ignore unknow lights */
                    break;
            }
        } 
        litColor[0] = I * color[0]; litColor[1] = I * color[1]; litColor[2] = I * color[2];
        return litColor;
    }
}
