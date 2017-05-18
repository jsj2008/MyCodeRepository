package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5103;


public class C3_IP_TRADESERV5103 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5103";

	public static final String accountID = "1";
	public static final String instrumentName = "2";
	public static final String buysell = "3";
	public static final String lots = "4";
	public static final String type = "5";
	public static final String limitprice = "6";
	public static final String oriStopprice = "7";
	public static final String stopGuaranteed = "8";
	public static final String stopMoveGap = "9";
	public static final String toOpenNew = "10";
	public static final String toCloseTickets = "11";
	public static final String expireTime = "12";
	public static final String iFDLimitPrice = "13";
	public static final String iFDStopPrice = "14";
	public static final String iFDStopGuaranteed = "15";
	public static final String accountDigist = "16";

	public C3_IP_TRADESERV5103(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5103 formatIP() {
		IP_TRADESERV5103 ip=new IP_TRADESERV5103();
		ip.setAccountID(getAccountID());
		ip.setInstrumentName(getInstrumentName());
		ip.setBuysell(getBuysell());
		ip.setLots(getLots());
		ip.setType(getType());
		ip.setLimitprice(getLimitprice());
		ip.setOriStopprice(getOriStopprice());
		ip.setStopGuaranteed(isStopGuaranteed());
		ip.setStopMoveGap(getStopMoveGap());
		ip.setToOpenNew(isToOpenNew());
		if(getToCloseTickets()!=null){
			for (String ticket : getToCloseTickets().split(";")) {
				if(ticket.trim().length()>0){
					ip.addTicketsToClose(Long.parseLong(ticket));
				}
			}
		}
		ip.setExpireTime(getExpireTime());
		ip.setIFDLimitPrice(getIFDLimitPrice());
		ip.setIFDStopPrice(getIFDStopPrice());
		ip.setIFDStopGuaranteed(isIFDStopGuaranteed());
		ip.setAccountDigist(getAccountDigist());
		return ip;
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5103.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5103.accountID, accountID);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5103.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(C3_IP_TRADESERV5103.instrumentName, instrumentName);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5103.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(C3_IP_TRADESERV5103.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5103.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_IP_TRADESERV5103.lots, lots);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5103.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_IP_TRADESERV5103.type, type);
	}

	public double getLimitprice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5103.limitprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitprice(double limitprice) {
		setEntry(C3_IP_TRADESERV5103.limitprice, limitprice);
	}

	public double getOriStopprice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5103.oriStopprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopprice(double oriStopprice) {
		setEntry(C3_IP_TRADESERV5103.oriStopprice, oriStopprice);
	}

	public boolean isStopGuaranteed() {
		try {
			boolean data=getEntryBoolean(C3_IP_TRADESERV5103.stopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setStopGuaranteed(boolean stopGuaranteed) {
		setEntry(C3_IP_TRADESERV5103.stopGuaranteed, stopGuaranteed);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5103.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(C3_IP_TRADESERV5103.stopMoveGap, stopMoveGap);
	}

	public boolean isToOpenNew() {
		try {
			boolean data=getEntryBoolean(C3_IP_TRADESERV5103.toOpenNew);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToOpenNew(boolean toOpenNew) {
		setEntry(C3_IP_TRADESERV5103.toOpenNew, toOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5103.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(C3_IP_TRADESERV5103.toCloseTickets, toCloseTickets);
	}

	public String getExpireTime() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5103.expireTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireTime(String expireTime) {
		setEntry(C3_IP_TRADESERV5103.expireTime, expireTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5103.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(C3_IP_TRADESERV5103.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5103.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(C3_IP_TRADESERV5103.iFDStopPrice, iFDStopPrice);
	}

	public boolean isIFDStopGuaranteed() {
		try {
			boolean data=getEntryBoolean(C3_IP_TRADESERV5103.iFDStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIFDStopGuaranteed(boolean iFDStopGuaranteed) {
		setEntry(C3_IP_TRADESERV5103.iFDStopGuaranteed, iFDStopGuaranteed);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5103.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(C3_IP_TRADESERV5103.accountDigist, accountDigist);
	}


}