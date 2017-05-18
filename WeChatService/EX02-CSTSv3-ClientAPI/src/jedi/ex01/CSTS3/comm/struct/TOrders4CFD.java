package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class TOrders4CFD extends allone.json.AbstractJsonData {

	public static final String jsonId = "22";

	public static final String orderID = "1";
	public static final String osplitNo = "2";
	public static final String account = "3";
	public static final String instrument = "4";
	public static final String buysell = "5";
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
	public static final String openGroup = "34";

	public TOrders4CFD(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getOrderID() {
		try {
			long data=getEntryLong(TOrders4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(TOrders4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data=getEntryInt(TOrders4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(TOrders4CFD.osplitNo, osplitNo);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(TOrders4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(TOrders4CFD.account, account);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(TOrders4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(TOrders4CFD.instrument, instrument);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(TOrders4CFD.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(TOrders4CFD.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(TOrders4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(TOrders4CFD.lots, lots);
	}

	public int getType() {
		try {
			int data=getEntryInt(TOrders4CFD.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(TOrders4CFD.type, type);
	}

	public double getLimitPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.limitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPrice(double limitPrice) {
		setEntry(TOrders4CFD.limitPrice, limitPrice);
	}

	public int getIsStopGuaranteed() {
		try {
			int data=getEntryInt(TOrders4CFD.isStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStopGuaranteed(int isStopGuaranteed) {
		setEntry(TOrders4CFD.isStopGuaranteed, isStopGuaranteed);
	}

	public double getOriStopPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.oriStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopPrice(double oriStopPrice) {
		setEntry(TOrders4CFD.oriStopPrice, oriStopPrice);
	}

	public double getCurrentStopPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.currentStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCurrentStopPrice(double currentStopPrice) {
		setEntry(TOrders4CFD.currentStopPrice, currentStopPrice);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(TOrders4CFD.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(TOrders4CFD.stopMoveGap, stopMoveGap);
	}

	public double getMarketPrice4Open() {
		try {
			double data=getEntryDouble(TOrders4CFD.marketPrice4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketPrice4Open(double marketPrice4Open) {
		setEntry(TOrders4CFD.marketPrice4Open, marketPrice4Open);
	}

	public String getOpenTradeDay() {
		try {
			String data=getEntryString(TOrders4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(TOrders4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(TOrders4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(TOrders4CFD.openTime, openTime);
	}

	public int getIsToOpenNew() {
		try {
			int data=getEntryInt(TOrders4CFD.isToOpenNew);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToOpenNew(int isToOpenNew) {
		setEntry(TOrders4CFD.isToOpenNew, isToOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(TOrders4CFD.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(TOrders4CFD.toCloseTickets, toCloseTickets);
	}

	public double getMarginPerc4Open() {
		try {
			double data=getEntryDouble(TOrders4CFD.marginPerc4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Open(double marginPerc4Open) {
		setEntry(TOrders4CFD.marginPerc4Open, marginPerc4Open);
	}

	public String getAntiTickets() {
		try {
			String data=getEntryString(TOrders4CFD.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(TOrders4CFD.antiTickets, antiTickets);
	}

	public long getCorrespondingTicket() {
		try {
			long data=getEntryLong(TOrders4CFD.correspondingTicket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorrespondingTicket(long correspondingTicket) {
		setEntry(TOrders4CFD.correspondingTicket, correspondingTicket);
	}

	public Date getExpiryTime() {
		try {
			Date data=getEntryDate(TOrders4CFD.expiryTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpiryTime(Date expiryTime) {
		setEntry(TOrders4CFD.expiryTime, expiryTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(TOrders4CFD.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(TOrders4CFD.iFDStopPrice, iFDStopPrice);
	}

	public int getIFDisStopGuaranteed() {
		try {
			int data=getEntryInt(TOrders4CFD.IFDisStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDisStopGuaranteed(int IFDisStopGuaranteed) {
		setEntry(TOrders4CFD.IFDisStopGuaranteed, IFDisStopGuaranteed);
	}

	public int getIsPriceReached() {
		try {
			int data=getEntryInt(TOrders4CFD.isPriceReached);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReached(int isPriceReached) {
		setEntry(TOrders4CFD.isPriceReached, isPriceReached);
	}

	public Date getPriceReachTime() {
		try {
			Date data=getEntryDate(TOrders4CFD.priceReachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceReachTime(Date priceReachTime) {
		setEntry(TOrders4CFD.priceReachTime, priceReachTime);
	}

	public double getReachedPrice() {
		try {
			double data=getEntryDouble(TOrders4CFD.reachedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachedPrice(double reachedPrice) {
		setEntry(TOrders4CFD.reachedPrice, reachedPrice);
	}

	public int getPriceReachedWay() {
		try {
			int data=getEntryInt(TOrders4CFD.priceReachedWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceReachedWay(int priceReachedWay) {
		setEntry(TOrders4CFD.priceReachedWay, priceReachedWay);
	}

	public String getOpenUserName() {
		try {
			String data=getEntryString(TOrders4CFD.openUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserName(String openUserName) {
		setEntry(TOrders4CFD.openUserName, openUserName);
	}

	public String getOpenUserIPAddress() {
		try {
			String data=getEntryString(TOrders4CFD.openUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserIPAddress(String openUserIPAddress) {
		setEntry(TOrders4CFD.openUserIPAddress, openUserIPAddress);
	}

	public int getOpenUserType() {
		try {
			int data=getEntryInt(TOrders4CFD.openUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenUserType(int openUserType) {
		setEntry(TOrders4CFD.openUserType, openUserType);
	}

	public double getGuaranteeStopCharge() {
		try {
			double data=getEntryDouble(TOrders4CFD.guaranteeStopCharge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopCharge(double guaranteeStopCharge) {
		setEntry(TOrders4CFD.guaranteeStopCharge, guaranteeStopCharge);
	}

	public String getGuaranteeStopChargeCurrency() {
		try {
			String data=getEntryString(TOrders4CFD.guaranteeStopChargeCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuaranteeStopChargeCurrency(String guaranteeStopChargeCurrency) {
		setEntry(TOrders4CFD.guaranteeStopChargeCurrency, guaranteeStopChargeCurrency);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(TOrders4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(TOrders4CFD.openGroup, openGroup);
	}


}