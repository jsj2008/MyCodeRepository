package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.quoteDB.comm.IPOP.IP_QDB1002;


public class C3_IP_QDB1002 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_QDB1002";

	public static final String instrument = "1";
	public static final String cycle = "2";
	public static final String limit = "3";

	public C3_IP_QDB1002(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_QDB1002 formatIP() {
		IP_QDB1002 ip=new IP_QDB1002();
		ip.setInstrument(getInstrument());
		ip.setCycle(getCycle());
		ip.setLimit(getLimit());
		return ip;
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_IP_QDB1002.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_IP_QDB1002.instrument, instrument);
	}

	public int getCycle() {
		try {
			int data=getEntryInt(C3_IP_QDB1002.cycle);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCycle(int cycle) {
		setEntry(C3_IP_QDB1002.cycle, cycle);
	}

	public int getLimit() {
		try {
			int data=getEntryInt(C3_IP_QDB1002.limit);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimit(int limit) {
		setEntry(C3_IP_QDB1002.limit, limit);
	}


}