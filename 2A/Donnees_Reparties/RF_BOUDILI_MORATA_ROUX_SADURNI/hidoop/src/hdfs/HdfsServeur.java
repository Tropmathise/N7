package hdfs;

import java.io.File;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import formats.Format;
import formats.KV;
import formats.KVFormat;
import formats.LineFormat;
import hdfs.Commandes.CommandeCmd;
import formats.Format.OpenMode;

public class HdfsServeur extends Thread {

	private static int nbNode;
	
	private static Socket s;
	
	public HdfsServeur(int nb, Socket comSock) {
		nbNode = nb;
		s = comSock;
	}
	
	public void run() {
		try {
			System.out.println("		Demande de connection");
	        
			String repName = "./node"+nbNode+"/";
	        String fname;
	        String localfname;
	        int tailleChunk;
	        Format fm;
	        String formatType;
	        
	        InputStream is = s.getInputStream();
	        OutputStream os = s.getOutputStream();
	
	        ObjectInputStream ois = new ObjectInputStream (is);
	        ObjectOutputStream oos = new ObjectOutputStream (os);
	        
	        System.out.println("		Attente de commande");
	        CommandeCmd cmd = (CommandeCmd) ois.readObject();
	        
	        switch (cmd) {
	        case CMD_READ :
	        	System.out.println("		Demande de Lecture Client");
	        	fname = (String) ois.readObject();
	        	localfname = repName+fname+"_fmg.txt";
	        	formatType = (String) ois.readObject();
		    	switch (formatType) {
			    	case "KV" :
			    		fm = new KVFormat(localfname);
			    		break;
			    	case "LINE" :
			    		fm = new LineFormat(localfname);
			    		break;
			    	default :
			    		fm = null;
			    		break;
		    	}
		    	
		    	fm.open(OpenMode.R);
		    	tailleChunk = 0;
		    	while (fm.read() != null) {
		    		++tailleChunk;
		    	}
		    	fm.close();
		    	oos.writeObject(tailleChunk);
	
		    	fm.open(OpenMode.R);
		    	for (int j = 0; j < tailleChunk; j++) {
					KV kv = fm.read();
					oos.writeObject(kv.k);
					oos.writeObject(kv.v);
				}
		    	fm.close();
		    	oos.writeObject(true);
		    	break;
		    	
	        case CMD_WRITE :
	        	System.out.println("		Demande de Ecriture Client");
	    		fname = (String) ois.readObject();
	    		localfname = repName+fname+"_fmg.txt";
	    		File myFile = new File(localfname);
	    		myFile.getParentFile().mkdirs();
	    		myFile.createNewFile();
	    		
	    		formatType = (String) ois.readObject();
		    	switch (formatType) {
			    	case "KV" :
			    		fm = new KVFormat(localfname);
			    		break;
			    	case "LINE" :
			    		fm = new LineFormat(localfname);
			    		break;
			    	default :
			    		fm = null;
			    		break;
		    	}
		    	
		    	fm.open(OpenMode.W);
		    	tailleChunk = (int) ois.readObject();
		    	for (int j = 0; j < tailleChunk; j++) {
					KV kv = new KV();
					kv.k = (String) ois.readObject(); 
					kv.v = (String) ois.readObject();
					fm.write(kv);
				}
		    	
		    	fm.close();
		    	oos.writeObject(true);
		    	break;
		    	
	        case CMD_DELETE :
	        	System.out.println("		Demande de Suppression Client");
	        	fname = (String) ois.readObject();
	    		localfname = repName+fname+"_fmg.txt";
	    		File toDelete = new File(localfname);
	    		toDelete.delete();
	    		oos.writeObject(true);
	    		break;
	    		
	        case CMD_MAP :
	        	System.out.println("		Demande Map");
	        	fname = (String) ois.readObject();
	        	localfname = repName+fname+"_fmg.txt";
	        	Format.Type fmt = (Format.Type) ois.readObject();
		    	switch (fmt) {
			    	case KV :
			    		fm = new KVFormat(localfname);
			    		break;
			    	case LINE :
			    		fm = new LineFormat(localfname);
			    		break;
			    	default :
			    		fm = null;
			    		break;
		    	}
		    	oos.writeObject(fm);
		    	
		    	String tmpName = repName+"tmp_fmg.txt";
		    	File tmpFile = new File(tmpName);
		    	tmpFile.getParentFile().mkdirs();
		    	tmpFile.createNewFile();
		    	Format fmTmp = new KVFormat(tmpName);
		    	oos.writeObject(fmTmp);
		    	
		    	oos.writeObject(true);
		    	break;
	        }
	        System.out.println("		Fin Traitement Demande");
	        ois.close();
	        oos.close();
	        is.close();
	        os.close();
	        s.close();
		} catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public static void main(String args[]) {
    	
   	 try {
   		if (args.length<2) {
   			System.out.println("Usage : java HdfsServeur <nbNode> <port>");
   			return;
   		}
   		nbNode = Integer.parseInt(args[0]);
        ServerSocket ss = new ServerSocket(Integer.parseInt(args[1]));
        
        while (true) {
        	System.out.println("Attente de connection");
            Socket sock = ss.accept();
            
            System.out.println("Lancement Thread");
            Thread th = new HdfsServeur(nbNode, sock);
            th.start();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
   }
}
