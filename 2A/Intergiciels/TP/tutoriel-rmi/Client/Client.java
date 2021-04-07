import java.rmi.*;
import java.io.*;

public class Client {

    public static void main(String[] args) {

        try {
            ObjetDistant o = (ObjetDistant)Naming.lookup("//localhost/michel");
            System.out.println("Objet Distant = " + o);

            System.out.println("Random = " + o.getRandom());
            System.out.println("Nombre d'appels total = " + o.getCall());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
