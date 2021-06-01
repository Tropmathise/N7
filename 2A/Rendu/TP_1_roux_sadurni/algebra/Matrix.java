/*
 * @author: cdehais  
 */  


package algebra;

import java.lang.Math;

public class Matrix {

    protected Matrix () {}
    
    protected Matrix (String name) {
        this.name = name;
    }


    /**
     * Creates a named  Matrix of size nRows x nCols.
     */
    public Matrix (String name, int nRows, int nCols) throws java.lang.InstantiationException {
        this (nRows, nCols);    
        this.name = name;
    }

    /**
     * Creates a Matrix of size nRows x nCols.
     */
    public Matrix (int nRows, int nCols) throws java.lang.InstantiationException {
        allocValues (nRows, nCols);
    }

    /**
     * Creates an identity matrix of size @size
     */
    public static Matrix createIdentity (int size) throws java.lang.InstantiationException {
        Matrix id = new Matrix (size, size);

        for (int i = 0; i < size; i++) {
            id.values[size*i+i] = 1.0;
        }
        id.name = "I" + size;
        return id;
    }
    
    /**
     * Extracts a submatrix of size nRows x nCols with top left corner at (offsetRow, offsetCol)
     */
    public Matrix getSubMatrix (int offsetRow, int offsetCol, int nRows, int nCols)
        throws InstantiationException
    {
        if ((offsetRow < 0) || (offsetCol < 0) || (nRows < 1) || (nCols < 1) ||
            (offsetRow + nRows > this.nRows) || (offsetCol + nCols > this.nCols)) {
            throw new InstantiationException ("Invalid submatrix");
        }

        Matrix sub = new Matrix (nRows, nCols);

        for (int i = 0; i < nRows; i++) {
            for (int j = 0; j < nCols; j++) {
                sub.set (i, j, this.get (offsetRow + i, offsetCol + j));
            }
        }

        return sub;
    }

    
    /**  
     * Concatenate two Matrix 
     * Boolean true => horizontal concatenation
     * Boolean false => vertical concatenation
     */
    public static Matrix concatenate(Boolean horizontal, Matrix M1, Matrix M2){
        Matrix M;
        if(horizontal) {
            try {
                M = new Matrix(M1.nRows, M1.nCols + M2.nCols);
            } catch (java.lang.InstantiationException e) {
                /* unreached */
                return null;
            }
            for (int i = 0 ; i < M1.nRows ; i++) {
                for (int j = 0 ; j < M1.nCols ; j++) {
                    M.set(i, j, M1.get(i, j));
                }
                for (int j = 0 ; j < M2.nCols ; j++) {
                    M.set(i, j + M1.nCols, M2.get(i, j));
                }
            }
        } else {
            try {
                M = new Matrix(M1.nRows + M2.nRows, M1.nCols);
            } catch (java.lang.InstantiationException e) {
                /* unreached */
                return null;
            }
            for (int j = 0 ; j < M1.nCols ; j++) {
                for (int i = 0 ; i < M1.nRows ; i++) {
                    M.set(i, j, M1.get(i, j));
                }
                for (int i = 0 ; i < M2.nRows ; i++) {
                    M.set(i + M1.nRows, j, M2.get(i, j));
                }
            }
        }
        return M;
    }

    /**
     * Convert vector into matrix
     */ 
    public static Matrix vectorToMatrix(Vector v) {
        Matrix M;
        try {
            M = new Matrix(v.size(), 1);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
            return null;
        }
        for (int i = 0 ; i < v.size() ; i++) {
            M.set(i, 0, v.get(i));
        }
        return M;
    }

    /**
     * Transposes the square Matrix.
     */ 
    public Matrix transpose () {
       Matrix trans;
	try {
            trans = new Matrix (this.nCols,this.nRows);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
            return null;
        }
        for (int i = 0; i < nCols; i++) {
            for (int j = i; j < nRows; j++) {
                trans.values[i * nCols + j] = this.values[j * nCols + i];
                trans.values[j * nCols + i] = this.values[i * nCols + j];
            }
        }
       return trans;
    }

    /**
     * Matrix/Matrix multiplication
     */
    public Matrix multiply (Matrix M) throws SizeMismatchException {
        if (nCols != M.nRows) {
            throw new SizeMismatchException (this, M);
        }

        Matrix R;
        try {
            R = new Matrix (this.nRows, M.nCols);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
            return null;
        }

        for (int i = 0; i < R.nRows; i++) {
            for (int j = 0; j < R.nCols; j++) {
                for (int k = 0; k < this.nCols; k++) {
                    R.values[i * R.nCols + j] += this.values[i * nCols + k] * M.values[k * nRows + j];
                }
            }
        }

        return R;
    }

    /**
     * Matrix/vector multiplication
     */
    public Vector multiply (Vector v) throws SizeMismatchException {
        if (nCols != v.size()) {
            throw new SizeMismatchException (this, v);
        } 

        Vector u = null;
        try {
            u = new Vector (nRows);
        } catch (java.lang.InstantiationException e) {
            /* unreached */
        }

        for (int i = 0; i < u.size(); i++) {
            double e = 0.0;
            for (int k = 0; k < this.nCols; k++) {
                e += values[i * nCols + k] * v.get(k);
            }
            u.set(i, e);
        }

        return u;
    }

    /**
     * Sets the element on row @i and column @j to the given value @value.
     */
    public void set (int i, int j, double value) {
        values[i * nCols + j] = value;
    }

    /**
     * Gets the element on row @i and column @j.
     */
    public double get (int i, int j) {
        return values[i * nCols + j];
    }

    /**
     * Sets the matrix name
     */
    public void setName (String name) {
        this.name = name;
    }

    /**
     * Returns a Matlab compatible representation of the Matrix. 
     */
    public String toString () {
        String repr = name + " = [";
        int spacing = repr.length();
        for (int i = 0; i < nRows; i++) {
            if (i > 0) {
                for (int j = 0; j < spacing; j++) {
                    repr += " ";
                }
            }
            for (int j = 0; j < nCols; j++) {
                repr += values[nCols * i + j] + " ";
            }
            repr += ";\n";
        }

        repr += "];";

        return repr;
    }

    protected void allocValues (int nRows, int nCols) throws java.lang.InstantiationException {
        int size = nRows * nCols;
        if (size < 1) {
            throw new java.lang.InstantiationException ("Both matrix dimensions must be strictly positive");
        }
        this.values = new double[size]; 
        this.nRows = nRows;
        this.nCols = nCols;
    }

    public String getName () {
        return name;
    }

    public int nRows () {
        return nRows;
    }

    public int nCols() {
        return nCols;
    }

    public String name = "M";
    protected double values[];
    private int nRows;
    private int nCols;
}
