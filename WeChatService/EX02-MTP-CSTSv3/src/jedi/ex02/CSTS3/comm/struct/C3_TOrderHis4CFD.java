package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.TOrderHis4CFD;

public class C3_TOrderHis4CFD extends allone.json.AbstractJsonData {

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

	public C3_TOrderHis4CFD(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(TOrderHis4CFD data) throws Exception {
		setOrderID(data.getOrderID());
		setOsplitNo(data.getOsplitNo());
		setAccount(data.getAccount());
		setInstrument(data.getInstrument());
		setBuySell(data.getBuySell());
		setLots(data.getLots());
		setType(data.getType());
		setLimitPrice(data.getLimitPrice());
		setIsStopGuaranteed(data.getIsStopGuaranteed());
		setOriStopPrice(data.getOriStopPrice());
		setCurrentStopPrice(data.getCurrentStopPrice());
		setStopMoveGap(data.getStopMoveGap());
		setMarketPrice4Open(data.getMarketPrice4Open());
		setOpenTradeDay(data.getOpenTradeDay());
		setOpenTime(data.getOpenTime());
		setIsToOpenNew(data.getIsToOpenNew());
		setToCloseTickets(data.getToCloseTickets());
		setMarginPerc4Open(data.getMarginPerc4Open());
		setAntiTickets(data.getAntiTickets());
		setCorrespondingTicket(data.getCorrespondingTicket());
		setExpiryTime(data.getExpiryTime());
		setIFDLimitPrice(data.getIFDLimitPrice());
		setIFDStopPrice(data.getIFDStopPrice());
		setIFDisStopGuaranteed(data.getIFDisStopGuaranteed());
		setIsPriceReached(data.getIsPriceReached());
		setPriceReachTime(data.getPriceReachTime());
		setReachedPrice(data.getReachedPrice());
		setPriceReachedWay(data.getPriceReachedWay());
		setOpenUserName(data.getOpenUserName());
		setOpenUserIPAddress(data.getOpenUserIPAddress());
		setOpenUserType(data.getOpenUserType());
		setGuaranteeStopCharge(data.getGuaranteeStopCharge());
		setGuaranteeStopChargeCurrency(data.getGuaranteeStopChargeCurrency());
		setCloesType(data.getCloesType());
		setCloseTradeDay(data.getCloseTradeDay());
		setClosetime(data.getClosetime());
		setOpenedticket(data.getOpenedticket());
		setSplitLeftTicket(data.getSplitLeftTicket());
		setClosedTickets(data.getClosedTickets());
		setCloseReason(data.getCloseReason());
		setMarginPerc4Close(data.getMarginPerc4Close());
		setMarketprice4Close(data.getMarketprice4Close());
		setCloseprice(data.getCloseprice());
		setCloseUserName(data.getCloseUserName());
		setCloseUserIPAddress(data.getCloseUserIPAddress());
		setCloseUserType(data.getCloseUserType());
		setOpenGroup(data.getOpenGroup());
		setCloseGroup(data.getCloseGroup());
	}

	public TOrderHis4CFD format(){
		TOrderHis4CFD data=new TOrderHis4CFD();
		data.setOrderID(getOrderID());
		data.setOsplitNo(getOsplitNo());
		data.setAccount(getAccount());
		data.setInstrument(getInstrument());
		data.setBuySell(getBuySell());
		data.setLots(getLots());
		data.setType(getType());
		data.setLimitPrice(getLimitPrice());
		data.setIsStopGuaranteed(getIsStopGuaranteed());
		data.setOriStopPrice(getOriStopPrice());
		data.setCurrentStopPrice(getCurrentStopPrice());
		data.setStopMoveGap(getStopMoveGap());
		data.setMarketPrice4Open(getMarketPrice4Open());
		data.setOpenTradeDay(getOpenTradeDay());
		data.setOpenTime(getOpenTime());
		data.setIsToOpenNew(getIsToOpenNew());
		data.setToCloseTickets(getToCloseTickets());
		data.setMarginPerc4Open(getMarginPerc4Open());
		data.setAntiTickets(getAntiTickets());
		data.setCorrespondingTicket(getCorrespondingTicket());
		data.setExpiryTime(getExpiryTime());
		data.setIFDLimitPrice(getIFDLimitPrice());
		data.setIFDStopPrice(getIFDStopPrice());
		data.setIFDisStopGuaranteed(getIFDisStopGuaranteed());
		data.setIsPriceReached(getIsPriceReached());
		data.setPriceReachTime(getPriceReachTime());
		data.setReachedPrice(getReachedPrice());
		data.setPriceReachedWay(getPriceReachedWay());
		data.setOpenUserName(getOpenUserName());
		data.setOpenUserIPAddress(getOpenUserIPAddress());
		data.setOpenUserType(getOpenUserType());
		data.setGuaranteeStopCharge(getGuaranteeStopCharge());
		data.setGuaranteeStopChargeCurrency(getGuaranteeStopChargeCurrency());
		data.setCloesType(getCloesType());
		data.setCloseTradeDay(getCloseTradeDay());
		data.setClosetime(getClosetime());
		data.setOpenedticket(getOpenedticket());
		data.setSplitLeftTicket(getSplitLeftTicket());
		data.setClosedTickets(getClosedTickets());
		data.setCloseReason(getCloseReason());
		data.setMarginPerc4Close(getMarginPerc4Close());
		data.setMarketprice4Close(getMarketprice4Close());
		data.setCloseprice(getCloseprice());
		data.setCloseUserName(getCloseUserName());
		data.setCloseUserIPAddress(getCloseUserIPAddress());
		data.setCloseUserType(getCloseUserType());
		data.setOpenGroup(getOpenGroup());
		data.setCloseGroup(getCloseGroup());
		return data;
	}


	public long getOrderID() {
		try {
			long data=getEntryLong(C3_TOrderHis4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_TOrderHis4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(C3_TOrderHis4CFD.osplitNo, osplitNo);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_TOrderHis4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_TOrderHis4CFD.account, account);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_TOrderHis4CFD.instrument, instrument);
	}

	public int getBuySell() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.buySell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuySell(int buySell) {
		setEntry(C3_TOrderHis4CFD.buySell, buySell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_TOrderHis4CFD.lots, lots);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_TOrderHis4CFD.type, type);
	}

