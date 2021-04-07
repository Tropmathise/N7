package tm;

public interface TMInterface {

    // Renvoie false si la transaction existe.
    public boolean newTransaction(AbstractTransaction transaction);

    public int  read(String transaction, String t_object)
                    throws AbortException;

    // ecrit un t-objet pour une transaction.
    public void write(String transaction, String t_object, int value)
                    throws AbortException;

    // abandonne une transaction.
    public void abort(String transaction)
                    throws AbortException;

    // valide une transaction.
    public void commit(String transaction)
                    throws AbortException;

}
