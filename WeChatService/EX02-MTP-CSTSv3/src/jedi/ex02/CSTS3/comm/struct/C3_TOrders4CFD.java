package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.TOrders4CFD;

public class C3_TOrders4CFD extends allone.json.AbstractJsonData {

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
	public static final String limitPriceRatio = "35";
	public static final String stopPriceRatio = "36";

	public C3_TOrders4CFD() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(TOrders4CFD data) throws Exception {
		setOrderID(data.getOrderID());
		setOsplitNo(data.getOsplitNo());
		setAccount(data.getAccount());
		setInstrument(data.getInstrument());
		setBuysell(data.getBuysell());
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
		setOpenGroup(data.getOpenGroup());
		setLimitPriceRatio(data.getLimitPriceRatio());
		setStopPriceRatio(data.getStopPriceRatio());
	}

	public TOrders4CFD format() {
		TOrders4CFD data = new TOrders4CFD();
		data.setOrderID(getOrderID());
		data.setOsplitNo(getOsplitNo());
		data.setAccount(getAccount());
		data.setInstrument(getInstrument());
		data.setBuysell(getBuysell());
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
		data.setOpenGroup(getOpenGroup());
		data.setLimitPriceRatio(getLimitPriceRatio());
		data.setStopPriceRatio(getStopPriceRatio());
		return data;
	}

	public long getOrderID() {
		try {
			long data = getEntryLong(C3_TOrders4CFD.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_TOrders4CFD.orderID, orderID);
	}

	public int getOsplitNo() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.osplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOsplitNo(int osplitNo) {
		setEntry(C3_TOrders4CFD.osplitNo, osplitNo);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_TOrders4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_TOrders4CFD.account, account);
	}

	public String getInstrument() {
		try {
			String data = getEntryString(C3_TOrders4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_TOrders4CFD.instrument, instrument);
	}

	public int getBuysell() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(C3_TOrders4CFD.buysell, buysell);
	}

