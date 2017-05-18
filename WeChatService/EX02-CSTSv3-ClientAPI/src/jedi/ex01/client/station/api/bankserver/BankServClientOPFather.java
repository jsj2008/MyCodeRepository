package jedi.ex01.client.station.api.bankserver;

import java.util.HashMap;

public class BankServClientOPFather extends BankServOPFather {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8393470760621164629L;

	public BankServClientOPFather() {
		super();
	}

	// public BankServClientOPFather(BankServIPFather ip) {
	// super(ip);
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
