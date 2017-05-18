package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5103 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

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

	public IP_TRADESERV5103(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5103.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5103.accountID, accountID);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(IP_TRADESERV5103.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(IP_TRADESERV5103.instrumentName, instrumentName);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(IP_TRADESERV5103.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(IP_TRADESERV5103.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(IP_TRADESERV5103.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(IP_TRADESERV5103.lots, lots);
	}

	public int getType() {
		try {
			int data=getEntryInt(IP_TRADESERV5103.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(IP_TRADESERV5103.type, type);
	}

	public double getLimitprice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5103.limitprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitprice(double limitprice) {
		setEntry(IP_TRADESERV5103.limitprice, limitprice);
	}

	public double getOriStopprice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5103.oriStopprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopprice(double oriStopprice) {
		setEntry(IP_TRADESERV5103.oriStopprice, oriStopprice);
	}

	public boolean isStopGuaranteed() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5103.stopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setStopGuaranteed(boolean stopGuaranteed) {
		setEntry(IP_TRADESERV5103.stopGuaranteed, stopGuaranteed);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(IP_TRADESERV5103.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(IP_TRADESERV5103.stopMoveGap, stopMoveGap);
	}

	public boolean isToOpenNew() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5103.toOpenNew);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToOpenNew(boolean toOpenNew) {
		setEntry(IP_TRADESERV5103.toOpenNew, toOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(IP_TRADESERV5103.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(IP_TRADESERV5103.toCloseTickets, toCloseTickets);
	}

	public String getExpireTime() {
		try {
			String data=getEntryString(IP_TRADESERV5103.expireTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireTime(String expireTime) {
		setEntry(IP_TRADESERV5103.expireTime, expireTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5103.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(IP_TRADESERV5103.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5103.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(IP_TRADESERV5103.iFDStopPrice, iFDStopPrice);
	}

	public boolean isIFDStopGuaranteed() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5103.iFDStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIFDStopGuaranteed(boolean iFDStopGuaranteed) {
		setEntry(IP_TRADESERV5103.iFDStopGuaranteed, iFDStopGuaranteed);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(IP_TRADESERV5103.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(IP_TRADESERV5103.accountDigist, accountDigist);
	}


}