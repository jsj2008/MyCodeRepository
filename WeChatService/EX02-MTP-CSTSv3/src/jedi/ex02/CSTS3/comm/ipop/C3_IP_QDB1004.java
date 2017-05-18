package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.quoteDB.comm.IPOP.IP_QDB1004;


public class C3_IP_QDB1004 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_QDB1004";

	public static final String instrument = "1";
	public static final String today = "2";
	public static final String limit = "3";

	public C3_IP_QDB1004(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_QDB1004 formatIP() {
		IP_QDB1004 ip=new IP_QDB1004();
		ip.setInstrument(getInstrument());
		ip.setToday(isToday());
		ip.setLimit(getLimit());
		return ip;
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_IP_QDB1004.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_IP_QDB1004.instrument, instrument);
	}

	public boolean isToday() {
		try {
			boolean data=getEntryBoolean(C3_IP_QDB1004.today);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToday(boolean today) {
		setEntry(C3_IP_QDB1004.today, today);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(C3_IP_QDB1004.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(C3_IP_QDB1004.limit, limit);
	}


}