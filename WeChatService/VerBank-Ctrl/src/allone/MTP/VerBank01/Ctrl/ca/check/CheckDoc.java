package allone.MTP.VerBank01.Ctrl.ca.check;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserCertState;

public class CheckDoc {
	
	private static CheckDoc instance=new CheckDoc();

	private Map<String, UserCertState> checked = new ConcurrentHashMap<String, UserCertState>();
	
	
	public boolean init() {
		return false;
	}
	
	public void destroy() {
		checked.clear();
	}
	
	public boolean isChecked(String aeid) {
		return checked.containsKey(aeid);
	}
	
	public void clear() {
		checked.clear();
	}
	
	public void setChecked(String aeid, UserCertState ucs) {
		checked.put(aeid, ucs);
	}
	
	public UserCertState get(String aeid) {
		return checked.get(aeid);
	}

	public static CheckDoc getInstance() {
		return instance;
	}
}
