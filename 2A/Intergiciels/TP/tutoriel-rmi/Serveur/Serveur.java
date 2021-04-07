import java.rmi.*;
import java.io.*;

public class Serveur {

    public static void main(String[] args) {

        try {
            ObjetDistantImpl obj = new ObjetDistantImpl();
            Naming.bind("rmi://localhost/michel", obj);
            System.out.println("L'objet est publié : " + obj);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
