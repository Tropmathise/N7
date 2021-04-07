import java.rmi.*;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.*;
import java.util.*;

public class Console extends UnicastRemoteObject implements ConsoleItf {	
	
	public Console() throws RemoteException {
	}

	public void println(String s) throws RemoteException {
		System.out.println(s);
	}
	
}

