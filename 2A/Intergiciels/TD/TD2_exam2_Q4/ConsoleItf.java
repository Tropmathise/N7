import java.rmi.*;

public interface ConsoleItf extends Remote {
	public void println(String s) throws RemoteException;
}
