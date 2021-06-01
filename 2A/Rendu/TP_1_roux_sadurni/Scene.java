
import java.io.*;
import algebra.*;

/**
 * Class that describes a simple 3D Scene:
 * This description is meant to be read form a scene description file (.scene extension)
 *
 * @author: cdehais based on smondet, gmorin
 */

public class Scene {
    
    private static String nextLine (BufferedReader in) throws Exception  {
        String r = in.readLine();

        while (r.matches("(\\s*#.*)|(\\s*$)")) {
            r = in.readLine() ;
        }
        return r;
    }

    String meshFilename;
    Vector3 cameraPosition = new Vector3 ("cam_pos");
    Vector3 cameraLookAt   = new Vector3 ("cam_lookat");
    Vector3 cameraUp       = new Vector3 ("cam_up");
    double cameraFocal;
    int screenW;
    int screenH;
    double ambientI;
    double sourceI;
    double[] sourceCoord  = new double[3] ;
    double[] material     = new double[4] ;

    public Scene (String filename) throws Exception {

        BufferedReader in = new BufferedReader(new FileReader(filename));

        meshFilename = nextLine(in);

        String r = nextLine(in);
        String [] sar = r.split("\\s+");
        cameraPosition.set (new Double(sar[0]).doubleValue(),
                            new Double(sar[1]).doubleValue(),
                            new Double(sar[2]).doubleValue());

        r = nextLine(in);
        sar = r.split("\\s+");
        cameraLookAt.set (new Double(sar[0]).doubleValue(),
                          new Double(sar[1]).doubleValue(),
                          new Double(sar[2]).doubleValue());
                        
        r = nextLine(in);
        sar = r.split("\\s+");
        cameraUp.set (new Double(sar[0]).doubleValue(),
                      new Double(sar[1]).doubleValue(),
                      new Double(sar[2]).doubleValue());
                        
        r = nextLine(in);
        cameraFocal = new Double(r).doubleValue();

        r = nextLine(in);
        sar = r.split("\\s+");
        screenW = new Integer(sar[0]).intValue();
        screenH = new Integer(sar[1]).intValue();
 
        r = nextLine(in);
        ambientI = new Double(r).doubleValue();

        r = nextLine(in);
        sar = r.split ("\\s+");
        for (int i = 0; i < sourceCoord.length; i++) {
    	    sourceCoord[i] = new Double(sar[i]).doubleValue();	
        }
        sourceI = new Double(sar[3]).doubleValue();
 
        r = nextLine(in);
        sar = r.split ("\\s+");
        for (int i = 0; i < material.length; i++) {
            material[i] = new Double(sar[i]).doubleValue();	
        }
    }

    public String    getMeshFileName   () { return meshFilename ; }
    public Vector3   getCameraPosition () { return cameraPosition ; }   
    public Vector3   getCameraLookAt   () { return cameraLookAt   ; }   
    public Vector3   getCameraUp       () { return cameraUp       ; }   
    public double    getCameraFocal    () { return cameraFocal    ; }   
    public int       getScreenW        () { return screenW        ; }   
    public int       getScreenH        () { return screenH        ; }   
    public double    getAmbientI       () { return ambientI       ; }
    public double    getSourceI        () { return sourceI        ; }
    public double[]  getSourceCoord    () { return sourceCoord    ; }
    public double[]  getMaterial       () { return material       ; }
}
