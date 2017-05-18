package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5102;


public class C3_IP_TRADESERV5102 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5102";

	public static final String accountID = "1";
	public static final String instrument = "2";
	public static final String stickets = "3";
	public static final String antiTickets = "4";
	public static final String accountDigist = "5";

	public C3_IP_TRADESERV5102(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5102 formatIP() {
		IP_TRADESERV5102 ip=new IP_TRADESERV5102();
		ip.setAccountID(getAccountID());
		ip.setInstrument(getInstrument());
		if(getStickets()!=null){
			for (String ticket : getStickets().split(";")) {
				if(ticket.trim().length()>0){
					ip.addTicketsToClose(Long.parseLong(ticket));
				}
			}
		}
		if(getAntiTickets()!=null){
			for (String ticket : getAntiTickets().split(";")) {
				if(ticket.trim().length()>0){
					ip.addAntiTickets(Long.parseLong(ticket));
				}
			}
		}
		ip.setAccountDigist(getAccountDigist());
		return ip;
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5102.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5102.accountID, accountID);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5102.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_IP_TRADESERV5102.instrument, instrument);
	}

	public String getStickets() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5102.stickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStickets(String stickets) {
		setEntry(C3_IP_TRADESERV5102.stickets, stickets);
	}

	public String getAntiTickets() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5102.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(C3_IP_TRADESERV5102.antiTickets, antiTickets);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5102.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(C3_IP_TRADESERV5102.accountDigist, accountDigist);
	}


}