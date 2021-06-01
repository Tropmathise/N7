
import algebra.*;
import java.awt.*;

/**
 * Simple shader that just copy the interpolated color to the screen,
 * taking the depth of the fragment into acount.
 * @author: cdehais
 */
public class PainterShader extends Shader {
    
    DepthBuffer depth;

    public PainterShader (GraphicsWrapper screen) {
        super (screen);
        depth = new DepthBuffer (screen.getWidth (), screen.getHeight ());
    }

    public void shade (Fragment fragment) {
        if (depth.testFragment (fragment)) {
            screen.setPixel (fragment.getX (), fragment.getY (), fragment.getColor ());
            depth.writeFragment (fragment);
        }
    }

    public void reset () {
        depth.clear ();
    }
}

