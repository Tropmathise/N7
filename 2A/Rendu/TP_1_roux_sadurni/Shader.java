

/**
 * The Shader class is responsible for writing final pixel color
 * to the screen (GraphicWrapper), from a Fragment.
 * Subclass this base class and implement the ::shade() method.
 * @author cdehais
 */

public abstract class Shader {

    protected GraphicsWrapper screen;

    public Shader (GraphicsWrapper screen) {
        this.screen = screen;
    }

    /**
     * Common entry point to ree-initialize the shader
     */
    public void reset () { }

    /**
     * Computes the fragment color and write the result to the screen.
     */
    public abstract void shade (Fragment fragment);

    /**
     * Test whether the fragment falls onto the screen.
     */
    public boolean isClipped (Fragment fragment) {
        return ((fragment.getX () < 0) || (fragment.getX () >= screen.getWidth ()) ||
                (fragment.getY () < 0) || (fragment.getY () >= screen.getHeight ()));
    }
}
