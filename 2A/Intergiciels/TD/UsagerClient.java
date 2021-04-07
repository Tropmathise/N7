import java.net.*;
import java.io.*;
import java.util.*;

public class UsagerClient extends Thread {

    final static String hosts[] = {"localhost", "localhost", "localhost"};
    final static int ports[] = {8081,8082,8083};
    final static int nb = 3;
    static String document[] = new String[nb];
    int frag;


    public UsagerClient(int i) {
        frag = i;
    }


    public void run() {
        try {
            Socket s = new Socket(hosts[frag], ports[frag]);

            OutputStream os = s.getOutputStream();
            InputStream is = s.getInputStream();
            ObjectOutputStream oos = new ObjectOutputStream(os);
            ObjectInputStream ois = new ObjectInputStream(is);

            oos.writeObject(frag);
            document[frag] = (String)ois.readObject();
            os.close();
            is.close();
            s.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[]) {

        try {

            Thread t[] = new Thread[nb];

            for (int i = 0; i < nb; i++) {
                t[i] = new UsagerClient(i);
                t[i].start();
            }

            for (int i = 0; i < nb; i++) {
                t[i].join();
                System.out.println("thread " + i + " termine");
            }

            for (int i = 0; i < nb; i++) {
                System.out.println(document[i]);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}