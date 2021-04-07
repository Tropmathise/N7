import java.rmi.*;
import java.rmi.registry.*;
import java.rmi.server.UnicastRemoteObject;
import java.util.*;

public class RE {

	public static void main(String args[]) {
		try {
			DaemonItf d = (DaemonItf)Naming.lookup("//"+args[0]+"/Daemon");
			d.invoke(args[1]);
			System.exit(0);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

