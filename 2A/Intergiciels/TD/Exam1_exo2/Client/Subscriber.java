import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;

public class Subscriber extends UnicastRemoteObject implements CallBack {

    public Subscriber() throws RemoteException {
    }

    public void onMessage(Message message) throws RemoteException {
        System.out.println("Nouveau message sur le topic : " + message.text);
    }

    public static void main(String[] args) {
        try {
            MOM mom = (MOM)Naming.lookup("//localhost:4000/mom");
            mom.subscribe(args[0], new Subscriber());
            System.out.println("Vous avez souscrit au topic " + args[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
