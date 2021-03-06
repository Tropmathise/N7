import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.*;
import java.util.*;

public class Daemon extends UnicastRemoteObject implements DaemonItf {	
	
	public Daemon() throws RemoteException {
	}

	private void localExec(String cmd, ConsoleItf cons) {
		try {
			cons.println("Execute: "+cmd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void invoke(String cmd, ConsoleItf cons) throws RemoteException {
		localExec(cmd, cons);
	}

	public static void main(String args[]) {
		try {
			//Registry registry = LocateRegistry.createRegistry(4000);
			Naming.rebind("//localhost:4000/Daemon", new Daemon());
			System.out.println("Daemon bound in registry");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

