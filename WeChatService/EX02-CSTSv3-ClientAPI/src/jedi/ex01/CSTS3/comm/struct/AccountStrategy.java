package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.AccountStore;

public class AccountStrategy extends allone.json.AbstractJsonData {

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

	public AccountStrategy() {
		super();
		setEntry("jsonId", jsonId);
	}

	public Date getFirstTradeTime() {
		try {
			Date data = getEntryDate(AccountStrategy.firstTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstTradeTime(Date firstTradeTime) {
		setEntry(AccountStrategy.firstTradeTime, firstTradeTime);
	}

	public long getIBAC() {
		try {
			long data = getEntryLong(AccountStrategy.IBAC);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBAC(long IBAC) {
		setEntry(AccountStrategy.IBAC, IBAC);
	}

	public Date getLastTradeTime() {
		try {
			Date data = getEntryDate(AccountStrategy.lastTradeTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastTradeTime(Date lastTradeTime) {
		setEntry(AccountStrategy.lastTradeTime, lastTradeTime);
	}

	public int getNOPL() {
		try {
			int data = getEntryInt(AccountStrategy.NOPL);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNOPL(int NOPL) {
		setEntry(AccountStrategy.NOPL, NOPL);
	}

	public Date getOpenTime() {
		try {
			Date data = getEntryDate(AccountStrategy.openTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTime(Date openTime) {
		setEntry(AccountStrategy.openTime, openTime);
	}

	public String getAcName() {
		try {
			String data = getEntryString(AccountStrategy.acName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAcName(String acName) {
		setEntry(AccountStrategy.acName, acName);
	}

	public long getAccount() {
		try {
			long data = getEntryLong(AccountStrategy.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(AccountStrategy.account, account);
	}

	public String getAeid() {
		try {
			String data = getEntryString(AccountStrategy.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(AccountStrategy.aeid, aeid);
	}

	public int getBalanceWay() {
		try {
			int data = getEntryInt(AccountStrategy.balanceWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setBalanceWay(int balanceWay) {
		setEntry(AccountStrategy.balanceWay, balanceWay);
	}

	public String getBasicCurrency() {
		try {
			String data = getEntryString(AccountStrategy.basicCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBasicCurrency(String basicCurrency) {
		setEntry(AccountStrategy.basicCurrency, basicCurrency);
	}

	public String getChargeStrategeID() {
		try {
			String data = getEntryString(AccountStrategy.chargeStrategeID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setChargeStrategeID(String chargeStrategeID) {
		setEntry(AccountStrategy.chargeStrategeID, chargeStrategeID);
	}

	public String getGroupName() {
		try {
			String data = getEntryString(AccountStrategy.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(AccountStrategy.groupName, groupName);
	}

	public int getIsDead() {
		try {
			int data = getEntryInt(AccountStrategy.isDead);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsDead(int isDead) {
		setEntry(AccountStrategy.isDead, isDead);
	}

	public int getIsIBAuthorized() {
		try {
			int data = getEntryInt(AccountStrategy.isIBAuthorized);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsIBAuthorized(int isIBAuthorized) {
		setEntry(AccountStrategy.isIBAuthorized, isIBAuthorized);
	}

	public int getIsTradeable() {
		try {
			int data = getEntryInt(AccountStrategy.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(AccountStrategy.isTradeable, isTradeable);
	}

	public int getIsUptrade() {
		try {
			int data = getEntryInt(AccountStrategy.isUptrade);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsUptrade(int isUptrade) {
		setEntry(AccountStrategy.isUptrade, isUptrade);
	}

	public String getOpenTradeDay() {
		try {
			String data = getEntryString(AccountStrategy.openTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOpenTradeDay(String openTradeDay) {
		setEntry(AccountStrategy.openTradeDay, openTradeDay);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data = getEntryString(AccountStrategy.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(AccountStrategy.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}

	public double getUpTradeMagnifacation() {
		try {
			double data = getEntryDouble(AccountStrategy.upTradeMagnifacation);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUpTradeMagnifacation(double upTradeMagnifacation) {
		setEntry(AccountStrategy.upTradeMagnifacation, upTradeMagnifacation);
	}

	public int getFundDividendType() {
		try {
			int data = getEntryInt(AccountStrategy.fundDividendType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundDividendType(int fundDividendType) {
		setEntry(AccountStrategy.fundDividendType, fundDividendType);
	}

	public int getMarketId() {
		try {
			int data = getEntryInt(AccountStrategy.marketId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		setEntry(AccountStrategy.marketId, marketId);
	}

	public int getIsSuperIB() {
		try {
			int data = getEntryInt(AccountStrategy.isSuperIB);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsSuperIB(int isSuperIB) {
		setEntry(AccountStrategy.isSuperIB, isSuperIB);
	}

	public double getIBPercent() {
		try {
			double data = getEntryDouble(AccountStrategy.IBPercent);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIBPercent(double isSuperIB) {
		setEntry(AccountStrategy.IBPercent, IBPercent);
	}

}