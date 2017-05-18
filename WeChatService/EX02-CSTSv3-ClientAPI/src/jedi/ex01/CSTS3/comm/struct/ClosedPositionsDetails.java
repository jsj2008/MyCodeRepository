package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class ClosedPositionsDetails extends allone.json.AbstractJsonData {

	public static final String jsonId = "33";

	public static final String ticket = "1";
	public static final String instrument = "2";
	public static final String account = "3";
	public static final String lots = "4";
	public static final String openPrice = "5";
	public static final String closePrice = "6";
	public static final String currency = "7";
	public static final String commision_4open = "8";
	public static final String commision_4openInBasicCur = "9";
	public static final String openCommision_currency = "10";
	public static final String commision_4Close = "11";
	public static final String commision_4CloseInBasicCur = "12";
	public static final String closeCommision_currency = "13";
	public static final String rollover = "14";
	public static final String rolloverInBasicCur = "15";
	public static final String profitLoss = "16";
	public static final String profitLossInBasicCur = "17";
	public static final String openTime = "18";
	public static final String oOrderID = "19";
	public static final String oOsplitNo = "20";
	public static final String closeTime = "21";
	public static final String reason = "22";
	public static final String cOrderId = "23";
	public static final String cOsplitNo = "24";
	public static final String openGroup = "25";
	public static final String closeGroup = "26";
	public static final String isOpenUptrade = "27";
	public static final String isCloseUptrade = "28";
	public static final String openRoleType = "29";
	public static final String openName = "30";
	public static final String openIpAddress = "31";
	public static final String closeRoleType = "32";
	public static final String closeName = "33";
	public static final String closeIpAddress = "34";
	
	public static final String oriOpenPrice = "35";
	public static final String realizedPL = "36";
	public static final String lastPL = "37";
	public static final String realizedRollover = "38";
	public static final String tradePL = "39";

	public ClosedPositionsDetails(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTicket() {
		try {
			String data=getEntryString(ClosedPositionsDetails.ticket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTicket(String ticket) {
		setEntry(ClosedPositionsDetails.ticket, ticket);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(ClosedPositionsDetails.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(ClosedPositionsDetails.instrument, instrument);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(ClosedPositionsDetails.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(ClosedPositionsDetails.account, account);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(ClosedPositionsDetails.lots, lots);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(ClosedPositionsDetails.openPrice, openPrice);
	}

	public double getClosePrice() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.closePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setClosePrice(double closePrice) {
		setEntry(ClosedPositionsDetails.closePrice, closePrice);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(ClosedPositionsDetails.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(ClosedPositionsDetails.currency, currency);
	}

	public double getCommision_4open() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.commision_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4open(double commision_4open) {
		setEntry(ClosedPositionsDetails.commision_4open, commision_4open);
	}

	public double getCommision_4openInBasicCur() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.commision_4openInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4openInBasicCur(double commision_4openInBasicCur) {
		setEntry(ClosedPositionsDetails.commision_4openInBasicCur, commision_4openInBasicCur);
	}

	public String getOpenCommision_currency() {
		try {
			String data=getEntryString(ClosedPositionsDetails.openCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenCommision_currency(String openCommision_currency) {
		setEntry(ClosedPositionsDetails.openCommision_currency, openCommision_currency);
	}

	public double getCommision_4Close() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.commision_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4Close(double commision_4Close) {
		setEntry(ClosedPositionsDetails.commision_4Close, commision_4Close);
	}

	public double getCommision_4CloseInBasicCur() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.commision_4CloseInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4CloseInBasicCur(double commision_4CloseInBasicCur) {
		setEntry(ClosedPositionsDetails.commision_4CloseInBasicCur, commision_4CloseInBasicCur);
	}

	public String getCloseCommision_currency() {
		try {
			String data=getEntryString(ClosedPositionsDetails.closeCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseCommision_currency(String closeCommision_currency) {
		setEntry(ClosedPositionsDetails.closeCommision_currency, closeCommision_currency);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(ClosedPositionsDetails.rollover, rollover);
	}

	public double getRolloverInBasicCur() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.rolloverInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRolloverInBasicCur(double rolloverInBasicCur) {
		setEntry(ClosedPositionsDetails.rolloverInBasicCur, rolloverInBasicCur);
	}

	public double getProfitLoss() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.profitLoss);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setProfitLoss(double profitLoss) {
		setEntry(ClosedPositionsDetails.profitLoss, profitLoss);
	}

	public double getProfitLossInBasicCur() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.profitLossInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setProfitLossInBasicCur(double profitLossInBasicCur) {
		setEntry(ClosedPositionsDetails.profitLossInBasicCur, profitLossInBasicCur);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(ClosedPositionsDetails.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(ClosedPositionsDetails.openTime, openTime);
	}

	public long getOOrderID() {
		try {
			long data=getEntryLong(ClosedPositionsDetails.oOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOOrderID(long oOrderID) {
		setEntry(ClosedPositionsDetails.oOrderID, oOrderID);
	}

	public int getOOsplitNo() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.oOsplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOOsplitNo(int oOsplitNo) {
		setEntry(ClosedPositionsDetails.oOsplitNo, oOsplitNo);
	}

	public Date getCloseTime() {
		try {
			Date data=getEntryDate(ClosedPositionsDetails.closeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTime(Date closeTime) {
		setEntry(ClosedPositionsDetails.closeTime, closeTime);
	}

	public int getReason() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.reason);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReason(int reason) {
		setEntry(ClosedPositionsDetails.reason, reason);
	}

	public long getCOrderId() {
		try {
			long data=getEntryLong(ClosedPositionsDetails.cOrderId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCOrderId(long cOrderId) {
		setEntry(ClosedPositionsDetails.cOrderId, cOrderId);
	}

	public int getCOsplitNo() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.cOsplitNo);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCOsplitNo(int cOsplitNo) {
		setEntry(ClosedPositionsDetails.cOsplitNo, cOsplitNo);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(ClosedPositionsDetails.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(ClosedPositionsDetails.openGroup, openGroup);
	}

	public String getCloseGroup() {
		try {
			String data=getEntryString(ClosedPositionsDetails.closeGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseGroup(String closeGroup) {
		setEntry(ClosedPositionsDetails.closeGroup, closeGroup);
	}

	public int getIsOpenUptrade() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.isOpenUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsOpenUptrade(int isOpenUptrade) {
		setEntry(ClosedPositionsDetails.isOpenUptrade, isOpenUptrade);
	}

	public int getIsCloseUptrade() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.isCloseUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCloseUptrade(int isCloseUptrade) {
		setEntry(ClosedPositionsDetails.isCloseUptrade, isCloseUptrade);
	}

	public int getOpenRoleType() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.openRoleType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenRoleType(int openRoleType) {
		setEntry(ClosedPositionsDetails.openRoleType, openRoleType);
	}

	public String getOpenName() {
		try {
			String data=getEntryString(ClosedPositionsDetails.openName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenName(String openName) {
		setEntry(ClosedPositionsDetails.openName, openName);
	}

	public String getOpenIpAddress() {
		try {
			String data=getEntryString(ClosedPositionsDetails.openIpAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenIpAddress(String openIpAddress) {
		setEntry(ClosedPositionsDetails.openIpAddress, openIpAddress);
	}

	public int getCloseRoleType() {
		try {
			int data=getEntryInt(ClosedPositionsDetails.closeRoleType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseRoleType(int closeRoleType) {
		setEntry(ClosedPositionsDetails.closeRoleType, closeRoleType);
	}

	public String getCloseName() {
		try {
			String data=getEntryString(ClosedPositionsDetails.closeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseName(String closeName) {
		setEntry(ClosedPositionsDetails.closeName, closeName);
	}

	public String getCloseIpAddress() {
		try {
			String data=getEntryString(ClosedPositionsDetails.closeIpAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseIpAddress(String closeIpAddress) {
		setEntry(ClosedPositionsDetails.closeIpAddress, closeIpAddress);
	}

	public double getOriOpenPrice() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.oriOpenPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriOpenPrice(double oriOpenPrice) {
		setEntry(ClosedPositionsDetails.oriOpenPrice, oriOpenPrice);
	}
	
	public double getRealizedPL() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.realizedPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedPL(double realizedPL) {
		setEntry(ClosedPositionsDetails.realizedPL, realizedPL);
	}
	
	public double getLastPL() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.lastPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setlastPL(double lastPL) {
		setEntry(ClosedPositionsDetails.lastPL, lastPL);
	}
	
	public double getRealizedRollover() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.realizedRollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedRollover(double realizedRollover) {
		setEntry(ClosedPositionsDetails.realizedRollover, realizedRollover);
	}
	
	public double getTradePL() {
		try {
			double data=getEntryDouble(ClosedPositionsDetails.tradePL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradePL(double tradePL) {
		setEntry(ClosedPositionsDetails.tradePL, tradePL);
	}

}