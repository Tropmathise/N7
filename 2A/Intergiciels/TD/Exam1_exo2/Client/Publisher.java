import java.rmi.*;

public class Publisher {

    public Publisher() {
    }

    public static void main(String[] args) {
        try {
            MOM mom = (MOM)Naming.lookup("//localhost:4000/mom");
            mom.publish(args[0], new Message("Hello Darkness my old friend")); // new Message(args[1]);
            System.out.println("Message publié sur le topic " + args[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
