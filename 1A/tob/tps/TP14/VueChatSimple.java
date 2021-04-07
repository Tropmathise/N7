import java.util.Observable;
import java.util.Observer;

@SuppressWarnings("deprecation")
public class VueChatSimple implements Observer implements VueChat {

    public VueChatSimple(Chat chat) {
        chat.addObserver(this);
    }

    @Override
    public void update(Observable Chat, Object message) {
        System.out.println(message.toString());
    }
}