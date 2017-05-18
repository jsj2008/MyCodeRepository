package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.bankserver.comm.struct.BankRequestOrder;
import allone.json.AbstractJsonData;

public class C3_BankRequestOrder extends AbstractJsonData {
	public static final String jsonId = "BankRequestOrder";
	// 申请属性
	private static final String requestOrderID = "1";
	private static final String bankRequestOrderID = "2";
	private static final String relativeOrderID = "3";
	private static final String bankID = "4";
	private static final String type = "5";
	private static final String orderRequestTime = "6";
	private static final String currency = "7";
	private static final String amount = "8";
	private static final String origin = "9";

	// 账户属性
	private static final String account = "11";
	private static final String aeid = "12";
	private static final String userName = "13";
	private static final String comment = "14";
	private static final String ipAddr = "15";
	// 其他信息
	private static final String reserve1 = "16";
	private static final String reserve2 = "17";
	private static final String reserve3 = "18";

	// 通知同步标记
	private static final String state = "19";
	private static final String dwFee = "20";

	// membership id number
	private static final String marketId = "21";

	public C3_BankRequestOrder() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(BankRequestOrder data) throws Exception {
		setRequestOrderID(data.getRequestOrderID());
		setBankRequestOrderID(data.getBankRequestOrderID());
		setRelativeOrderID(data.getRelativeOrderID());
		setBankID(data.getBankID());
		setType(data.getType());
		setOrderRequestTime(data.getOrderRequestTime());
		setCurrency(data.getCurrency());
		setAmount(data.getAmount());
		setOrigin(data.getOrigin());
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setUserName(data.getUserName());
		setComment(data.getComment());
		setIpAddr(data.getIpAddr());
		setReserve1(data.getReserve1());
		setReserve2(data.getReserve2());
		setReserve3(data.getReserve3());
		setState(data.getState());
		setDwFee(data.getDwFee());
		setMarketId(data.getMarketId());
	}

	public BankRequestOrder format() {
		BankRequestOrder data = new BankRequestOrder();
		data.setRequestOrderID(getRequestOrderID());
		data.setBankRequestOrderID(getBankRequestOrderID());
		data.setBankID(getBankID());
		data.setType(getType());
		data.setOrderRequestTime(getOrderRequestTime());
		data.setCurrency(getCurrency());
		data.setAmount(getAmount());
		data.setOrigin(getOrigin());
		data.setAccount(getAccount());
		data.setAeid(getAeid());
		data.setUserName(getUserName());
		data.setComment(getComment());
		data.setIpAddr(getIpAddr());
		data.setReserve1(getReserve1());
		data.setReserve2(getReserve2());
		data.setReserve3(getReserve3());
		data.setState(getState());
		data.setDwFee(getDwFee());
		data.setMarketId(getMarketId());
		return data;
	}

	public long getRequestOrderID() {
		try {
			long data = getEntryLong(C3_BankRequestOrder.requestOrderID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setRequestOrderID(long requestOrderID) {
		setEntry(C3_BankRequestOrder.requestOrderID, requestOrderID);
	}

	public String getBankRequestOrderID() {
		try {
			String data = getEntryString(C3_BankRequestOrder.bankRequestOrderID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankRequestOrderID(String bankRequestID) {
		setEntry(C3_BankRequestOrder.bankRequestOrderID, bankRequestID);
	}

	public long getRelativeOrderID() {
		try {
			long data = getEntryLong(C3_BankRequestOrder.relativeOrderID);
			return data;
		} catch (RuntimeException e) {
			return -1;
		}
	}

	public void setRelativeOrderID(long relativeOrderID) {
		setEntry(C3_BankRequestOrder.relativeOrderID, relativeOrderID);
	}

	public String getBankID() {
		try {
			String data = getEntryString(C3_BankRequestOrder.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(C3_BankRequestOrder.bankID, bankID);
	}

	public String getType() {
		try {
			String data = getEntryString(C3_BankRequestOrder.type);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setType(String type) {
		setEntry(C3_BankRequestOrder.type, type);
	}

	public Date getOrderRequestTime() {
		try {
			Date data = getEntryDate(C3_BankRequestOrder.orderRequestTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderRequestTime(Date orderRequestTime) {
		setEntry(C3_BankRequestOrder.orderRequestTime, orderRequestTime);
	}

	public String getCurrency() {
		try {
			String data = getEntryString(C3_BankRequestOrder.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_BankRequestOrder.currency, currency);
	}

	public double getAmount() {
		try {
			double data = getEntryDouble(C3_BankRequestOrder.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_BankRequestOrder.amount, amount);
	}

	public String getOrigin() {
		try {
			String data = getEntryString(C3_BankRequestOrder.origin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrigin(String origin) {
		setEntry(C3_BankRequestOrder.origin, origin);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_BankRequestOrder.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_BankRequestOrder.account, account);
	}

	public String getAeid() {
		try {
			String data = getEntryString(C3_BankRequestOrder.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_BankRequestOrder.aeid, aeid);
	}

	public String getUserName() {
		try {
			String data = getEntryString(C3_BankRequestOrder.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String uerName) {
		setEntry(C3_BankRequestOrder.userName, userName);
	}

	public String getComment() {
		try {
			String data = getEntryString(C3_BankRequestOrder.comment);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setComment(String comment) {
		setEntry(C3_BankRequestOrder.comment, comment);
	}

	public String getIpAddr() {
		try {
			String data = getEntryString(C3_BankRequestOrder.ipAddr);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpAddr(String ipAddr) {
		setEntry(C3_BankRequestOrder.ipAddr, ipAddr);
	}

	public String getReserve1() {
		try {
			String data = getEntryString(C3_BankRequestOrder.reserve1);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve1(String reserve1) {
		setEntry(C3_BankRequestOrder.reserve1, reserve1);
	}

	public String getReserve2() {
		try {
			String data = getEntryString(C3_BankRequestOrder.reserve2);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve2(String reserve2) {
		setEntry(C3_BankRequestOrder.reserve2, reserve2);
	}

	public String getReserve3() {
		try {
			String data = getEntryString(C3_BankRequestOrder.reserve3);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve3(String reserve3) {
		setEntry(C3_BankRequestOrder.reserve3, reserve3);
	}

	public int getState() {
		try {
			int data = getEntryInt(C3_BankRequestOrder.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(C3_BankRequestOrder.state, state);
	}

	public double getDwFee() {
		try {
			double data = getEntryDouble(C3_BankRequestOrder.dwFee);
			return data;
		} catch (RuntimeException e) {
			return 0.0;
		}
	}

	public void setDwFee(double dwFee) {
		setEntry(C3_BankRequestOrder.dwFee, dwFee);
	}

	public int getMarketId() {
		try {
			int data = getEntryInt(C3_BankRequestOrder.marketId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		setEntry(C3_BankRequestOrder.marketId, marketId);
	}
}
