package hdfs;

import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Hashtable;

import hdfs.Commandes.CommandeNameNode;

public class NameNode {
	
	private static Hashtable<String, String> table;
	
	public static void main(String args[]) {
    	
	   	 try {
	   		if (args.length<1) {
	   			System.out.println("Usage : java NameNode <port>");
	   			return;
	   		}
	   	    
	   		table = new Hashtable<String, String>();
	   		
	   		ServerSocket ss = new ServerSocket(Integer.parseInt(args[0]));
	   		
	   		while (true) {
	        	System.out.println("Attente de connection");
	            Socket s = ss.accept();
	            System.out.println("Demande de connection");
	            
	            InputStream is = s.getInputStream();
	            OutputStream os = s.getOutputStream();

	            ObjectInputStream ois = new ObjectInputStream (is);
	            ObjectOutputStream oos = new ObjectOutputStream (os);
	            
	            System.out.println("Attente de commande");
	            CommandeNameNode cmd = (CommandeNameNode) ois.readObject();
	            
	            String key;
	            String value;
	            switch (cmd) {
	            case NM_ADD :
	            	System.out.println("Ajout fichier");
	            	key = (String) ois.readObject();
	            	value = (String) ois.readObject();
	            	table.put(key, value);
	            	oos.writeObject(true);
	    	    	break;
	            case NM_GET :
	            	System.out.println("Demande format fichier");
	            	key = (String) ois.readObject();
	            	value = table.get(key);
	            	oos.writeObject(value);
	            	oos.writeObject(true);
	    	    	break;
	            case NM_DELETE :
	            	System.out.println("Suppression fichier");
	            	key = (String) ois.readObject();
	            	table.remove(key);
	            	oos.writeObject(true);
	    	    	break;
	            case NM_CONTAINS :
	            	System.out.println("Demande existence fichier");
	            	key = (String) ois.readObject();
	            	oos.writeObject(table.containsKey(key));
	            	oos.writeObject(true);
	    	    	break;
	            }
		   		System.out.println("Fin Traitement Demande");
	            ois.close();
	            oos.close();
	            is.close();
	            os.close();
	            s.close();
	        }
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}
}
