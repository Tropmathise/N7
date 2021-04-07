import java.rmi.*;
import java.io.*;

public interface MOM extends Remote {
    public void publish(String topic, Message message) throws RemoteException; // publie un message sur un topic
    public void subscribe(String topic, CallBack cb) throws RemoteException; // s'abonne à un topic
}
