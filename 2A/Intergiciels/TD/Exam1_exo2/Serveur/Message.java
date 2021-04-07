import java.io.Serializable;

public class Message implements Serializable {
    public String text;

    public Message(String t) {
        text = t;
    }
}
