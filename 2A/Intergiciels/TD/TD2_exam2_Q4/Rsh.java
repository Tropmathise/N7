import java.rmi.*;
import java.rmi.registry.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.*;

public class Rsh {	
	
	public static void main(String args[]) {
		try {
			DaemonItf d = (DaemonItf)Naming.lookup("//localhost:4000/Daemon");
			ConsoleItf c = new Console();
			d.invoke(args[0], c);
			System.exit(0);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

