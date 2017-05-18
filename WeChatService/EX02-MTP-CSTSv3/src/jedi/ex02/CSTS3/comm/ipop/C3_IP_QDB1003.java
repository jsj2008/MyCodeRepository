package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.quoteDB.comm.IPOP.IP_QDB1003;


public class C3_IP_QDB1003 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_QDB1003";

	public static final String instrument = "1";
	public static final String cycle = "2";
	public static final String limit = "3";
	public static final String endTime = "4";

	public C3_IP_QDB1003(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_QDB1003 formatIP() {
		IP_QDB1003 ip=new IP_QDB1003();
		ip.setInstrument(getInstrument());
		ip.setCycle(getCycle());
		ip.setLimit(getLimit());
		ip.setEndTime(getEndTime());
		return ip;
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_IP_QDB1003.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_IP_QDB1003.instrument, instrument);
	}

	public int getCycle() {
		try {
			int data=getEntryInt(C3_IP_QDB1003.cycle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCycle(int cycle) {
		setEntry(C3_IP_QDB1003.cycle, cycle);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(C3_IP_QDB1003.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(C3_IP_QDB1003.limit, limit);
	}

	public long getEndTime() {
		try {
			long data=getEntryLong(C3_IP_QDB1003.endTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setEndTime(long endTime) {
		setEntry(C3_IP_QDB1003.endTime, endTime);
	}


}