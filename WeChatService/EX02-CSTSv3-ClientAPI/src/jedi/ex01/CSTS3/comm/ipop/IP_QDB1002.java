package jedi.ex01.CSTS3.comm.ipop;


public class IP_QDB1002 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_QDB1002";

	public static final String instrument = "1";
	public static final String cycle = "2";
	public static final String limit = "3";

	public IP_QDB1002(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(IP_QDB1002.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(IP_QDB1002.instrument, instrument);
	}

	public int getCycle() {
		try {
			int data=getEntryInt(IP_QDB1002.cycle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCycle(int cycle) {
		setEntry(IP_QDB1002.cycle, cycle);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(IP_QDB1002.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(IP_QDB1002.limit, limit);
	}


}