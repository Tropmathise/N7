/** Fonctionnement :
 * les 3 fichiers texts sont fournis sous le nom :
 * 1_fichtest 2_fichtest et 3_fichtest
 * lancez MyMapreduce sur le fichier fichtest.txt
 * 4 fichiers sont créés :
 * res_fichtest, res_1_fichtest, res_2_fichtest, et res_3_fichtest
 * recombiner à la main les 3 fichiers "res_i" dans le fichier global "res"
 */

package ordo;

import java.io.File;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.Socket;
import java.rmi.Naming;
import java.rmi.RemoteException;
import formats.Format;
import formats.KVFormat;
import formats.LineFormat;
import hdfs.Commandes.CommandeCmd;
import hdfs.HdfsClient;
import map.MapReduce;
import java.util.ArrayList;
import java.util.List;
import java.rmi.registry.*;

public class Job implements JobInterface {

	private int nbMaps;
	private Format.Type inputFormat;
	private String inputFname;
	private List<String> machines; // différentes machines de tests des maps
    private int nbReduces;
    
    //HdfsServeurs
    private static String nodes[] = {"rattata.enseeiht.fr", "roucool.enseeiht.fr", "rondoudou.enseeiht.fr"};
	private static int ports[] = {8080,8080,8080};
	private static int portsWorkers[] = {8081,8082,8083};
	private static int nbNodes = nodes.length;

	public Job() {
		this.initMachines();
		this.nbMaps = machines.size();
		this.nbReduces = 1; 
	}
	
	//machine de test
	public void initMachines(){
    	this.machines = new ArrayList<String>();
    	for (int i=1; i<=nbNodes; i++) {
			machines.add("machines"+String.valueOf(i));
		}
	}
	
	@Override
    public void setInputFormat(Format.Type ft){
    	this.inputFormat = ft;
    }
		
	@Override
    public void setInputFname(String fname){
    	this.inputFname = fname;
    }
	
	@Override
    public void startJob (MapReduce mr) {

		System.out.println("START JOB ");

		System.out.println("Récupération de la liste des Workers");
    	List<Worker> worker = new ArrayList<>();
    	for(int i = 0; i < this.nbMaps; i++) {
    		try {
				worker.add((Worker) Naming.lookup("//"+nodes[i]+":"+portsWorkers[i]+"/Worker" + machines.get(i)));
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
    	System.out.println("Recup finie\n");

		//callback
		CallBack callback = null;
		try {
			callback = new CallBackImpl();
		} catch (RemoteException e) {
			e.printStackTrace();
		}

		//runmap
		System.out.println("Maps en cours ");
		for(int i = 0; i < this.nbMaps; i++) {
			try{ 
				Socket socket = new Socket(nodes[i], ports[i]);
				
				OutputStream os = socket.getOutputStream();
				InputStream is = socket.getInputStream();
				
				ObjectOutputStream oos = new ObjectOutputStream (os);
				ObjectInputStream ois = new ObjectInputStream (is);
				
				oos.writeObject(CommandeCmd.CMD_MAP);
				oos.writeObject(inputFname);
				oos.writeObject(inputFormat);
				Format formatRead = (Format) ois.readObject();
				Format formatWrite = (Format) ois.readObject();
				
				boolean end = (boolean) ois.readObject();
				
				oos.close();
				os.close();
				ois.close();
				is.close();
				socket.close();
				
				Worker workeri = worker.get(i);
				MapThread mapThread = new MapThread(workeri, mr, formatRead, formatWrite, callback);
				mapThread.start();
			} catch (Exception e) {
	    		System.out.println("Une erreur s'est produite");
	    		e.printStackTrace();
	    	}  
		}
    	System.out.println("Maps finis\n");

    	System.out.println("Attente de la confirmation des Workers ");
		try {
			callback.waitMaps(nbMaps);
	    	System.out.println("Attente Worker finie\n");
	
	    	String fRecomposeName = "./job/recompose_"+ inputFname+".txt";
	    	String fResName = "./job/res_"+ inputFname+".txt";
	    	
	    	HdfsClient Hdfs = new HdfsClient();
	    	HdfsClient.HdfsRead("tmp", fRecomposeName);
	    	
	    	File myFile = new File(fResName);
			myFile.getParentFile().mkdirs();
			myFile.createNewFile();
	
			Format formatWriter = new KVFormat(fResName);
			Format formatReader = new KVFormat(fRecomposeName);
			
			formatWriter.open(Format.OpenMode.W);
			formatReader.open(Format.OpenMode.R);
	
	    	System.out.println("REDUCE");
			mr.reduce(formatReader, formatWriter);
	    	System.out.println("Reduce fini\n");
	    	
	    	HdfsClient.HdfsDelete("tmp");
			
			formatReader.close();
			formatWriter.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
