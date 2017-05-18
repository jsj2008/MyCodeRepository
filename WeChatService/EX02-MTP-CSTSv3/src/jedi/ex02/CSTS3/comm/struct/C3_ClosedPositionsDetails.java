package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.report.server.struct.ClosedPositionsDetails;

public class C3_ClosedPositionsDetails extends allone.json.AbstractJsonData {

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
	public static final String closeTime = "21";
	public static final String reason = "22";
	public static final String cOrderId = "23";
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

	public C3_ClosedPositionsDetails(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(ClosedPositionsDetails data) throws Exception {
		setTicket(data.getTicket());
		setInstrument(data.getInstrument());
		setAccount(data.getAccount());
		setLots(data.getLots());
		setOpenPrice(data.getOpenPrice());
		setClosePrice(data.getClosePrice());
		setCurrency(data.getCurrency());
		setCommision_4open(data.getCommision_4open());
		setCommision_4openInBasicCur(data.getCommision_4openInBasicCur());
		setOpenCommision_currency(data.getOpenCommision_currency());
		setCommision_4Close(data.getCommision_4Close());
		setCommision_4CloseInBasicCur(data.getCommision_4CloseInBasicCur());
		setCloseCommision_currency(data.getCloseCommision_currency());
		setRollover(data.getRollover());
		setRolloverInBasicCur(data.getRolloverInBasicCur());
		setProfitLoss(data.getProfitLoss());
		setProfitLossInBasicCur(data.getProfitLossInBasicCur());
		setOpenTime(data.getOpenTime());
		setOOrderID(data.getOOrderID());
		setCloseTime(data.getCloseTime());
		setReason(data.getIntReason());
		setCOrderId(data.getCOrderId());
		setOpenGroup(data.getOpenGroup());
		setCloseGroup(data.getCloseGroup());
		setIsOpenUptrade(data.getIsOpenUptrade());
		setIsCloseUptrade(data.getIsCloseUptrade());
		setOpenRoleType(data.getOpenRoleType());
		setOpenName(data.getOpenName());
		setOpenIpAddress(data.getOpenIpAddress());
		setCloseRoleType(data.getCloseRoleType());
		setCloseName(data.getCloseName());
		setCloseIpAddress(data.getCloseIpAddress());
		
		setOriOpenPrice(data.getOriOpenPrice());
		setRealizedPL(data.getRealizedPL());
		setlastPL(data.getLastPL());
		setRealizedRollover(data.getRealizedRollover());
		setTradePL(data.getTradePL());
	}

	public ClosedPositionsDetails format(){
		ClosedPositionsDetails data=new ClosedPositionsDetails();
		
		return data;
	}


	public String getTicket() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.ticket);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTicket(String ticket) {
		setEntry(C3_ClosedPositionsDetails.ticket, ticket);
	}

