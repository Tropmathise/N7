import java.rmi.*;
import java.io.*;

public class Client {

    public static void main(String[] args) {
        try {
            NombreAleatoireGeneratorInterface georges = (NombreAleatoireGeneratorInterface)Naming.lookup("//localhost/nagi");
            System.out.println("Georges = " + georges);

            for (int i = 0; i < 10; i++) {
                System.out.println("Random[" + i + "] =" + georges.getRandom());
            }

            System.out.println("Nombre d'appels total = " + georges.getNombreAppels());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
