package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5104;


public class C3_IP_TRADESERV5104 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5104";

	public static final String orderID = "1";
	public static final String accountID = "2";
	public static final String lots = "3";
	public static final String stopMoveGap = "4";
	public static final String limitprice = "5";
	public static final String oriStopprice = "6";
	public static final String expiryTime = "7";
	public static final String iFDLimitPrice = "8";
	public static final String iFDStopPrice = "9";
	public static final String iFDGuaranteeStop = "10";
	public static final String accountDigist = "11";

	public C3_IP_TRADESERV5104(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5104 formatIP() {
		IP_TRADESERV5104 ip=new IP_TRADESERV5104();
		ip.setOrderID(getOrderID());
		ip.setAccountID(getAccountID());
		ip.setLots(getLots());
		ip.setStopMoveGap(getStopMoveGap());
		ip.setLimitprice(getLimitprice());
		ip.setOriStopprice(getOriStopprice());
		ip.setExpiryTime(getExpiryTime());
		ip.setIFDLimitPrice(getIFDLimitPrice());
		ip.setIFDStopPrice(getIFDStopPrice());
		ip.setIFDGuaranteeStop(isIFDGuaranteeStop());
		ip.setAccountDigist(getAccountDigist());
		return ip;
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5104.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_IP_TRADESERV5104.orderID, orderID);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_IP_TRADESERV5104.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV5104.accountID, accountID);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5104.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_IP_TRADESERV5104.lots, lots);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5104.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(C3_IP_TRADESERV5104.stopMoveGap, stopMoveGap);
	}

	public double getLimitprice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5104.limitprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitprice(double limitprice) {
		setEntry(C3_IP_TRADESERV5104.limitprice, limitprice);
	}

	public double getOriStopprice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5104.oriStopprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopprice(double oriStopprice) {
		setEntry(C3_IP_TRADESERV5104.oriStopprice, oriStopprice);
	}

	public String getExpiryTime() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5104.expiryTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpiryTime(String expiryTime) {
		setEntry(C3_IP_TRADESERV5104.expiryTime, expiryTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5104.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(C3_IP_TRADESERV5104.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(C3_IP_TRADESERV5104.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(C3_IP_TRADESERV5104.iFDStopPrice, iFDStopPrice);
	}

	public boolean isIFDGuaranteeStop() {
		try {
			boolean data=getEntryBoolean(C3_IP_TRADESERV5104.iFDGuaranteeStop);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setIFDGuaranteeStop(boolean iFDGuaranteeStop) {
		setEntry(C3_IP_TRADESERV5104.iFDGuaranteeStop, iFDGuaranteeStop);
	}

	public String getAccountDigist() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5104.accountDigist);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountDigist(String accountDigist) {
		setEntry(C3_IP_TRADESERV5104.accountDigist, accountDigist);
	}


}