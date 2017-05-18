package jedi.ex01.CSTS3.comm.ipop;


public class IP_QDB1004 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_QDB1004";

	public static final String instrument = "1";
	public static final String today = "2";
	public static final String limit = "3";

	public IP_QDB1004(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(IP_QDB1004.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(IP_QDB1004.instrument, instrument);
	}

	public boolean isToday() {
		try {
			boolean data=getEntryBoolean(IP_QDB1004.today);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToday(boolean today) {
		setEntry(IP_QDB1004.today, today);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(IP_QDB1004.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(IP_QDB1004.limit, limit);
	}


}