package jedi.ex01.CSTS3.comm.ipop;


public class IP_TRADESERV5101 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5101";

	public static final String accountID = "1";
	public static final String instrumentName = "2";
	public static final String buySell = "3";
	public static final String lots = "4";
	public static final String price = "5";
	public static final String movedPrice = "6";
	public static final String mktPriceGap = "7";
	public static final String toOpenNew = "8";
	public static final String toCloseTickets = "9";
	public static final String orderType = "10";
	public static final String iFDStopPrice = "11";
	public static final String iFDLimitPrice = "12";
	public static final String iFDIsGuaranteed = "13";
	public static final String accountDigist = "14";
	public static final String expireTime = "15";
	public static final String orderID = "16";

	public IP_TRADESERV5101(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(IP_TRADESERV5101.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(IP_TRADESERV5101.accountID, accountID);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(IP_TRADESERV5101.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(IP_TRADESERV5101.instrumentName, instrumentName);
	}

	public int getBuySell() {
		try {
			int data=getEntryInt(IP_TRADESERV5101.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(IP_TRADESERV5101.buySell, buySell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(IP_TRADESERV5101.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(IP_TRADESERV5101.lots, lots);
	}

	public double getPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5101.price);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPrice(double price) {
		setEntry(IP_TRADESERV5101.price, price);
	}

	public double getMovedPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5101.movedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMovedPrice(double movedPrice) {
		setEntry(IP_TRADESERV5101.movedPrice, movedPrice);
	}

	public int getMktPriceGap() {
		try {
			int data=getEntryInt(IP_TRADESERV5101.mktPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMktPriceGap(int mktPriceGap) {
		setEntry(IP_TRADESERV5101.mktPriceGap, mktPriceGap);
	}

	public boolean isToOpenNew() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5101.toOpenNew);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToOpenNew(boolean toOpenNew) {
		setEntry(IP_TRADESERV5101.toOpenNew, toOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(IP_TRADESERV5101.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(IP_TRADESERV5101.toCloseTickets, toCloseTickets);
	}

	public int getOrderType() {
		try {
			int data=getEntryInt(IP_TRADESERV5101.orderType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderType(int orderType) {
		setEntry(IP_TRADESERV5101.orderType, orderType);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5101.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(IP_TRADESERV5101.iFDStopPrice, iFDStopPrice);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(IP_TRADESERV5101.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(IP_TRADESERV5101.iFDLimitPrice, iFDLimitPrice);
	}

	public boolean isIFDIsGuaranteed() {
		try {
			boolean data=getEntryBoolean(IP_TRADESERV5101.iFDIsGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIFDIsGuaranteed(boolean iFDIsGuaranteed) {
		setEntry(IP_TRADESERV5101.iFDIsGuaranteed, iFDIsGuaranteed);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(IP_TRADESERV5101.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(IP_TRADESERV5101.accountDigist, accountDigist);
	}

	public String getExpireTime() {
		try {
			String data=getEntryString(IP_TRADESERV5101.expireTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireTime(String expireTime) {
		setEntry(IP_TRADESERV5101.expireTime, expireTime);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(IP_TRADESERV5101.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(IP_TRADESERV5101.orderID, orderID);
	}


}