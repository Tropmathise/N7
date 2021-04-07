package tm;

import java.util.Iterator;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;


public class TMNoCC extends TMAbstract {

    private Map<String, Map<String, Integer>> oldVals;
    
    public TMNoCC(Map<String, Integer> map) {
        this(map, new HashSet<String>());
    }
    
    public TMNoCC(Map<String, Integer> t_objects, Set<String> transactions) {
        this.transactions = transactions;
        this.t_objects = t_objects;
        this.oldVals = new HashMap<String, Map<String, Integer>>();
        Iterator<String> iterator = this.transactions.iterator();
        while (iterator.hasNext()) {
            this.oldVals.put(iterator.next(), new HashMap<String, Integer>());
        }
    }
    
    private void remove(String transaction) {
        this.transactions.remove(transaction);
        this.oldVals.remove(transaction);
    }
    
    public boolean newTransaction(AbstractTransaction target) {
        if (this.transactions.contains(target.getName())) {
            return false;
        }
        this.transactions.add(target.getName());
        this.oldVals.put(target.getName(), new HashMap<String, Integer>());
        new Thread((Runnable)target).start();
        return true;
    }
    
    public int read(String transaction, String transaction2) throws AbortException {
        if (!this.oldVals.get(transaction).containsKey(transaction2)) {
            this.oldVals.get(transaction).put(transaction2, this.t_objects.get(transaction2));
        }
        return this.t_objects.get(transaction2);
    }
    
    public void write(String transaction, String transaction2, int i) throws AbortException {
        if (!this.oldVals.get(transaction).containsKey(transaction2)) {
            this.oldVals.get(transaction).put(transaction2, this.t_objects.get(transaction2));
        }
        this.t_objects.put(transaction2, i);
    }
    
    public void abort(String transaction) throws AbortException {
        for (String transaction2 : this.oldVals.get(transaction).keySet()) {
            this.t_objects.put(transaction2, this.oldVals.get(transaction).get(transaction2));
        }
        this.remove(transaction);
        throw new AbortException();
    }
    
    public void commit(String transaction) throws AbortException {
        this.remove(transaction);
    }
}