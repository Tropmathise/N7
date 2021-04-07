/* une PROPOSITION de squelette, incomplète et adaptable... */

package hdfs;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.ObjectInputStream;
import java.io.InputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.Socket;
import java.util.Hashtable;
import java.util.Scanner;

import formats.Format;
import formats.Format.OpenMode;
import formats.KV;
import formats.KVFormat;
import formats.LineFormat;
import hdfs.Commandes.CommandeCmd;
import hdfs.Commandes.CommandeNameNode;

public class HdfsClient {

	//HdfsServeurs
    private static String nodes[] = {"rattata.enseeiht.fr", "roucool.enseeiht.fr", "rondoudou.enseeiht.fr"};
	private static int ports[] = {8080,8080,8080};
	private static int nbNodes = nodes.length;
	
	//NameNode
	private static String nameNode = "localhost";
	private static int portsNameNode = 8080;
	
    private static void usage() {
        System.out.println("Usage: java HdfsClient read <filename> <filepath>");
        System.out.println("Usage: java HdfsClient write <line|kv> <filename> <filepath>");
        System.out.println("Usage: java HdfsClient delete <filename>");
    }
    
    public HdfsClient() {
    	try {
	    	Socket socket = new Socket(nameNode, portsNameNode);
			OutputStream os = socket.getOutputStream();
			InputStream is = socket.getInputStream();
			
		ObjectOutputStream oos = new ObjectOutputStream (os);
			ObjectInputStream ois = new ObjectInputStream (is);
			
    		oos.writeObject(CommandeNameNode.NM_ADD);
    		oos.writeObject("tmp");	
    		oos.writeObject("KV");
    		boolean endAdd = (boolean) ois.readObject();
    		
	    	oos.close();
			os.close();
			ois.close();
			is.close();
			socket.close();
    	} catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    public static void HdfsDelete(String hdfsFname) {
    	try {
    		Socket socketN = new Socket(nameNode, portsNameNode);
			OutputStream osN = socketN.getOutputStream();
			InputStream isN = socketN.getInputStream();
			
			ObjectOutputStream oosN = new ObjectOutputStream (osN);
			ObjectInputStream oisN = new ObjectInputStream (isN);
			
			oosN.writeObject(CommandeNameNode.NM_CONTAINS);
			oosN.writeObject(hdfsFname);
			
			if ((boolean) oisN.readObject()) {
	    		boolean endContains = (boolean) oisN.readObject();
		    	for (int i = 0; i < nbNodes; i++) {
		    		oosN.close();
					osN.close();
					oisN.close();
					isN.close();
					socketN.close();
	    			// Envoi de l'ordre de supression au serveur
					Socket socket = new Socket(nodes[i], ports[i]);
					OutputStream os = socket.getOutputStream();
					InputStream is = socket.getInputStream();
					
					ObjectOutputStream oos = new ObjectOutputStream (os);
					ObjectInputStream ois = new ObjectInputStream (is);
					oos.writeObject(CommandeCmd.CMD_DELETE);
					oos.writeObject(hdfsFname);	
					
					boolean answer = (boolean) ois.readObject();
					if (answer) { //suppression réussie
						
					} else { //échec de la suppression
						System.out.print("Le fichier correspondant n'a pas pu être supprimé sur le serveur ");
						System.out.print(i);
						
						oos.close();
						os.close();
						ois.close();
						is.close();
						socket.close();
						
						throw(new Exception());
					}
					
					oos.close();
					os.close();			
					ois.close();
					is.close();
					socket.close();
					
					socketN = new Socket(nameNode, portsNameNode);
					osN = socketN.getOutputStream();
					isN = socketN.getInputStream();
					oosN = new ObjectOutputStream (osN);
					oisN = new ObjectInputStream (isN);
					
					oosN.writeObject(CommandeNameNode.NM_DELETE);
					oosN.writeObject(hdfsFname);
					boolean endDelete = (boolean) oisN.readObject();
					
					oosN.close();
					osN.close();
					oisN.close();
					isN.close();
					socketN.close();
		    	}
	    	} else {
	    		System.out.println("Le fichier que vous essayez de supprimer n'existe pas");
	    	}
    	} catch (Exception ex) {
            ex.printStackTrace();
        }
    }
	
    public static void HdfsWrite(Format.Type fmt, String hdfsFname,String localFSSourceFname, 
     int repFactor) { 
    	try {
    		Socket socketN = new Socket(nameNode, portsNameNode);
			OutputStream osN = socketN.getOutputStream();
			InputStream isN = socketN.getInputStream();
			
			ObjectOutputStream oosN = new ObjectOutputStream (osN);
			ObjectInputStream oisN = new ObjectInputStream (isN);
			
			oosN.writeObject(CommandeNameNode.NM_CONTAINS);
			oosN.writeObject(hdfsFname);
			
			if (!(boolean) oisN.readObject()) {
	    		boolean endContains = (boolean) oisN.readObject();
	    		oosN.close();
				osN.close();
				oisN.close();
				isN.close();
				socketN.close();
				
		    	Format fm;
		    	String formatType = null;
		    	switch (fmt) {
			    	case KV :
			    		fm = new KVFormat(localFSSourceFname);
			    		formatType = "KV";
			    		break;
			    	case LINE :
			    		fm = new LineFormat(localFSSourceFname);
			    		formatType = "LINE";
			    		break;
			    	default :
			    		fm = null;
			    		break;
		    	}
		    	
		    	fm.open(OpenMode.R);
		    	int nbLines = 0;
		    	while (fm.read() != null) {
		    		++nbLines;
		    	}
		    	fm.close();
		    	
		    	int tailleChunk = (int) Math.ceil((float) nbLines/nbNodes);
		    	int diff = nbLines%nbNodes;
		    	fm.open(OpenMode.R);
		    	boolean endWrite;
		    	for (int i = 0; i < nbNodes; i++) {
					if (i == nbNodes - 1) {
						tailleChunk -= nbNodes - diff;
					}
					Socket socket = new Socket(nodes[i], ports[i]);
					OutputStream os = socket.getOutputStream();
					InputStream is = socket.getInputStream();
					
					ObjectOutputStream oos = new ObjectOutputStream (os);
					ObjectInputStream ois = new ObjectInputStream (is);
					oos.writeObject(CommandeCmd.CMD_WRITE);
					oos.writeObject(hdfsFname);
					oos.writeObject(formatType);
					oos.writeObject(tailleChunk);
		
					for (int j = 0; j < tailleChunk; j++) {
						KV kv = fm.read();
						oos.writeObject(kv.k);
						oos.writeObject(kv.v);
					}
					
					endWrite = (boolean) ois.readObject();
					
					ois.close();
					oos.close();
					is.close();
					os.close();
					socket.close();
		    	}
		    	fm.close();
	    	
		    	socketN = new Socket(nameNode, portsNameNode);
				osN = socketN.getOutputStream();
				isN = socketN.getInputStream();
				
				oosN = new ObjectOutputStream (osN);
				oisN = new ObjectInputStream (isN);
		    		
				oosN.writeObject(CommandeNameNode.NM_ADD);
				oosN.writeObject(hdfsFname);	
				oosN.writeObject(formatType);
				boolean endAdd = (boolean) oisN.readObject();
				
		    	oosN.close();
				osN.close();
				oisN.close();
				isN.close();
				socketN.close();
			} else {
	    		System.out.println("Un fichier existe déjà sous le même nom, veuillez choisir un autre nom pour le fichier à ajouter.");
	    	} 
    	} catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void HdfsRead(String hdfsFname, String localFSDestFname) {
    	try {
    		Socket socketN = new Socket(nameNode, portsNameNode);
			OutputStream osN = socketN.getOutputStream();
			InputStream isN = socketN.getInputStream();
			
			ObjectOutputStream oosN = new ObjectOutputStream (osN);
			ObjectInputStream oisN = new ObjectInputStream (isN);
			
			oosN.writeObject(CommandeNameNode.NM_CONTAINS);
			oosN.writeObject(hdfsFname);
			
			if ((boolean) oisN.readObject()) {
	    		boolean endContains = (boolean) oisN.readObject();
	    		oosN.close();
				osN.close();
				oisN.close();
				isN.close();
				socketN.close();
				
		    	// Creer le fichier
	    		File myFile = new File(localFSDestFname);
	    		myFile.getParentFile().mkdirs();
	    		if (myFile.createNewFile()) {
	    			System.out.println("Le fichier a été créé");
	    		} else {
	    			System.out.println("Erreur : Nom du fichier déjà existant");
	    			throw(new Exception());
	    		}
	    		
		    	// Recuperer le format
	    		socketN = new Socket(nameNode, portsNameNode);
				osN = socketN.getOutputStream();
				isN = socketN.getInputStream();
				oosN = new ObjectOutputStream (osN);
				oisN = new ObjectInputStream (isN);
				
	    		oosN.writeObject(CommandeNameNode.NM_GET);
	    		oosN.writeObject(hdfsFname);
	    		String formatType = (String) oisN.readObject();
	    		boolean endGet = (boolean) oisN.readObject();
	    		
	    		oosN.close();
				osN.close();
				oisN.close();
				isN.close();
				socketN.close();
				
		    	if (formatType == null) {
		    		System.out.println("Le fichier que vous essayez de lire n'existe pas");
		    		throw(new Exception());
		    	}
		    	Format fmt;
		    	switch (formatType) {
			    	case "KV" :
			    		fmt = new KVFormat(localFSDestFname);
			    		break;
			    	case "LINE" :
			    		fmt = new LineFormat(localFSDestFname);
			    		break;
			    	default :
			    		fmt = null;
			    		break;
		    	}
		    	// Parcourir les Nodes et écrire les fragments sur le fichier en utilisant format
		    	fmt.open(OpenMode.W);
		    	int tailleChunk;
		    	boolean endRead;
		    	for (int i = 0; i < nbNodes; i++) {
					Socket socket = new Socket(nodes[i], ports[i]);
					
					OutputStream os = socket.getOutputStream();
					InputStream is = socket.getInputStream();
					
					ObjectOutputStream oos = new ObjectOutputStream (os);
					ObjectInputStream ois = new ObjectInputStream (is);
					
					oos.writeObject(CommandeCmd.CMD_READ);
					oos.writeObject(hdfsFname);
					oos.writeObject(formatType);
					tailleChunk = (int) ois.readObject();
								
					for (int j = 0; j < tailleChunk; j++) {
						KV kv = new KV();
						kv.k = (String) ois.readObject(); 
						kv.v = (String) ois.readObject();
						fmt.write(kv);
					}
					
					endRead = (boolean) ois.readObject();
					
					oos.close();
					os.close();
					ois.close();
					is.close();
					socket.close();	
		    	}
		    	fmt.close();
	    	} else {
	    		System.out.println("Le fichier que vous essayez de lire n'existe pas");
	    	} 
    	} catch (Exception e) {
    		System.out.println("Une erreur est survenue");
    		e.printStackTrace();
    	}
    }

	
    public static void main(String[] args) {
        // java HdfsClient read <filename> <filepath>
    	// java HdfsClient write <line|kv> <filename> <filepath>
    	// java HdfsClient delete <filename>

        try {
            if (args.length<2) {usage(); return;}

            switch (args[0]) {
              case "read": 
            	  if (args.length<3) {usage(); return;}
            	  HdfsRead(args[1],args[2]); 
            	  break;
              case "delete": HdfsDelete(args[1]); break;
              case "write": 
                if (args.length<4) {usage(); return;}
                Format.Type fmt;
                if (args[1].equals("line")) fmt = Format.Type.LINE;
                else if(args[1].equals("kv")) fmt = Format.Type.KV;
                else {usage(); return;}
                HdfsWrite(fmt,args[2], args[3],1);
            }	
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
