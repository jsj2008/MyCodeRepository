package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.bankserver.comm.struct.BankOrder;
import allone.json.AbstractJsonData;

public class C3_BankOrder extends AbstractJsonData {
	public static final String jsonId = "BankOrder";

	// 定单属性
	public static final String orderID = "1";
	public static final String bankID = "2";
	public static final String type = "3";
	public static final String tradeDay = "4";
	public static final String orderTime = "5";
	public static final String currency = "6";
	public static final String amount = "7";
	public static final String origin = "8";
	// 账户属性
	public static final String account = "9";
	public static final String aeid = "10";
	public static final String userName = "11";
	public static final String comment = "12";
	public static final String ipAddr = "13";
	// 定单状态
	public static final String state = "14";
	public static final String errorCode = "15";
	public static final String errorMsg = "16";
	// 审核操作员信息
	public static final String auditRemark = "17";

	public static final String notified = "18"; // 从交易所通知到经纪会员的标记
	public static final String dwFee = "19"; // 首次出入金的费用

	// //新增字段StateTime，记录状态变更时间2015-2-3 juyi/////
	public static final String stateTime = "20";
	// //新增字段finalTime，记录订单 最终确认时间 2015-04-21 Wang.jingjing/////
	public static final String finalTime = "21";

	public static final String marketId = "22";

	public C3_BankOrder() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(BankOrder data) throws Exception {
		setOrderID(data.getOrderID());
		setBankID(data.getBankID());
		setType(data.getType());
		setTradeDay(data.getTradeDay());
		setOrderTime(data.getOrderTime());
		setCurrency(data.getCurrency());
		setAmount(data.getAmount());
		setOrigin(data.getOrigin());
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setUserName(data.getUserName());
		setComment(data.getComment());
		setIpAddr(data.getIpAddr());
		setState(data.getState());
		setErrorCode(data.getErrorCode());
		setErrorMsg(data.getErrorMsg());
		setAuditRemark(data.getAuditRemark());
		setNotified(data.getNotified());
		setDwFee(data.getDWFee());
		setStateTime(data.getStateTime());
		setFinalTime(data.getFinalTime());
		setMarketID(data.getMarketId());
	}

	public BankOrder format() {
		BankOrder data = new BankOrder();
		data.setOrderID(getOrderID());
		data.setBankID(getBankID());
		data.setType(getType());
		data.setTradeDay(getTradeDay());
		data.setOrderTime(getOrderTime());
		data.setCurrency(getCurrency());
		data.setAmount(getAmount());
		data.setOrigin(getOrigin());
		data.setAccount(getAccount());
		data.setAeid(getAeid());
		data.setUserName(getUserName());
		data.setComment(getComment());
		data.setIpAddr(getIpAddr());
		data.setState(getState());
		data.setErrorCode(getErrorCode());
		data.setErrorMsg(getErrorMsg());
		data.setAuditRemark(getAuditRemark());
		data.setNotified(getNotified());
		data.setDWFee(getDwFee());
		data.setStateTime(getStateTime());
		data.setFinalTime(getFinalTime());
		data.setMarketId(getMarketID());
		return data;
	}

	public long getOrderID() {
		try {
			long data = getEntryLong(C3_BankOrder.orderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderID(long orderID) {
		setEntry(C3_BankOrder.orderID, orderID);
	}

	public String getBankID() {
		try {
			String data = getEntryString(C3_BankOrder.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(C3_BankOrder.bankID, bankID);
	}

	public String getType() {
		try {
			String data = getEntryString(C3_BankOrder.type);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setType(String type) {
		setEntry(C3_BankOrder.type, type);
	}

	public String getTradeDay() {
		try {
			String data = getEntryString(C3_BankOrder.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_BankOrder.tradeDay, tradeDay);
	}

	public Date getOrderTime() {
		try {
			Date data = getEntryDate(C3_BankOrder.orderTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderTime(Date orderTime) {
		setEntry(C3_BankOrder.orderTime, orderTime);
	}

	public String getCurrency() {
		try {
			String data = getEntryString(C3_BankOrder.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_BankOrder.currency, currency);
	}

	public double getAmount() {
		try {
			double data = getEntryDouble(C3_BankOrder.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_BankOrder.amount, amount);
	}

	public String getOrigin() {
		try {
			String data = getEntryString(C3_BankOrder.origin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrigin(String origin) {
		setEntry(C3_BankOrder.origin, origin);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_BankOrder.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_BankOrder.account, account);
	}

	public String getAeid() {
		try {
			String data = getEntryString(C3_BankOrder.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_BankOrder.aeid, aeid);
	}

	public String getUserName() {
		try {
			String data = getEntryString(C3_BankOrder.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(C3_BankOrder.userName, userName);
	}

	public String getComment() {
		try {
			String data = getEntryString(C3_BankOrder.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String comment) {
		setEntry(C3_BankOrder.comment, comment);
	}

	public String getIpAddr() {
		try {
			String data = getEntryString(C3_BankOrder.ipAddr);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddr(String ipAddr) {
		setEntry(C3_BankOrder.ipAddr, ipAddr);
	}

	public int getState() {
		try {
			int data = getEntryInt(C3_BankOrder.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(C3_BankOrder.state, state);
	}

	public String getErrorCode() {
		try {
			String data = getEntryString(C3_BankOrder.errorCode);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrorCode(String errcode) {
		setEntry(C3_BankOrder.errorCode, errorCode);
	}

	public String getErrorMsg() {
		try {
			String data = getEntryString(C3_BankOrder.errorMsg);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setErrorMsg(String errorMsg) {
		setEntry(C3_BankOrder.errorMsg, errorMsg);
	}

	public String getAuditRemark() {
		try {
			String data = getEntryString(C3_BankOrder.auditRemark);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAuditRemark(String auditRemark) {
		setEntry(C3_BankOrder.auditRemark, auditRemark);
	}

	public boolean getNotified() {
		try {
			boolean data = getEntryBoolean(C3_BankOrder.notified);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNotified(boolean notified) {
		setEntry(C3_BankOrder.notified, notified);
	}

	public double getDwFee() {
		try {
			double data = getEntryDouble(C3_BankOrder.dwFee);
			return data;
		} catch (RuntimeException e) {
			return 0.0;
		}
	}

	public void setDwFee(double dwFee) {
		setEntry(C3_BankOrder.dwFee, dwFee);
	}

	public Date getStateTime() {
		try {
			Date data = getEntryDate(C3_BankOrder.stateTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStateTime(Date stateTime) {
		setEntry(C3_BankOrder.stateTime, stateTime);
	}

	public Date getFinalTime() {
		try {
			Date data = getEntryDate(C3_BankOrder.finalTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFinalTime(Date finalTime) {
		setEntry(C3_BankOrder.finalTime, finalTime);
	}

	public int getMarketID() {
		try {
			int data = getEntryInt(C3_BankOrder.marketId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketID(int marketID) {
		setEntry(C3_BankOrder.marketId, marketID);
	}
}
