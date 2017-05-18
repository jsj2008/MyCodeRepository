package jedi.ex01.CSTS3.comm.ipop;


public class IP_QDB1003 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_QDB1003";

	public static final String instrument = "1";
	public static final String cycle = "2";
	public static final String limit = "3";
	public static final String endTime = "4";

	public IP_QDB1003(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(IP_QDB1003.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(IP_QDB1003.instrument, instrument);
	}

	public int getCycle() {
		try {
			int data=getEntryInt(IP_QDB1003.cycle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCycle(int cycle) {
		setEntry(IP_QDB1003.cycle, cycle);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(IP_QDB1003.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(IP_QDB1003.limit, limit);
	}

	public long getEndTime() {
		try {
			long data=getEntryLong(IP_QDB1003.endTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEndTime(long endTime) {
		setEntry(IP_QDB1003.endTime, endTime);
	}


}