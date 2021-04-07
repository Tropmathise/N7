import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.*;
import java.util.*;

public class MOMImpl extends UnicastRemoteObject implements MOM {

    public HashMap<String, Vector<CallBack>> subscribers;

    public MOMImpl() throws RemoteException {
        subscribers = new HashMap<String, Vector<CallBack>>();
    }

    public void publish(String topic, Message message) throws RemoteException { // publie un message sur un topic
        Vector<CallBack> vect = subscribers.get(topic);
        for (int i = 0; i < vect.size(); i++) {
            vect.get(i).onMessage(message);
        }
    }


    public void subscribe(String topic, CallBack cb) throws RemoteException { // s'abonne à un topic
        Vector<CallBack> vect = subscribers.get(topic);
        vect.add(cb);
    }

    public static void main(String[] args) {
        try {
            MOMImpl momImpl = new MOMImpl();
            for (int i = 0; i < args.length; i++) {
                System.out.println("Ajout du topic " + args[i]);
                momImpl.subscribers.put(args[i], new Vector<CallBack>());
            }

            // Création du registre pour ne pas avoir à faire rmiregistry
            Registry registry = LocateRegistry.createRegistry(4000);
            Naming.bind("//localhost:4000/mom", momImpl); // rebind marcherait aussi
            System.out.println("L'objet " + momImpl + " est publié dans le registre.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
