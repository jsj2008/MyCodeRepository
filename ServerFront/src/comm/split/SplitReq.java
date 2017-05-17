package comm.split;

import java.io.Serializable;
import java.security.SecureRandom;

public class SplitReq implements Serializable {
	private static final long serialVersionUID = 1627897613505346517L;

	private String _HashID;
	private String guid;
	private int index;

	public SplitReq() {
		SecureRandom sr = new SecureRandom();
		_HashID = (new StringBuilder(String.valueOf(Long.toHexString(System.currentTimeMillis() % 10000000L)))).append("_").append(Long.toHexString(hashCode())).append("_")
				.append(Integer.toHexString(sr.nextInt())).toString().toUpperCase();
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public String get_HashID() {
		return _HashID;
	}

}
