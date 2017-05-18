package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5101;

public class C3_IP_TRADESERV5101 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

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
	public static final String amount = "17";
	public static final String limitPriceRatio = "18";
	public static final String stopPriceRatio = "19";

	public C3_IP_TRADESERV5101() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5101 formatIP() {
		IP_TRADESERV5101 ip = new IP_TRADESERV5101();
		ip.setAccountID(getAccountID());
		ip.setInstrumentName(getInstrumentName());
		ip.setBuySell(getBuySell());
		ip.setLots(getLots());
		ip.setPrice(getPrice());
		ip.setMovedPrice(getMovedPrice());
		ip.setMktPriceGap(getMktPriceGap());
		ip.setToOpenNew(isToOpenNew());
		if (getToCloseTickets() != null) {
			for (String ticket : getToCloseTickets().split(";")) {
				if (ticket.trim().length() > 0) {
					ip.addTicketsToClose(Long.parseLong(ticket));
				}
			}
		}
		ip.setOrderType(getOrderType());
		ip.setIFDStopPrice(getIFDStopPrice());
		ip.setIFDLimitPrice(getIFDLimitPrice());
		ip.setIFDIsGuaranteed(isIFDIsGuaranteed());
		ip.setAccountDigist(getAccountDigist());
		ip.setExpireTime(getExpireTime());
		ip.setOrderID(getOrderID());
		ip.setAmount(getAmount());
		ip.setLimitPriceRatio(getLimitPriceRatio());
		ip.setStopPriceRatio(getStopPriceRatio());
		return ip;
	}

	public long getAccountID() {
		try {
			long data = getEntryLong(C3_IP_TRADESERV5101.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5101.accountID, accountID);
	}

	public String getInstrumentName() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5101.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(C3_IP_TRADESERV5101.instrumentName, instrumentName);
	}

	public int getBuySell() {
		try {
			int data = getEntryInt(C3_IP_TRADESERV5101.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(C3_IP_TRADESERV5101.buySell, buySell);
	}

	public double getLots() {
		try {
			double data = getEntryDouble(C3_IP_TRADESERV5101.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_IP_TRADESERV5101.lots, lots);
	}

	public double getPrice() {
		try {
			double data = getEntryDouble(C3_IP_TRADESERV5101.price);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPrice(double price) {
		setEntry(C3_IP_TRADESERV5101.price, price);
	}

	public double getMovedPrice() {
		try {
			double data = getEntryDouble(C3_IP_TRADESERV5101.movedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMovedPrice(double movedPrice) {
		setEntry(C3_IP_TRADESERV5101.movedPrice, movedPrice);
	}

	public int getMktPriceGap() {
		try {
			int data = getEntryInt(C3_IP_TRADESERV5101.mktPriceGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMktPriceGap(int mktPriceGap) {
		setEntry(C3_IP_TRADESERV5101.mktPriceGap, mktPriceGap);
	}

	public boolean isToOpenNew() {
		try {
			boolean data = getEntryBoolean(C3_IP_TRADESERV5101.toOpenNew);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setToOpenNew(boolean toOpenNew) {
		setEntry(C3_IP_TRADESERV5101.toOpenNew, toOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5101.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(C3_IP_TRADESERV5101.toCloseTickets, toCloseTickets);
	}

	public int getOrderType() {
		try {
			int data = getEntryInt(C3_IP_TRADESERV5101.orderType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderType(int orderType) {
		setEntry(C3_IP_TRADESERV5101.orderType, orderType);
	}

	public double getIFDStopPrice() {
		try {
			double data = getEntryDouble(C3_IP_TRADESERV5101.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(C3_IP_TRADESERV5101.iFDStopPrice, iFDStopPrice);
	}

	public double getIFDLimitPrice() {
		try {
			double data = getEntryDouble(C3_IP_TRADESERV5101.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(C3_IP_TRADESERV5101.iFDLimitPrice, iFDLimitPrice);
	}

	public boolean isIFDIsGuaranteed() {
		try {
			boolean data = getEntryBoolean(C3_IP_TRADESERV5101.iFDIsGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIFDIsGuaranteed(boolean iFDIsGuaranteed) {
		setEntry(C3_IP_TRADESERV5101.iFDIsGuaranteed, iFDIsGuaranteed);
	}

	public String getAccountDigist() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5101.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(C3_IP_TRADESERV5101.accountDigist, accountDigist);
	}

	public String getExpireTime() {
		try {
			String data = getEntryString(C3_IP_TRADESERV5101.expireTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireTime(String expireTime) {
		setEntry(C3_IP_TRADESERV5101.expireTime, expireTime);
	}

	public long getOrderID() {
		try {
			long data = getEntryLong(C3_IP_TRADESERV5101.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_IP_TRADESERV5101.orderID, orderID);
	}

	public double getAmount() {
		try {
			return getEntryDouble(C3_IP_TRADESERV5101.amount);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_IP_TRADESERV5101.amount, amount);
	}

	public double getLimitPriceRatio() {
		try {
			return getEntryDouble(C3_IP_TRADESERV5101.limitPriceRatio);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPriceRatio(double limitPriceRatio) {
		setEntry(C3_IP_TRADESERV5101.limitPriceRatio, limitPriceRatio);
	}

	public double getStopPriceRatio() {
		try {
			return getEntryDouble(C3_IP_TRADESERV5101.stopPriceRatio);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopPriceRatio(double stopPriceRatio) {
		setEntry(C3_IP_TRADESERV5101.stopPriceRatio, stopPriceRatio);
	}
}