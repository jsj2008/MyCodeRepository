package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.AccountStrategy;

public class C3_AccountStrategy extends allone.json.AbstractJsonData {

	public static final String jsonId = "2";

	public static final String firstTradeTime = "1";
	public static final String IBAC = "2";
	public static final String lastTradeTime = "3";
	public static final String NOPL = "4";
	public static final String openTime = "5";
	public static final String acName = "6";
	public static final String account = "7";
	public static final String aeid = "8";
	public static final String balanceWay = "9";
	public static final String basicCurrency = "10";
	public static final String chargeStrategeID = "11";
	public static final String groupName = "12";
	public static final String isDead = "13";
	public static final String isIBAuthorized = "14";
	public static final String isTradeable = "15";
	public static final String isUptrade = "16";
	public static final String openTradeDay = "17";
	public static final String tradeCtrlStrategyId = "18";

	public static final String upTradeMagnifacation = "19";
	public static final String fundDividendType = "20";

	// 银行综合会员号,qiulinhe-2016年8月15日18:05:58
	public static final String marketId = "21";

	/**
	 * niuqq 2015-8-11 用来判断是否是经济类会员，若是则有开户和分佣的权限 0:不是 1：是
	 */
	public static final String isSuperIB = "22";
	/**
	 * niuqq 2015-8-12 一级经纪人的佣金比例（暂为占MTP比例的百分比）
	 */
	public static final String IBPercent = "23";

