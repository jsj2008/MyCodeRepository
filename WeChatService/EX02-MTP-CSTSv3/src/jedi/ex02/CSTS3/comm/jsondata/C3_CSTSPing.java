package jedi.ex02.CSTS3.comm.jsondata;

import allone.json.AbstractJsonData;

public class C3_CSTSPing extends AbstractJsonData{

	public static final String jsonId = "CSTSPing";

	public static final String startTime = "1";
	public static final String endTime = "2";
	public static final String serverDelay = "3";
	public static final String ID = "4";

	public C3_CSTSPing() {
		super();
		setEntry("jsonId", jsonId);
	}

	public String getID() {
		try {
			String data=getEntryString(C3_CSTSPing.ID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public long getStartTime() {
		try {
			Long data=getEntryLong(C3_CSTSPing.startTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStartTime(long startTime) {
		setEntry(C3_CSTSPing.startTime, startTime);
	}

	public long getServerDelay() {
		try {
			Long data=getEntryLong(C3_CSTSPing.serverDelay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setServerDelay(long serverDelay) {
		setEntry(C3_CSTSPing.serverDelay, serverDelay);
	}
	
}
