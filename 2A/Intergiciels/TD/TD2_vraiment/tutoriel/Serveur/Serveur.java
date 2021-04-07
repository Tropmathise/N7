import java.rmi.*;
import java.io.*;

public class Serveur {

    public static void main(String[] args) {

        try {
            NombreAleatoireGenerator nag = new NombreAleatoireGenerator();
            Naming.bind("rmi://localhost/nagi", nag);
            System.out.println("L'objet " + nag + " est publié dans le registre.");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
