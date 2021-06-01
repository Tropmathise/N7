
import algebra.*;

/**
 * Test class for the Rasterizer class
 * @author: cdehais
 */ 
public class TestRasterizer {
    
    static class TestShader extends Shader {
        
        public TestShader (GraphicsWrapper screen) {
            super (screen);
        }
        
        public void shade (Fragment fragment) {
            System.out.println ("  fragment: (" + fragment.getX () + ", " + fragment.getY () + ")"
                                + " - color = (" + fragment.getColor() + ")");
        }
    }

    public static void test() throws Exception {

        System.out.println("OFF\n# Test Start");

        TestShader shader = new TestShader (new GraphicsWrapper (256, 256));
        Rasterizer rasterizer = new Rasterizer (shader);

        System.out.println ("Rasterizing edge");
        Fragment v1 = new Fragment (0, 20);
        v1.setColor (0, 0, 0);
        Fragment v2 = new Fragment (5, -35);
        v2.setColor (50, 100, 0);

        rasterizer.rasterizeEdge (v1, v2);
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
