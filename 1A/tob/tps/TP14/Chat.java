import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Observable;
import java.util.Observer;
import java.util.Iterator;


public class Chat extends Observable implements Iterable<Message> {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		setChanged();
		this.notifyObservers(m);
	}

	public Iterator<Message> iterator() {
		return this.messages.iterator();
	}
}