	public double getLots() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_TOrders4CFD.lots, lots);
	}

	public int getType() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_TOrders4CFD.type, type);
	}

	public double getLimitPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.limitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPrice(double limitPrice) {
		setEntry(C3_TOrders4CFD.limitPrice, limitPrice);
	}

	public int getIsStopGuaranteed() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.isStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsStopGuaranteed(int isStopGuaranteed) {
		setEntry(C3_TOrders4CFD.isStopGuaranteed, isStopGuaranteed);
	}

	public double getOriStopPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.oriStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriStopPrice(double oriStopPrice) {
		setEntry(C3_TOrders4CFD.oriStopPrice, oriStopPrice);
	}

	public double getCurrentStopPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.currentStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCurrentStopPrice(double currentStopPrice) {
		setEntry(C3_TOrders4CFD.currentStopPrice, currentStopPrice);
	}

	public int getStopMoveGap() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.stopMoveGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopMoveGap(int stopMoveGap) {
		setEntry(C3_TOrders4CFD.stopMoveGap, stopMoveGap);
	}

	public double getMarketPrice4Open() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.marketPrice4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketPrice4Open(double marketPrice4Open) {
		setEntry(C3_TOrders4CFD.marketPrice4Open, marketPrice4Open);
	}

	public String getOpenTradeDay() {
		try {
			String data = getEntryString(C3_TOrders4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(C3_TOrders4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data = getEntryDate(C3_TOrders4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(C3_TOrders4CFD.openTime, openTime);
	}

	public int getIsToOpenNew() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.isToOpenNew);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToOpenNew(int isToOpenNew) {
		setEntry(C3_TOrders4CFD.isToOpenNew, isToOpenNew);
	}

	public String getToCloseTickets() {
		try {
			String data = getEntryString(C3_TOrders4CFD.toCloseTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToCloseTickets(String toCloseTickets) {
		setEntry(C3_TOrders4CFD.toCloseTickets, toCloseTickets);
	}

	public double getMarginPerc4Open() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.marginPerc4Open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginPerc4Open(double marginPerc4Open) {
		setEntry(C3_TOrders4CFD.marginPerc4Open, marginPerc4Open);
	}

	public String getAntiTickets() {
		try {
			String data = getEntryString(C3_TOrders4CFD.antiTickets);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAntiTickets(String antiTickets) {
		setEntry(C3_TOrders4CFD.antiTickets, antiTickets);
	}

	public long getCorrespondingTicket() {
		try {
			long data = getEntryLong(C3_TOrders4CFD.correspondingTicket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCorrespondingTicket(long correspondingTicket) {
		setEntry(C3_TOrders4CFD.correspondingTicket, correspondingTicket);
	}

	public Date getExpiryTime() {
		try {
			Date data = getEntryDate(C3_TOrders4CFD.expiryTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpiryTime(Date expiryTime) {
		setEntry(C3_TOrders4CFD.expiryTime, expiryTime);
	}

	public double getIFDLimitPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.iFDLimitPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDLimitPrice(double iFDLimitPrice) {
		setEntry(C3_TOrders4CFD.iFDLimitPrice, iFDLimitPrice);
	}

	public double getIFDStopPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.iFDStopPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDStopPrice(double iFDStopPrice) {
		setEntry(C3_TOrders4CFD.iFDStopPrice, iFDStopPrice);
	}

	public int getIFDisStopGuaranteed() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.IFDisStopGuaranteed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIFDisStopGuaranteed(int IFDisStopGuaranteed) {
		setEntry(C3_TOrders4CFD.IFDisStopGuaranteed, IFDisStopGuaranteed);
	}

	public int getIsPriceReached() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.isPriceReached);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsPriceReached(int isPriceReached) {
		setEntry(C3_TOrders4CFD.isPriceReached, isPriceReached);
	}

	public Date getPriceReachTime() {
		try {
			Date data = getEntryDate(C3_TOrders4CFD.priceReachTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPriceReachTime(Date priceReachTime) {
		setEntry(C3_TOrders4CFD.priceReachTime, priceReachTime);
	}

	public double getReachedPrice() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.reachedPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReachedPrice(double reachedPrice) {
		setEntry(C3_TOrders4CFD.reachedPrice, reachedPrice);
	}

	public int getPriceReachedWay() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.priceReachedWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setPriceReachedWay(int priceReachedWay) {
		setEntry(C3_TOrders4CFD.priceReachedWay, priceReachedWay);
	}

	public String getOpenUserName() {
		try {
			String data = getEntryString(C3_TOrders4CFD.openUserName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserName(String openUserName) {
		setEntry(C3_TOrders4CFD.openUserName, openUserName);
	}

	public String getOpenUserIPAddress() {
		try {
			String data = getEntryString(C3_TOrders4CFD.openUserIPAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenUserIPAddress(String openUserIPAddress) {
		setEntry(C3_TOrders4CFD.openUserIPAddress, openUserIPAddress);
	}

	public int getOpenUserType() {
		try {
			int data = getEntryInt(C3_TOrders4CFD.openUserType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenUserType(int openUserType) {
		setEntry(C3_TOrders4CFD.openUserType, openUserType);
	}

	public double getGuaranteeStopCharge() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.guaranteeStopCharge);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setGuaranteeStopCharge(double guaranteeStopCharge) {
		setEntry(C3_TOrders4CFD.guaranteeStopCharge, guaranteeStopCharge);
	}

	public String getGuaranteeStopChargeCurrency() {
		try {
			String data = getEntryString(C3_TOrders4CFD.guaranteeStopChargeCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGuaranteeStopChargeCurrency(
			String guaranteeStopChargeCurrency) {
		setEntry(C3_TOrders4CFD.guaranteeStopChargeCurrency,
				guaranteeStopChargeCurrency);
	}

	public String getOpenGroup() {
		try {
			String data = getEntryString(C3_TOrders4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(C3_TOrders4CFD.openGroup, openGroup);
	}

	public double getLimitPriceRatio() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.limitPriceRatio);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLimitPriceRatio(double limitPriceRatio) {
		setEntry(C3_TOrders4CFD.limitPriceRatio, limitPriceRatio);
	}

	public double getStopPriceRatio() {
		try {
			double data = getEntryDouble(C3_TOrders4CFD.stopPriceRatio);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStopPriceRatio(double stopPriceRatio) {
		setEntry(C3_TOrders4CFD.stopPriceRatio, stopPriceRatio);
	}
}