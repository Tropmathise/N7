import java.util.Random;
import java.net.*;
import java.io.*;

public class LoadBalancer extends Thread {
	static String hosts[] = {"localhost", "localhost"};
	static int ports[] = {8081,8082};
	static int nbHosts = 2;
	static Random rand = new Random();
	Socket sClient;
	
	public LoadBalancer(Socket s) {
		this.sClient = s;
    }
    
	public void run() {
		try {
			System.out.println("Debut Load Blancing");
			
			// Recuperer la requete du Client
			OutputStream os = sClient.getOutputStream();
            InputStream is = sClient.getInputStream();
            byte[] rq = new byte[1024];
            is.read(rq);
            
            // Transmettre la requete vers une Comanche
			int i = rand.nextInt(nbHosts);
            Socket sComanche = new Socket(hosts[i], ports[i]);
            OutputStream osc = sComanche.getOutputStream();
            InputStream isc = sComanche.getInputStream();
            osc.write(rq);
            
            // Recuperer la reponse de la Comanche et la transmettre au client
            byte[] rep = new byte[1024];
            isc.read(rep);
            os.write(rep);
            
            os.close();
            is.close();
            osc.close();
            isc.close();
            sClient.close();
            sComanche.close();
            
            System.out.println("Fin Load Blancing");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
    public static void main(String args[]) {
    	
    	 try {
             ServerSocket ss = new ServerSocket(8080);

             while (true) {
                 Socket s = ss.accept();
                 System.out.println("Demande de connection");
                 
                 LoadBalancer t = new LoadBalancer(s);
                 t.start();
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
    }
}
