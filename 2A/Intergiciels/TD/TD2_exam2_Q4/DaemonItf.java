import java.rmi.*;

public interface DaemonItf extends Remote {
	public void invoke(String cmd, ConsoleItf cons) throws RemoteException;
}