	public String getInstrument() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.instrument);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrument(String instrument) {
		setEntry(C3_ClosedPositionsDetails.instrument, instrument);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_ClosedPositionsDetails.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_ClosedPositionsDetails.account, account);
	}

	public double getLots() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.lots);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLots(double lots) {
		setEntry(C3_ClosedPositionsDetails.lots, lots);
	}

	public double getOpenPrice() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.openPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenPrice(double openPrice) {
		setEntry(C3_ClosedPositionsDetails.openPrice, openPrice);
	}

	public double getClosePrice() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.closePrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setClosePrice(double closePrice) {
		setEntry(C3_ClosedPositionsDetails.closePrice, closePrice);
	}

	public String getCurrency() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_ClosedPositionsDetails.currency, currency);
	}

	public double getCommision_4open() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.commision_4open);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4open(double commision_4open) {
		setEntry(C3_ClosedPositionsDetails.commision_4open, commision_4open);
	}

	public double getCommision_4openInBasicCur() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.commision_4openInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4openInBasicCur(double commision_4openInBasicCur) {
		setEntry(C3_ClosedPositionsDetails.commision_4openInBasicCur, commision_4openInBasicCur);
	}

	public String getOpenCommision_currency() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.openCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenCommision_currency(String openCommision_currency) {
		setEntry(C3_ClosedPositionsDetails.openCommision_currency, openCommision_currency);
	}

	public double getCommision_4Close() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.commision_4Close);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4Close(double commision_4Close) {
		setEntry(C3_ClosedPositionsDetails.commision_4Close, commision_4Close);
	}

	public double getCommision_4CloseInBasicCur() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.commision_4CloseInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCommision_4CloseInBasicCur(double commision_4CloseInBasicCur) {
		setEntry(C3_ClosedPositionsDetails.commision_4CloseInBasicCur, commision_4CloseInBasicCur);
	}

	public String getCloseCommision_currency() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.closeCommision_currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseCommision_currency(String closeCommision_currency) {
		setEntry(C3_ClosedPositionsDetails.closeCommision_currency, closeCommision_currency);
	}

	public double getRollover() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.rollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRollover(double rollover) {
		setEntry(C3_ClosedPositionsDetails.rollover, rollover);
	}

	public double getRolloverInBasicCur() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.rolloverInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRolloverInBasicCur(double rolloverInBasicCur) {
		setEntry(C3_ClosedPositionsDetails.rolloverInBasicCur, rolloverInBasicCur);
	}

	public double getProfitLoss() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.profitLoss);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setProfitLoss(double profitLoss) {
		setEntry(C3_ClosedPositionsDetails.profitLoss, profitLoss);
	}

	public double getProfitLossInBasicCur() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.profitLossInBasicCur);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setProfitLossInBasicCur(double profitLossInBasicCur) {
		setEntry(C3_ClosedPositionsDetails.profitLossInBasicCur, profitLossInBasicCur);
	}

	public Date getOpenTime() {
		try {
			Date data=getEntryDate(C3_ClosedPositionsDetails.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(C3_ClosedPositionsDetails.openTime, openTime);
	}

	public String getOOrderID() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.oOrderID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOOrderID(String oOrderID) {
		setEntry(C3_ClosedPositionsDetails.oOrderID, oOrderID);
	}

	public Date getCloseTime() {
		try {
			Date data=getEntryDate(C3_ClosedPositionsDetails.closeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseTime(Date closeTime) {
		setEntry(C3_ClosedPositionsDetails.closeTime, closeTime);
	}

	public int getReason() {
		try {
			int data=getEntryInt(C3_ClosedPositionsDetails.reason);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReason(int reason) {
		setEntry(C3_ClosedPositionsDetails.reason, reason);
	}

	public String getCOrderId() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.cOrderId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCOrderId(String cOrderId) {
		setEntry(C3_ClosedPositionsDetails.cOrderId, cOrderId);
	}

	public String getOpenGroup() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.openGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenGroup(String openGroup) {
		setEntry(C3_ClosedPositionsDetails.openGroup, openGroup);
	}

	public String getCloseGroup() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.closeGroup);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseGroup(String closeGroup) {
		setEntry(C3_ClosedPositionsDetails.closeGroup, closeGroup);
	}

	public int getIsOpenUptrade() {
		try {
			int data=getEntryInt(C3_ClosedPositionsDetails.isOpenUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsOpenUptrade(int isOpenUptrade) {
		setEntry(C3_ClosedPositionsDetails.isOpenUptrade, isOpenUptrade);
	}

	public int getIsCloseUptrade() {
		try {
			int data=getEntryInt(C3_ClosedPositionsDetails.isCloseUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCloseUptrade(int isCloseUptrade) {
		setEntry(C3_ClosedPositionsDetails.isCloseUptrade, isCloseUptrade);
	}

	public int getOpenRoleType() {
		try {
			int data=getEntryInt(C3_ClosedPositionsDetails.openRoleType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenRoleType(int openRoleType) {
		setEntry(C3_ClosedPositionsDetails.openRoleType, openRoleType);
	}

	public String getOpenName() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.openName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenName(String openName) {
		setEntry(C3_ClosedPositionsDetails.openName, openName);
	}

	public String getOpenIpAddress() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.openIpAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenIpAddress(String openIpAddress) {
		setEntry(C3_ClosedPositionsDetails.openIpAddress, openIpAddress);
	}

	public int getCloseRoleType() {
		try {
			int data=getEntryInt(C3_ClosedPositionsDetails.closeRoleType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseRoleType(int closeRoleType) {
		setEntry(C3_ClosedPositionsDetails.closeRoleType, closeRoleType);
	}

	public String getCloseName() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.closeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseName(String closeName) {
		setEntry(C3_ClosedPositionsDetails.closeName, closeName);
	}

	public String getCloseIpAddress() {
		try {
			String data=getEntryString(C3_ClosedPositionsDetails.closeIpAddress);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCloseIpAddress(String closeIpAddress) {
		setEntry(C3_ClosedPositionsDetails.closeIpAddress, closeIpAddress);
	}
	
	public double getOriOpenPrice() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.oriOpenPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOriOpenPrice(double oriOpenPrice) {
		setEntry(C3_ClosedPositionsDetails.oriOpenPrice, oriOpenPrice);
	}
	
	public double getRealizedPL() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.realizedPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedPL(double realizedPL) {
		setEntry(C3_ClosedPositionsDetails.realizedPL, realizedPL);
	}
	
	public double getLastPL() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.lastPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setlastPL(double lastPL) {
		setEntry(C3_ClosedPositionsDetails.lastPL, lastPL);
	}
	
	public double getRealizedRollover() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.realizedRollover);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRealizedRollover(double realizedRollover) {
		setEntry(C3_ClosedPositionsDetails.realizedRollover, realizedRollover);
	}
	
	public double getTradePL() {
		try {
			double data=getEntryDouble(C3_ClosedPositionsDetails.tradePL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setTradePL(double tradePL) {
		setEntry(C3_ClosedPositionsDetails.tradePL, tradePL);
	}


}