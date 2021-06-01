
package algebra;

/**
 * Exception class for incorrect dimensions in arithmetic operations on Matrix and Vector
 */
public class SizeMismatchException extends Exception {

    public SizeMismatchException () {

    }
    
    public SizeMismatchException (Vector v1, Vector v2) {
        super (v1.name + "[" + v1.size () + "] != " + v2.name + "[" + v2.size () + "]");
    }
    
    public SizeMismatchException (Matrix M1, Matrix M2) {
        super (M1.name + "[*," + M1.nCols () + "] != " + M2.name + "[" + M2.nRows () + ",*]");
    }

    public SizeMismatchException (Matrix M, Vector v) {
        super (M.name + "[*," + M.nCols () + "] != " + v.name + "[" + v.size () + ",*]");
    }

    public SizeMismatchException (String msg) {
        super (msg);
    }

}