	public C3_AccountStrategy() {
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(AccountStrategy data) throws Exception {
		setFirstTradeTime(data.getFirstTradeTime());
		setIBAC(data.getIBAC());
		setLastTradeTime(data.getLastTradeTime());
		setNOPL(data.getNOPL());
		setOpenTime(data.getOpenTime());
		setAcName(data.getAcName());
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setBalanceWay(data.getBalanceWay());
		setBasicCurrency(data.getBasicCurrency());
		setChargeStrategeID(data.getChargeStrategeID());
		setGroupName(data.getGroupName());
		setIsDead(data.getIsDead());
		setIsIBAuthorized(data.getIsIBAuthorized());
		setIsTradeable(data.getIsTradeable());
		setIsUptrade(data.getIsUptrade());
		setOpenTradeDay(data.getOpenTradeDay());
		setTradeCtrlStrategyId(data.getTradeCtrlStrategyId());

		setUpTradeMagnifacation(data.getUpTradeMagnifacation());
		setFundDividendType(data.getFundDividendType());

		setMarketId(data.getMarketId());
		setIsSuperIB(data.getIsSuperIB());
		setIBPercent(data.getIBPercent());
	}

	public AccountStrategy format() {
		AccountStrategy data = new AccountStrategy();
		data.setFirstTradeTime(getFirstTradeTime());
		data.setIBAC(getIBAC());
		data.setLastTradeTime(getLastTradeTime());
		data.setNOPL(getNOPL());
		data.setOpenTime(getOpenTime());
		data.setAcName(getAcName());
		data.setAccount(getAccount());
		data.setAeid(getAeid());
		data.setBalanceWay(getBalanceWay());
		data.setBasicCurrency(getBasicCurrency());
		data.setChargeStrategeID(getChargeStrategeID());
		data.setGroupName(getGroupName());
		data.setIsDead(getIsDead());
		data.setIsIBAuthorized(getIsIBAuthorized());
		data.setIsTradeable(getIsTradeable());
		data.setIsUptrade(getIsUptrade());
		data.setOpenTradeDay(getOpenTradeDay());
		data.setTradeCtrlStrategyId(getTradeCtrlStrategyId());

		data.setUpTradeMagnifacation(getUpTradeMagnifacation());
		data.setFundDividendType(getFundDividendType());

		data.setMarketId(getMarketId());
		data.setIsSuperIB(getIsSuperIB());
		data.setIBPercent(getIBPercent());
		return data;
	}

	public Date getFirstTradeTime() {
		try {
			Date data = getEntryDate(C3_AccountStrategy.firstTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		setEntry(C3_AccountStrategy.firstTradeTime, firstTradeTime);
	}

	public long getIBAC() {
		try {
			long data = getEntryLong(C3_AccountStrategy.IBAC);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBAC(long IBAC) {
		setEntry(C3_AccountStrategy.IBAC, IBAC);
	}

	public Date getLastTradeTime() {
		try {
			Date data = getEntryDate(C3_AccountStrategy.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradeTime(Date lastTradeTime) {
		setEntry(C3_AccountStrategy.lastTradeTime, lastTradeTime);
	}

	public int getNOPL() {
		try {
			int data = getEntryInt(C3_AccountStrategy.NOPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNOPL(int NOPL) {
		setEntry(C3_AccountStrategy.NOPL, NOPL);
	}

	public Date getOpenTime() {
		try {
			Date data = getEntryDate(C3_AccountStrategy.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(C3_AccountStrategy.openTime, openTime);
	}

	public String getAcName() {
		try {
			String data = getEntryString(C3_AccountStrategy.acName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAcName(String acName) {
		setEntry(C3_AccountStrategy.acName, acName);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(C3_AccountStrategy.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_AccountStrategy.account, account);
	}

	public String getAeid() {
		try {
			String data = getEntryString(C3_AccountStrategy.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_AccountStrategy.aeid, aeid);
	}

	public int getBalanceWay() {
		try {
			int data = getEntryInt(C3_AccountStrategy.balanceWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBalanceWay(int balanceWay) {
		setEntry(C3_AccountStrategy.balanceWay, balanceWay);
	}

	public String getBasicCurrency() {
		try {
			String data = getEntryString(C3_AccountStrategy.basicCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBasicCurrency(String basicCurrency) {
		setEntry(C3_AccountStrategy.basicCurrency, basicCurrency);
	}

	public String getChargeStrategeID() {
		try {
			String data = getEntryString(C3_AccountStrategy.chargeStrategeID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setChargeStrategeID(String chargeStrategeID) {
		setEntry(C3_AccountStrategy.chargeStrategeID, chargeStrategeID);
	}

	public String getGroupName() {
		try {
			String data = getEntryString(C3_AccountStrategy.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_AccountStrategy.groupName, groupName);
	}

	public int getIsDead() {
		try {
			int data = getEntryInt(C3_AccountStrategy.isDead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsDead(int isDead) {
		setEntry(C3_AccountStrategy.isDead, isDead);
	}

	public int getIsIBAuthorized() {
		try {
			int data = getEntryInt(C3_AccountStrategy.isIBAuthorized);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsIBAuthorized(int isIBAuthorized) {
		setEntry(C3_AccountStrategy.isIBAuthorized, isIBAuthorized);
	}

	public int getIsTradeable() {
		try {
			int data = getEntryInt(C3_AccountStrategy.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(C3_AccountStrategy.isTradeable, isTradeable);
	}

	public int getIsUptrade() {
		try {
			int data = getEntryInt(C3_AccountStrategy.isUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsUptrade(int isUptrade) {
		setEntry(C3_AccountStrategy.isUptrade, isUptrade);
	}

	public String getOpenTradeDay() {
		try {
			String data = getEntryString(C3_AccountStrategy.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(C3_AccountStrategy.openTradeDay, openTradeDay);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data = getEntryString(C3_AccountStrategy.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(C3_AccountStrategy.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}

	public double getUpTradeMagnifacation() {
		try {
			double data = getEntryDouble(C3_AccountStrategy.upTradeMagnifacation);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUpTradeMagnifacation(double upTradeMagnifacation) {
		setEntry(C3_AccountStrategy.upTradeMagnifacation, upTradeMagnifacation);
	}

	public int getFundDividendType() {
		try {
			int data = getEntryInt(C3_AccountStrategy.fundDividendType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundDividendType(int fundDividendType) {
		setEntry(C3_AccountStrategy.fundDividendType, fundDividendType);
	}

	public int getMarketId() {
		try {
			int data = getEntryInt(C3_AccountStrategy.marketId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		setEntry(C3_AccountStrategy.marketId, marketId);
	}

	public int getIsSuperIB() {
		try {
			int data = getEntryInt(C3_AccountStrategy.isSuperIB);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsSuperIB(int isSuperIB) {
		setEntry(C3_AccountStrategy.isSuperIB, isSuperIB);
	}

	public double getIBPercent() {
		try {
			double data = getEntryDouble(C3_AccountStrategy.IBPercent);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBPercent(double isSuperIB) {
		setEntry(C3_AccountStrategy.IBPercent, IBPercent);
	}
}