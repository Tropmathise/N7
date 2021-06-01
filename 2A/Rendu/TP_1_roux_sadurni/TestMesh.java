
import algebra.*;

/**
 * Test class for the Mesh class
 * @author: cdehais based on gmorin, smondet
 */ 
public class TestMesh {
    
    public static void test() throws Exception {

        System.out.println("OFF\n# Test Start");

        Mesh mesh = new Mesh ("data/cube_multi_color.off") ;
//        Transform rend = new Transform(); 
    
        Vector[] vertices = mesh.getVertices ();
        int[]    faces    = mesh.getFaces    ();
        double[] colors   = mesh.getColors   (); 
        Vector[] normals  = mesh.getNormals();    

        System.out.println("** vertices + colors: ") ;
        for (int i = 0 ; i < vertices.length; i++) {
            System.out.println (vertices[i] + " - (" + colors[3 * i + 0] + "," 
                                                     + colors[3 * i + 1] + "," 
                                                     + colors[3 * i + 2] + ")");
        }
    
        System.out.println ("** faces: ") ;
        for (int i = 0 ; i < mesh.getNumFaces (); i++) {
            System.out.println (faces[3 * i] + " " + faces[3 * i + 1] + " " + faces[3 * i + 2]);
        }
 
	/* A decommenter lorsque les normales seront calculees */
        /* System.out.println("** computed per vertex normals: ");
        for (int i = 0 ; i < vertices.length; i++) {
            System.out.println (normals[i]);
        }*/
   
        /*
        System.out.println("vertices after change of basis: ") ;
      
    for (int i = 0 ; i < vertices.length / 3 ; i++ ){
        System.out.println(
          vertices[ 3 * i + 0 ] + " " +
          vertices[ 3 * i + 1 ] + " " +
          vertices[ 3 * i + 2 ] + " " +
          colors  [ 3 * i + 0 ] + " " +
          colors  [ 3 * i + 1 ] + " " +
          colors  [ 3 * i + 2 ]);
      }
     */
  }

    public static void main (String[] args) {
        try {
            test() ;
        } catch (Exception e) {
            System.out.println("EXCEPTION: " + e) ;
            e.printStackTrace() ;
        }
  }

}
