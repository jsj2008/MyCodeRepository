package jedi.ex01.client.station.api.bankserver;

import java.util.HashMap;

public class BankServClientIPFather extends BankServIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3750218846907670807L;
	// private long streamID;
	// private String aeid;
	// private String password;
	// private long account;
	//
	// public long getStreamID() {
	// return streamID;
	// }
	//
	// public void setStreamID(long streamID) {
	// this.streamID = streamID;
	// }
	//
	// public String getAeid() {
	// return aeid;
	// }
	//
	// public void setAeid(String aeid) {
	// this.aeid = aeid;
	// }
	//
	// public String getPassword() {
	// return password;
	// }
	//
	// public void setPassword(String password) {
	// this.password = password;
	// }
	//
	// public long getAccount() {
	// return account;
	// }
	//
	// public void setAccount(long account) {
	// this.account = account;
	// }

	private HashMap<String, String> otherInfo;

	public String getOtherInfo(String key) {
		if (otherInfo != null) {
			return otherInfo.get(key);
		}
		return null;
	}

	public void setOtherInfo(String key, String value) {
		if (otherInfo == null) {
			otherInfo = new HashMap<String, String>();
		}
		otherInfo.put(key, value);
	}

	public HashMap<String, String> getOtherInfo() {
		return otherInfo;
	}

}
