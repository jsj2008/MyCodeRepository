package jedi.ex01.CSTS3.comm.jsondata;

import java.util.UUID;

import allone.json.AbstractJsonData;

public class CSTSPing extends AbstractJsonData{

	public static final String jsonId = "CSTSPing";

	public static final String startTime = "1";
	public static final String endTime = "2";
	public static final String serverDelay = "3";
	public static final String ID = "4";

	public CSTSPing() {
		super();
		setEntry("jsonId", jsonId);
		setEntry(CSTSPing.ID, UUID.randomUUID().toString());
		setEntry(CSTSPing.startTime, System.currentTimeMillis());
	}

	public String getID() {
		try {
			String data=getEntryString(CSTSPing.ID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void pingReturned() {
		setEntry(CSTSPing.endTime, System.currentTimeMillis()+getServerDelay());
	}

	public long getPing() {
		return getEndTime() - getStartTime();
	}

	public long getStartTime() {
		try {
			Long data=getEntryLong(CSTSPing.startTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStartTime(long startTime) {
		setEntry(CSTSPing.startTime, startTime);
	}

	public long getEndTime() {
		try {
			Long data=getEntryLong(CSTSPing.endTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public long getServerDelay() {
		try {
			Long data=getEntryLong(CSTSPing.serverDelay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setServerDelay(long serverDelay) {
		setEntry(CSTSPing.serverDelay, serverDelay);
	}
	
}
