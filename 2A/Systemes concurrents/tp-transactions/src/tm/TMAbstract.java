package tm;

import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;

public abstract class TMAbstract implements TMInterface {

    public Map<String,Integer> t_objects;

    public Set<String> transactions;

    public Set<String> getTransactions() {
        return new HashSet<String>(this.transactions);
    }

    public Map<String,Integer> getTObjects() {
        return new HashMap<String,Integer>(this.t_objects);
    }

}
