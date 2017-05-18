package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class TSettled4CFD extends allone.json.AbstractJsonData {

	public static final String jsonId = "24";

	public static final String ticket = "1";
	public static final String splitno = "2";
	public static final String instrument = "3";
	public static final String account = "4";
	public static final String oOrderID = "5";
	public static final String oOsplitNo = "6";
	public static final String cOrderId = "7";
	public static final String cOsplitNo = "8";
	public static final String buysell = "9";
	public static final String lots = "10";
	public static final String openPrice = "11";
	public static final String openTradeDay = "12";
	public static final String openTime = "13";
	public static final String closePrice = "14";
	public static final String profitLoss = "15";
	public static final String rollover = "16";
	public static final String commision_4open = "17";
	public static final String subCommision_System_4open = "18";
	public static final String subCommision_group_4open = "19";
	public static final String subCommision_account_4open = "20";
	public static final String openCommision_currency = "21";
	public static final String commision_4Close = "22";
	public static final String subCommision_System_4Close = "23";
	public static final String subCommision_group_4Close = "24";
	public static final String subCommision_account_4Close = "25";
	public static final String closeCommision_currency = "26";
	public static final String IBChargedFeeByPoint = "27";
	public static final String IBChargedFeeByPoint_System = "28";
	public static final String IBChargedFeeByPoint_group = "29";
	public static final String IBChargedFeeByPoint_account = "30";
	public static final String IBChargedFeeByPoint_currency = "31";
	public static final String closeTradeDay = "32";
	public static final String closeTime = "33";
	public static final String reason = "34";
	public static final String balanceCurrency = "35";
	public static final String balanceRate = "36";
	public static final String marginRate = "37";
	public static final String openGroup = "38";
	public static final String closeGroup = "39";
	public static final String amountPerLot = "40";
//	public static final String isDelivery = "41";
	
	public static final String oriOpenPrice = "42";
	public static final String realizedPL = "43";
	public static final String lastPL = "44";
	public static final String realizedRollover = "45";

	public TSettled4CFD(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getTicket() {
		try {
			long data=getEntryLong(TSettled4CFD.ticket);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTicket(long ticket) {
		setEntry(TSettled4CFD.ticket, ticket);
	}

	public int getSplitno() {
		try {
			int data=getEntryInt(TSettled4CFD.splitno);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSplitno(int splitno) {
		setEntry(TSettled4CFD.splitno, splitno);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(TSettled4CFD.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(TSettled4CFD.instrument, instrument);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(TSettled4CFD.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(TSettled4CFD.account, account);
	}

	public long getOOrderID() {
		try {
			long data=getEntryLong(TSettled4CFD.oOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOOrderID(long oOrderID) {
		setEntry(TSettled4CFD.oOrderID, oOrderID);
	}

	public int getOOsplitNo() {
		try {
			int data=getEntryInt(TSettled4CFD.oOsplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOOsplitNo(int oOsplitNo) {
		setEntry(TSettled4CFD.oOsplitNo, oOsplitNo);
	}

	public long getCOrderId() {
		try {
			long data=getEntryLong(TSettled4CFD.cOrderId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCOrderId(long cOrderId) {
		setEntry(TSettled4CFD.cOrderId, cOrderId);
	}

	public int getCOsplitNo() {
		try {
			int data=getEntryInt(TSettled4CFD.cOsplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCOsplitNo(int cOsplitNo) {
		setEntry(TSettled4CFD.cOsplitNo, cOsplitNo);
	}

	public int getBuysell() {
		try {
			int data=getEntryInt(TSettled4CFD.buysell);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBuysell(int buysell) {
		setEntry(TSettled4CFD.buysell, buysell);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(TSettled4CFD.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(TSettled4CFD.lots, lots);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(TSettled4CFD.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(TSettled4CFD.openPrice, openPrice);
	}

	public String getOpenTradeDay() {
		try {
			String data=getEntryString(TSettled4CFD.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(TSettled4CFD.openTradeDay, openTradeDay);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(TSettled4CFD.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(TSettled4CFD.openTime, openTime);
	}

	public double getClosePrice() {
		try {
			double data=getEntryDouble(TSettled4CFD.closePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setClosePrice(double closePrice) {
		setEntry(TSettled4CFD.closePrice, closePrice);
	}

	public double getProfitLoss() {
		try {
			double data=getEntryDouble(TSettled4CFD.profitLoss);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setProfitLoss(double profitLoss) {
		setEntry(TSettled4CFD.profitLoss, profitLoss);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(TSettled4CFD.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(TSettled4CFD.rollover, rollover);
	}

	public double getCommision_4open() {
		try {
			double data=getEntryDouble(TSettled4CFD.commision_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4open(double commision_4open) {
		setEntry(TSettled4CFD.commision_4open, commision_4open);
	}

	public double getSubCommision_System_4open() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_System_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_System_4open(double subCommision_System_4open) {
		setEntry(TSettled4CFD.subCommision_System_4open, subCommision_System_4open);
	}

	public double getSubCommision_group_4open() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_group_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_group_4open(double subCommision_group_4open) {
		setEntry(TSettled4CFD.subCommision_group_4open, subCommision_group_4open);
	}

	public double getSubCommision_account_4open() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_account_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_account_4open(double subCommision_account_4open) {
		setEntry(TSettled4CFD.subCommision_account_4open, subCommision_account_4open);
	}

	public String getOpenCommision_currency() {
		try {
			String data=getEntryString(TSettled4CFD.openCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenCommision_currency(String openCommision_currency) {
		setEntry(TSettled4CFD.openCommision_currency, openCommision_currency);
	}

	public double getCommision_4Close() {
		try {
			double data=getEntryDouble(TSettled4CFD.commision_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4Close(double commision_4Close) {
		setEntry(TSettled4CFD.commision_4Close, commision_4Close);
	}

	public double getSubCommision_System_4Close() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_System_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_System_4Close(double subCommision_System_4Close) {
		setEntry(TSettled4CFD.subCommision_System_4Close, subCommision_System_4Close);
	}

	public double getSubCommision_group_4Close() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_group_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_group_4Close(double subCommision_group_4Close) {
		setEntry(TSettled4CFD.subCommision_group_4Close, subCommision_group_4Close);
	}

	public double getSubCommision_account_4Close() {
		try {
			double data=getEntryDouble(TSettled4CFD.subCommision_account_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSubCommision_account_4Close(double subCommision_account_4Close) {
		setEntry(TSettled4CFD.subCommision_account_4Close, subCommision_account_4Close);
	}

	public String getCloseCommision_currency() {
		try {
			String data=getEntryString(TSettled4CFD.closeCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseCommision_currency(String closeCommision_currency) {
		setEntry(TSettled4CFD.closeCommision_currency, closeCommision_currency);
	}

	public double getIBChargedFeeByPoint() {
		try {
			double data=getEntryDouble(TSettled4CFD.IBChargedFeeByPoint);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedFeeByPoint(double IBChargedFeeByPoint) {
		setEntry(TSettled4CFD.IBChargedFeeByPoint, IBChargedFeeByPoint);
	}

	public double getIBChargedFeeByPoint_System() {
		try {
			double data=getEntryDouble(TSettled4CFD.IBChargedFeeByPoint_System);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedFeeByPoint_System(double IBChargedFeeByPoint_System) {
		setEntry(TSettled4CFD.IBChargedFeeByPoint_System, IBChargedFeeByPoint_System);
	}

	public double getIBChargedFeeByPoint_group() {
		try {
			double data=getEntryDouble(TSettled4CFD.IBChargedFeeByPoint_group);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedFeeByPoint_group(double IBChargedFeeByPoint_group) {
		setEntry(TSettled4CFD.IBChargedFeeByPoint_group, IBChargedFeeByPoint_group);
	}

	public double getIBChargedFeeByPoint_account() {
		try {
			double data=getEntryDouble(TSettled4CFD.IBChargedFeeByPoint_account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBChargedFeeByPoint_account(double IBChargedFeeByPoint_account) {
		setEntry(TSettled4CFD.IBChargedFeeByPoint_account, IBChargedFeeByPoint_account);
	}

	public String getIBChargedFeeByPoint_currency() {
		try {
			String data=getEntryString(TSettled4CFD.IBChargedFeeByPoint_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIBChargedFeeByPoint_currency(String IBChargedFeeByPoint_currency) {
		setEntry(TSettled4CFD.IBChargedFeeByPoint_currency, IBChargedFeeByPoint_currency);
	}

	public String getCloseTradeDay() {
		try {
			String data=getEntryString(TSettled4CFD.closeTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTradeDay(String closeTradeDay) {
		setEntry(TSettled4CFD.closeTradeDay, closeTradeDay);
	}

	public Date getCloseTime() {
		try {
			Date data=getEntryDate(TSettled4CFD.closeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTime(Date closeTime) {
		setEntry(TSettled4CFD.closeTime, closeTime);
	}

	public int getReason() {
		try {
			int data=getEntryInt(TSettled4CFD.reason);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReason(int reason) {
		setEntry(TSettled4CFD.reason, reason);
	}

	public String getBalanceCurrency() {
		try {
			String data=getEntryString(TSettled4CFD.balanceCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBalanceCurrency(String balanceCurrency) {
		setEntry(TSettled4CFD.balanceCurrency, balanceCurrency);
	}

	public double getBalanceRate() {
		try {
			double data=getEntryDouble(TSettled4CFD.balanceRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBalanceRate(double balanceRate) {
		setEntry(TSettled4CFD.balanceRate, balanceRate);
	}

	public double getMarginRate() {
		try {
			double data=getEntryDouble(TSettled4CFD.marginRate);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginRate(double marginRate) {
		setEntry(TSettled4CFD.marginRate, marginRate);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(TSettled4CFD.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(TSettled4CFD.openGroup, openGroup);
	}

	public String getCloseGroup() {
		try {
			String data=getEntryString(TSettled4CFD.closeGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseGroup(String closeGroup) {
		setEntry(TSettled4CFD.closeGroup, closeGroup);
	}

	public double getAmountPerLot() {
		try {
			double data=getEntryDouble(TSettled4CFD.amountPerLot);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmountPerLot(double amountPerLot) {
		setEntry(TSettled4CFD.amountPerLot, amountPerLot);
	}

//	public int getIsDelivery() {
//		try {
//			int data=getEntryInt(TSettled4CFD.isDelivery);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsDelivery(int isDelivery) {
//		setEntry(TSettled4CFD.isDelivery, isDelivery);
//	}

	public double getOriOpenPrice() {
		try {
			double data=getEntryDouble(TSettled4CFD.oriOpenPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriOpenPrice(double oriOpenPrice) {
		setEntry(TSettled4CFD.oriOpenPrice, oriOpenPrice);
	}
	
	
	public double getRealizedPL() {
		try {
			double data=getEntryDouble(TSettled4CFD.realizedPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedPL(double realizedPL) {
		setEntry(TSettled4CFD.realizedPL, realizedPL);
	}
	
	
	public double getLastPL() {
		try {
			double data=getEntryDouble(TSettled4CFD.lastPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLastPL(double lastPL) {
		setEntry(TSettled4CFD.lastPL, lastPL);
	}
	
	
	public double getRealizedRollover() {
		try {
			double data=getEntryDouble(TSettled4CFD.realizedRollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedRollover(double realizedRollover) {
		setEntry(TSettled4CFD.realizedRollover, realizedRollover);
	}

}