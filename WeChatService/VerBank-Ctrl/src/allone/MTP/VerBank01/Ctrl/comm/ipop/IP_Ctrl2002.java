package allone.MTP.VerBank01.Ctrl.comm.ipop;

import java.util.HashSet;
import java.util.Locale;

/**
 * 查询用户其他配置
 * @author admin
 *
 */
public class IP_Ctrl2002 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5793154388159210641L;
	private Locale locale=null;
	private HashSet<String> keySet = new HashSet<String>();
	private byte[] digist;
	public Locale getLocale() {
		return locale;
	}
	public void setLocale(Locale locale) {
		this.locale = locale;
	}
	
	public String[] getKeys() {
		return keySet.toArray(new String[0]);
	}
	
	public void addKey(String key) {
		keySet.add(key);
	}
	
	public void addKeys(String[] keys) {
		for (int i = 0; i < keys.length; i++) {
			addKey(keys[i]);
		}
	}
	
	public byte[] getDigist() {
		return digist;
	}
	public void setDigist(byte[] digist) {
		this.digist = digist;
	}
	
	
}
