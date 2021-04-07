import java.net.*;
import java.io.*;
import java.util.*;

public class UsagerServer_i {

    final static String hosts[] = {"host1", "host2", "host3"};
    final static int ports[] = {8081,8082,8083};
    final static int nb = 3;
    static String document[] = new String[nb];

    public static void main(String args[]) {

        try {

            int i = Integer.parseInt(args[0]);

            ServerSocket ss = new ServerSocket(ports[i]);

            while (true) {
                Socket s = ss.accept();

                OutputStream os = s.getOutputStream();
                InputStream is = s.getInputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                ObjectInputStream ois = new ObjectInputStream(is);

                int frag = (int)ois.readObject();
                System.out.println("Le client me demande le fragment " + frag);
                oos.writeObject("Voici le fragment " + frag + " fourni par le serveur " + i);
                os.close();
                is.close();
                s.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}