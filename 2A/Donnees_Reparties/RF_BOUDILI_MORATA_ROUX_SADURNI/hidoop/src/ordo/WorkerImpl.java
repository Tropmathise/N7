package ordo;

import java.net.InetAddress;
import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.*;
import java.rmi.server.UnicastRemoteObject;
import formats.Format;
import map.Mapper;


public class WorkerImpl extends UnicastRemoteObject implements Worker {

	private static final long serialVersionUID = 1L;
	
	private String name;
	
	protected WorkerImpl(String name) throws RemoteException {
		super();
		this.name = name;
		System.out.println("Création du Worker " + this.name);
	}

	@Override
	public void runMap(Mapper m, Format reader, Format writer, CallBack cb) throws RemoteException {
		
		//ouverture
		reader.open(Format.OpenMode.R);
		writer.open(Format.OpenMode.W);

		//runmap
		System.out.println(" ~ RUNMAP ~ ");
		m.map(reader, writer);
		System.out.println("RUNMAP fini");

		//fermeture
		reader.close();
		writer.close();

		//callback pour information
		try {
			cb.finishedMaps();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	private static void usage() {
		System.out.println("Usage: Dans 3 terminaux différents tapez :");
		System.out.println("Usage: java WorkerImpl test1 port");
		System.out.println("Usage: java WorkerImpl test2 port");
		System.out.println("Usage: java WorkerImpl test3 port");
	}
	
	public static void main(String args[]) {
		try {
			if (args.length!=2) {usage(); return;}
			// création du worker avec un nom et un port en argument
			Worker worker = new WorkerImpl(args[0]);
			String port = args[1];
            System.out.println("URL : //"+InetAddress.getLocalHost().getHostName()+":" + port + "/Worker" + ((WorkerImpl) worker).getName());
	    	Registry registry = LocateRegistry.createRegistry(Integer.valueOf(port));	
            registry.rebind("Worker" + ((WorkerImpl) worker).getName(), worker);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
