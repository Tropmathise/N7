package tm;

import java.util.Iterator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.Map;


public class TM2PL extends TMAbstract
{
    // Map qui associe chaque t_objet au verrou qui en protège l'accès.
    private Map<String, SharedLock> locks;
    // Map qui associe chaque transaction à son journal des valeurs avant.
    private Map<String, Map<String, Integer>> oldVals;
    // Map qui associe chaque transaction à l'ensemble des t_objects qu'elle a lus.
    private Map<String, Set<String>> readSets;
    // Map qui associe chaque transaction à l'ensemble des t_objects qu'elle a écrits.
    private Map<String, Set<String>> writeSets;

    
    public TM2PL(final Map<String, Integer> t_objects, final Set<String> transactions) {
        this.transactions = transactions;
        this.t_objects = t_objects;
        this.locks = new HashMap<String, SharedLock>();
        final Iterator<String> iterator = this.t_objects.keySet().iterator();
        while (iterator.hasNext()) {
            this.locks.put(iterator.next(), new SharedLock());
        }
        this.oldVals = new HashMap<String, Map<String, Integer>>();
        this.readSets = new HashMap<String, Set<String>>();
        this.writeSets = new HashMap<String, Set<String>>();
        for (String name : this.transactions) {
            this.oldVals.put(name, new HashMap<String, Integer>());
            this.readSets.put(name, new HashSet<String>());
            this.writeSets.put(name, new HashSet<String>());
        }
    }

    public TM2PL(final Map<String, Integer> t_objects) {
        this(t_objects, new HashSet<String>());
    }

    // Nettoie de la mémoire transactionnelle les valeurs liées à la transaction en argument.
    private void remove(String transaction) {
        this.transactions.remove(transaction);
        this.oldVals.remove(transaction);
        this.readSets.remove(transaction);
        this.writeSets.remove(transaction);
    }
    
    
    // Libère les verrous pris par une transaction 
    // et en nettoie les variables de la mémoire transactionnelle.
    private void unlock_all(String transaction) {
        Set<String> readWriteSet = new HashSet<String>(this.readSets.get(transaction));
        readWriteSet.addAll(this.writeSets.get(transaction));
        for (String t_object : readWriteSet) {
            locks.get(t_object).release(transaction);
        }
        this.remove(transaction);
    }
    
    public boolean newTransaction(final AbstractTransaction target) {
        if (this.transactions.contains(target.getName())) {
            return false;
        }
        this.transactions.add(target.getName());
        this.oldVals.put(target.getName(), new HashMap<String, Integer>());
        this.readSets.put(target.getName(), new HashSet<String>());
        this.writeSets.put(target.getName(), new HashSet<String>());
        new Thread((Runnable)target).start();
        return true;
    }
    
    public int read(String transaction, String transaction2) throws AbortException {
        Set<String> readWriteSet = new HashSet<String>(this.readSets.get(transaction));
        readWriteSet.addAll(this.writeSets.get(transaction));
        if (!readWriteSet.contains(transaction2)) {
            this.locks.get(transaction2).shared(transaction);
            this.readSets.get(transaction).add(transaction2);
        }
        return this.t_objects.get(transaction2);
    }
    
    public void write(String transaction, String transaction2, final int i) throws AbortException {
        if (!this.writeSets.get(transaction).contains(transaction2)) {
            this.locks.get(transaction2).exclusive(transaction);
            this.writeSets.get(transaction).add(transaction2);
            this.oldVals.get(transaction).put(transaction2, this.t_objects.get(transaction2));
        }
        this.t_objects.put(transaction2, i);
    }
    
    public void abort(String transaction) throws AbortException {
        System.out.println("Annulation des modifications de "+transaction+".");
        for (String str : this.writeSets.get(transaction)) {
            System.out.println(str + " " + this.oldVals.get(transaction).get(str));
            this.t_objects.put(str, this.oldVals.get(transaction).get(str));
        }
        System.out.println("Annulation terminée pour "+transaction+".");
        this.unlock_all(transaction);
        throw new AbortException();
    }
    
    public void commit(String transaction) throws AbortException {
        this.unlock_all(transaction);
    }
}