	public double getLimitPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.limitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPrice(double limitPrice) {
		setEntry(C3_TOrderHis4CFD.limitPrice, limitPrice);
	}

	public int getIsStopGuaranteed() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.isStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStopGuaranteed(int isStopGuaranteed) {
		setEntry(C3_TOrderHis4CFD.isStopGuaranteed, isStopGuaranteed);
	}

	public double getOriStopPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.oriStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopPrice(double oriStopPrice) {
		setEntry(C3_TOrderHis4CFD.oriStopPrice, oriStopPrice);
	}

	public double getCurrentStopPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.currentStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCurrentStopPrice(double currentStopPrice) {
		setEntry(C3_TOrderHis4CFD.currentStopPrice, currentStopPrice);
	}

	public int getStopMoveGap() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(C3_TOrderHis4CFD.stopMoveGap, stopMoveGap);
	}

	public double getMarketPrice4Open() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.marketPrice4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketPrice4Open(double marketPrice4Open) {
		setEntry(C3_TOrderHis4CFD.marketPrice4Open, marketPrice4Open);
	}

	public String getOpenTradeDay() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(C3_TOrderHis4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(C3_TOrderHis4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(C3_TOrderHis4CFD.openTime, openTime);
	}

	public int getIsToOpenNew() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.isToOpenNew);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToOpenNew(int isToOpenNew) {
		setEntry(C3_TOrderHis4CFD.isToOpenNew, isToOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(C3_TOrderHis4CFD.toCloseTickets, toCloseTickets);
	}

	public double getMarginPerc4Open() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.marginPerc4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Open(double marginPerc4Open) {
		setEntry(C3_TOrderHis4CFD.marginPerc4Open, marginPerc4Open);
	}

	public String getAntiTickets() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(C3_TOrderHis4CFD.antiTickets, antiTickets);
	}

	public long getCorrespondingTicket() {
		try {
			long data=getEntryLong(C3_TOrderHis4CFD.correspondingTicket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorrespondingTicket(long correspondingTicket) {
		setEntry(C3_TOrderHis4CFD.correspondingTicket, correspondingTicket);
	}

	public Date getExpiryTime() {
		try {
			Date data=getEntryDate(C3_TOrderHis4CFD.expiryTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpiryTime(Date expiryTime) {
		setEntry(C3_TOrderHis4CFD.expiryTime, expiryTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(C3_TOrderHis4CFD.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(C3_TOrderHis4CFD.iFDStopPrice, iFDStopPrice);
	}

	public int getIFDisStopGuaranteed() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.IFDisStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDisStopGuaranteed(int IFDisStopGuaranteed) {
		setEntry(C3_TOrderHis4CFD.IFDisStopGuaranteed, IFDisStopGuaranteed);
	}

	public int getIsPriceReached() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.isPriceReached);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReached(int isPriceReached) {
		setEntry(C3_TOrderHis4CFD.isPriceReached, isPriceReached);
	}

	public Date getPriceReachTime() {
		try {
			Date data=getEntryDate(C3_TOrderHis4CFD.priceReachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceReachTime(Date priceReachTime) {
		setEntry(C3_TOrderHis4CFD.priceReachTime, priceReachTime);
	}

	public double getReachedPrice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.reachedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachedPrice(double reachedPrice) {
		setEntry(C3_TOrderHis4CFD.reachedPrice, reachedPrice);
	}

	public int getPriceReachedWay() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.priceReachedWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceReachedWay(int priceReachedWay) {
		setEntry(C3_TOrderHis4CFD.priceReachedWay, priceReachedWay);
	}

	public String getOpenUserName() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.openUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserName(String openUserName) {
		setEntry(C3_TOrderHis4CFD.openUserName, openUserName);
	}

	public String getOpenUserIPAddress() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.openUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserIPAddress(String openUserIPAddress) {
		setEntry(C3_TOrderHis4CFD.openUserIPAddress, openUserIPAddress);
	}

	public int getOpenUserType() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.openUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenUserType(int openUserType) {
		setEntry(C3_TOrderHis4CFD.openUserType, openUserType);
	}

	public double getGuaranteeStopCharge() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.guaranteeStopCharge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopCharge(double guaranteeStopCharge) {
		setEntry(C3_TOrderHis4CFD.guaranteeStopCharge, guaranteeStopCharge);
	}

	public String getGuaranteeStopChargeCurrency() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.guaranteeStopChargeCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuaranteeStopChargeCurrency(String guaranteeStopChargeCurrency) {
		setEntry(C3_TOrderHis4CFD.guaranteeStopChargeCurrency, guaranteeStopChargeCurrency);
	}

	public int getCloesType() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.cloesType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloesType(int cloesType) {
		setEntry(C3_TOrderHis4CFD.cloesType, cloesType);
	}

	public String getCloseTradeDay() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.closeTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTradeDay(String closeTradeDay) {
		setEntry(C3_TOrderHis4CFD.closeTradeDay, closeTradeDay);
	}

	public Date getClosetime() {
		try {
			Date data=getEntryDate(C3_TOrderHis4CFD.closetime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosetime(Date closetime) {
		setEntry(C3_TOrderHis4CFD.closetime, closetime);
	}

	public String getOpenedticket() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.openedticket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenedticket(String openedticket) {
		setEntry(C3_TOrderHis4CFD.openedticket, openedticket);
	}

	public String getSplitLeftTicket() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.splitLeftTicket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSplitLeftTicket(String splitLeftTicket) {
		setEntry(C3_TOrderHis4CFD.splitLeftTicket, splitLeftTicket);
	}

	public String getClosedTickets() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.closedTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedTickets(String closedTickets) {
		setEntry(C3_TOrderHis4CFD.closedTickets, closedTickets);
	}

	public int getCloseReason() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.closeReason);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseReason(int closeReason) {
		setEntry(C3_TOrderHis4CFD.closeReason, closeReason);
	}

	public double getMarginPerc4Close() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.marginPerc4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Close(double marginPerc4Close) {
		setEntry(C3_TOrderHis4CFD.marginPerc4Close, marginPerc4Close);
	}

	public double getMarketprice4Close() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.marketprice4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketprice4Close(double marketprice4Close) {
		setEntry(C3_TOrderHis4CFD.marketprice4Close, marketprice4Close);
	}

	public double getCloseprice() {
		try {
			double data=getEntryDouble(C3_TOrderHis4CFD.closeprice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseprice(double closeprice) {
		setEntry(C3_TOrderHis4CFD.closeprice, closeprice);
	}

	public String getCloseUserName() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.closeUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseUserName(String closeUserName) {
		setEntry(C3_TOrderHis4CFD.closeUserName, closeUserName);
	}

	public String getCloseUserIPAddress() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.closeUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseUserIPAddress(String closeUserIPAddress) {
		setEntry(C3_TOrderHis4CFD.closeUserIPAddress, closeUserIPAddress);
	}

	public int getCloseUserType() {
		try {
			int data=getEntryInt(C3_TOrderHis4CFD.closeUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseUserType(int closeUserType) {
		setEntry(C3_TOrderHis4CFD.closeUserType, closeUserType);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(C3_TOrderHis4CFD.openGroup, openGroup);
	}

	public String getCloseGroup() {
		try {
			String data=getEntryString(C3_TOrderHis4CFD.closeGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseGroup(String closeGroup) {
		setEntry(C3_TOrderHis4CFD.closeGroup, closeGroup);
	}


}