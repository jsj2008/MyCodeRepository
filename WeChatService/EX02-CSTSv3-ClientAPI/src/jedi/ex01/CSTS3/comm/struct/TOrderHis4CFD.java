package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class TOrderHis4CFD extends allone.json.AbstractJsonData {

	public static final String jsonId = "21";

	public static final String orderID = "1";
	public static final String osplitNo = "2";
	public static final String account = "3";
	public static final String instrument = "4";
	public static final String buySell = "5";
	public static final String lots = "6";
	public static final String type = "7";
	public static final String limitPrice = "8";
	public static final String isStopGuaranteed = "9";
	public static final String oriStopPrice = "10";
	public static final String currentStopPrice = "11";
	public static final String stopMoveGap = "12";
	public static final String marketPrice4Open = "13";
	public static final String openTradeDay = "14";
	public static final String openTime = "15";
	public static final String isToOpenNew = "16";
	public static final String toCloseTickets = "17";
	public static final String marginPerc4Open = "18";
	public static final String antiTickets = "19";
	public static final String correspondingTicket = "20";
	public static final String expiryTime = "21";
	public static final String iFDLimitPrice = "22";
	public static final String iFDStopPrice = "23";
	public static final String IFDisStopGuaranteed = "24";
	public static final String isPriceReached = "25";
	public static final String priceReachTime = "26";
	public static final String reachedPrice = "27";
	public static final String priceReachedWay = "28";
	public static final String openUserName = "29";
	public static final String openUserIPAddress = "30";
	public static final String openUserType = "31";
	public static final String guaranteeStopCharge = "32";
	public static final String guaranteeStopChargeCurrency = "33";
	public static final String cloesType = "34";
	public static final String closeTradeDay = "35";
	public static final String closetime = "36";
	public static final String openedticket = "37";
	public static final String splitLeftTicket = "38";
	public static final String closedTickets = "39";
	public static final String closeReason = "40";
	public static final String marginPerc4Close = "41";
	public static final String marketprice4Close = "42";
	public static final String closeprice = "43";
	public static final String closeUserName = "44";
	public static final String closeUserIPAddress = "45";
	public static final String closeUserType = "46";
	public static final String openGroup = "47";
	public static final String closeGroup = "48";

	public TOrderHis4CFD(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(TOrderHis4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(TOrderHis4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data=getEntryInt(TOrderHis4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(TOrderHis4CFD.osplitNo, osplitNo);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(TOrderHis4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(TOrderHis4CFD.account, account);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(TOrderHis4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(TOrderHis4CFD.instrument, instrument);
	}

	public int getBuySell() {
		try {
			int data=getEntryInt(TOrderHis4CFD.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(TOrderHis4CFD.buySell, buySell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(TOrderHis4CFD.lots, lots);
	}

	public int getType() {
		try {
			int data=getEntryInt(TOrderHis4CFD.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(TOrderHis4CFD.type, type);
	}

	public double getLimitPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.limitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPrice(double limitPrice) {
		setEntry(TOrderHis4CFD.limitPrice, limitPrice);
	}

	public int getIsStopGuaranteed() {
		try {
			int data=getEntryInt(TOrderHis4CFD.isStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStopGuaranteed(int isStopGuaranteed) {
		setEntry(TOrderHis4CFD.isStopGuaranteed, isStopGuaranteed);
	}

	public double getOriStopPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.oriStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopPrice(double oriStopPrice) {
		setEntry(TOrderHis4CFD.oriStopPrice, oriStopPrice);
	}

	public double getCurrentStopPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.currentStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCurrentStopPrice(double currentStopPrice) {
		setEntry(TOrderHis4CFD.currentStopPrice, currentStopPrice);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(TOrderHis4CFD.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(TOrderHis4CFD.stopMoveGap, stopMoveGap);
	}

	public double getMarketPrice4Open() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.marketPrice4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketPrice4Open(double marketPrice4Open) {
		setEntry(TOrderHis4CFD.marketPrice4Open, marketPrice4Open);
	}

	public String getOpenTradeDay() {
		try {
			String data=getEntryString(TOrderHis4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(TOrderHis4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(TOrderHis4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(TOrderHis4CFD.openTime, openTime);
	}

	public int getIsToOpenNew() {
		try {
			int data=getEntryInt(TOrderHis4CFD.isToOpenNew);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToOpenNew(int isToOpenNew) {
		setEntry(TOrderHis4CFD.isToOpenNew, isToOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(TOrderHis4CFD.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(TOrderHis4CFD.toCloseTickets, toCloseTickets);
	}

	public double getMarginPerc4Open() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.marginPerc4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Open(double marginPerc4Open) {
		setEntry(TOrderHis4CFD.marginPerc4Open, marginPerc4Open);
	}

	public String getAntiTickets() {
		try {
			String data=getEntryString(TOrderHis4CFD.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(TOrderHis4CFD.antiTickets, antiTickets);
	}

	public long getCorrespondingTicket() {
		try {
			long data=getEntryLong(TOrderHis4CFD.correspondingTicket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorrespondingTicket(long correspondingTicket) {
		setEntry(TOrderHis4CFD.correspondingTicket, correspondingTicket);
	}

	public Date getExpiryTime() {
		try {
			Date data=getEntryDate(TOrderHis4CFD.expiryTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpiryTime(Date expiryTime) {
		setEntry(TOrderHis4CFD.expiryTime, expiryTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(TOrderHis4CFD.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(TOrderHis4CFD.iFDStopPrice, iFDStopPrice);
	}

	public int getIFDisStopGuaranteed() {
		try {
			int data=getEntryInt(TOrderHis4CFD.IFDisStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDisStopGuaranteed(int IFDisStopGuaranteed) {
		setEntry(TOrderHis4CFD.IFDisStopGuaranteed, IFDisStopGuaranteed);
	}

	public int getIsPriceReached() {
		try {
			int data=getEntryInt(TOrderHis4CFD.isPriceReached);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReached(int isPriceReached) {
		setEntry(TOrderHis4CFD.isPriceReached, isPriceReached);
	}

	public Date getPriceReachTime() {
		try {
			Date data=getEntryDate(TOrderHis4CFD.priceReachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceReachTime(Date priceReachTime) {
		setEntry(TOrderHis4CFD.priceReachTime, priceReachTime);
	}

	public double getReachedPrice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.reachedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachedPrice(double reachedPrice) {
		setEntry(TOrderHis4CFD.reachedPrice, reachedPrice);
	}

	public int getPriceReachedWay() {
		try {
			int data=getEntryInt(TOrderHis4CFD.priceReachedWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceReachedWay(int priceReachedWay) {
		setEntry(TOrderHis4CFD.priceReachedWay, priceReachedWay);
	}

	public String getOpenUserName() {
		try {
			String data=getEntryString(TOrderHis4CFD.openUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserName(String openUserName) {
		setEntry(TOrderHis4CFD.openUserName, openUserName);
	}

	public String getOpenUserIPAddress() {
		try {
			String data=getEntryString(TOrderHis4CFD.openUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserIPAddress(String openUserIPAddress) {
		setEntry(TOrderHis4CFD.openUserIPAddress, openUserIPAddress);
	}

	public int getOpenUserType() {
		try {
			int data=getEntryInt(TOrderHis4CFD.openUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenUserType(int openUserType) {
		setEntry(TOrderHis4CFD.openUserType, openUserType);
	}

	public double getGuaranteeStopCharge() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.guaranteeStopCharge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopCharge(double guaranteeStopCharge) {
		setEntry(TOrderHis4CFD.guaranteeStopCharge, guaranteeStopCharge);
	}

	public String getGuaranteeStopChargeCurrency() {
		try {
			String data=getEntryString(TOrderHis4CFD.guaranteeStopChargeCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuaranteeStopChargeCurrency(String guaranteeStopChargeCurrency) {
		setEntry(TOrderHis4CFD.guaranteeStopChargeCurrency, guaranteeStopChargeCurrency);
	}

	public int getCloesType() {
		try {
			int data=getEntryInt(TOrderHis4CFD.cloesType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloesType(int cloesType) {
		setEntry(TOrderHis4CFD.cloesType, cloesType);
	}

	public String getCloseTradeDay() {
		try {
			String data=getEntryString(TOrderHis4CFD.closeTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTradeDay(String closeTradeDay) {
		setEntry(TOrderHis4CFD.closeTradeDay, closeTradeDay);
	}

	public Date getClosetime() {
		try {
			Date data=getEntryDate(TOrderHis4CFD.closetime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosetime(Date closetime) {
		setEntry(TOrderHis4CFD.closetime, closetime);
	}

	public String getOpenedticket() {
		try {
			String data=getEntryString(TOrderHis4CFD.openedticket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenedticket(String openedticket) {
		setEntry(TOrderHis4CFD.openedticket, openedticket);
	}

	public String getSplitLeftTicket() {
		try {
			String data=getEntryString(TOrderHis4CFD.splitLeftTicket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSplitLeftTicket(String splitLeftTicket) {
		setEntry(TOrderHis4CFD.splitLeftTicket, splitLeftTicket);
	}

	public String getClosedTickets() {
		try {
			String data=getEntryString(TOrderHis4CFD.closedTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedTickets(String closedTickets) {
		setEntry(TOrderHis4CFD.closedTickets, closedTickets);
	}

	public int getCloseReason() {
		try {
			int data=getEntryInt(TOrderHis4CFD.closeReason);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseReason(int closeReason) {
		setEntry(TOrderHis4CFD.closeReason, closeReason);
	}

	public double getMarginPerc4Close() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.marginPerc4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Close(double marginPerc4Close) {
		setEntry(TOrderHis4CFD.marginPerc4Close, marginPerc4Close);
	}

	public double getMarketprice4Close() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.marketprice4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketprice4Close(double marketprice4Close) {
		setEntry(TOrderHis4CFD.marketprice4Close, marketprice4Close);
	}

	public double getCloseprice() {
		try {
			double data=getEntryDouble(TOrderHis4CFD.closeprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseprice(double closeprice) {
		setEntry(TOrderHis4CFD.closeprice, closeprice);
	}

	public String getCloseUserName() {
		try {
			String data=getEntryString(TOrderHis4CFD.closeUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseUserName(String closeUserName) {
		setEntry(TOrderHis4CFD.closeUserName, closeUserName);
	}

	public String getCloseUserIPAddress() {
		try {
			String data=getEntryString(TOrderHis4CFD.closeUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseUserIPAddress(String closeUserIPAddress) {
		setEntry(TOrderHis4CFD.closeUserIPAddress, closeUserIPAddress);
	}

	public int getCloseUserType() {
		try {
			int data=getEntryInt(TOrderHis4CFD.closeUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseUserType(int closeUserType) {
		setEntry(TOrderHis4CFD.closeUserType, closeUserType);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(TOrderHis4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(TOrderHis4CFD.openGroup, openGroup);
	}

	public String getCloseGroup() {
		try {
			String data=getEntryString(TOrderHis4CFD.closeGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseGroup(String closeGroup) {
		setEntry(TOrderHis4CFD.closeGroup, closeGroup);
	}


}