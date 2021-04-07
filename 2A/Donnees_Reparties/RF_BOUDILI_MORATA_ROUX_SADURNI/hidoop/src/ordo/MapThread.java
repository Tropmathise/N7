package ordo;

import java.rmi.RemoteException;

import formats.Format;
import map.Mapper;

public class MapThread extends Thread {
	
	Worker worker; 
	Mapper m; 
	Format reader, writer; 
	CallBack cb;
	
	public MapThread(Worker worker, Mapper m, Format reader, Format writer, CallBack cb){
		this.worker = worker;
		this.m = m;
		this.reader = reader;
		this.writer = writer;
		this.cb = cb;
	}
	
	public void run() {
		try {
			this.worker.runMap(this.m, this.reader, this.writer, this.cb);
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		
	}
}
