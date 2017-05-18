package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_AccountStrategy;
import jedi.ex02.CSTS3.comm.struct.C3_BasicCurrency;
import jedi.ex02.CSTS3.comm.struct.C3_BatchRateGap;
import jedi.ex02.CSTS3.comm.struct.C3_GroupConfig;
import jedi.ex02.CSTS3.comm.struct.C3_InstTypeTree;
import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.ex02.CSTS3.comm.struct.C3_InstrumentListed;
import jedi.ex02.CSTS3.comm.struct.C3_InstrumentType;
import jedi.ex02.CSTS3.comm.struct.C3_LangPack;
import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.ex02.CSTS3.comm.struct.C3_OtherClientConfig;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.struct.C3_SystemConfig;
import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_TTrade4CFD;
import jedi.ex02.CSTS3.comm.struct.C3_UserLogin;
import jedi.v7.comm.datastruct.DB.AccountStrategy;
import jedi.v7.comm.datastruct.DB.GroupConfig;
import jedi.v7.ctrl.comm.IPOP.OP_CTRL2001;
import jedi.v7.ctrl.comm.IPOP.OP_CTRL2002;
import jedi.v7.quote.common.QuoteData;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5030;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5040;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5041;

public class C3_OP_Web1001 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_Web1001";

	public static final String userLogin = "1";
	public static final String account = "2";
	public static final String moneyaccounts = "3";
	public static final String systemConfig = "4";
	public static final String currencys = "5";
	public static final String instruments = "6";
	public static final String orders = "7";
	public static final String trades = "8";
	public static final String instTypeTrees = "9";
	public static final String langPack = "10";
	public static final String instrumentTypes = "11";
	// public static final String tradeTypeConfigs = "12";
	public static final String otherClientConfigVec = "13";
	public static final String batchRateGaps = "14";
	public static final String group = "15";
	public static final String quoteList = "16";
	public static final String timeZone = "17";
	public static final String instrumentListed = "18";
	public static final String oriInstrumentListed = "19";

	public C3_OP_Web1001(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(QuoteData[] data) throws Exception {
		C3_QuoteData[] quoteList = new C3_QuoteData[data.length];
		for (int i = 0; i < data.length; i++) {
			quoteList[i] = new C3_QuoteData();
			quoteList[i].parseFromSysData((QuoteData) data[i]);
		}
		setQuoteList(quoteList);
	}

	public void parseFromSysData(OP_TRADESERV5041 data) throws Exception {
		C3_MoneyAccount[] moneyaccounts = new C3_MoneyAccount[data
				.getMoneyAccountVec().length];
		for (int i = 0; i < data.getMoneyAccountVec().length; i++) {
			moneyaccounts[i] = new C3_MoneyAccount();
			moneyaccounts[i].parseFromSysData(data.getMoneyAccountVec()[i]);
		}
		setMoneyaccounts(moneyaccounts);
		C3_TOrders4CFD[] orders = new C3_TOrders4CFD[data.getOrder4CFDVec().length];
		for (int i = 0; i < data.getOrder4CFDVec().length; i++) {
			orders[i] = new C3_TOrders4CFD();
			orders[i].parseFromSysData(data.getOrder4CFDVec()[i]);
		}
		setOrders(orders);
		C3_TTrade4CFD[] trades = new C3_TTrade4CFD[data.getTrade4CFDVec().length];
		for (int i = 0; i < data.getTrade4CFDVec().length; i++) {
			trades[i] = new C3_TTrade4CFD();
			trades[i].parseFromSysData(data.getTrade4CFDVec()[i]);
		}
		setTrades(trades);
	}

	public void parseFromSysData(OP_CTRL2002 data) throws Exception {
		C3_OtherClientConfig[] otherClientConfigVec = new C3_OtherClientConfig[data
				.getOtherClientConfigVec().length];
		for (int i = 0; i < data.getOtherClientConfigVec().length; i++) {
			otherClientConfigVec[i] = new C3_OtherClientConfig();
			otherClientConfigVec[i].parseFromSysData(data
					.getOtherClientConfigVec()[i]);
		}
		setOtherClientConfigVec(otherClientConfigVec);
	}

	public void parseFromSysData(OP_TRADESERV5040 data, long accountId)
			throws Exception {
		C3_UserLogin userLogin = new C3_UserLogin();
		userLogin.parseFromSysData(data.getUserLogin());
		setUserLogin(userLogin);
		String groupName = null;
		C3_AccountStrategy account = new C3_AccountStrategy();
		for (AccountStrategy acc : data.getAccountStrategyVec()) {
			if (acc.getAccount() == accountId) {
				account.parseFromSysData(acc);
				groupName = acc.getGroupName();
			}
		}
		setAccount(account);
		C3_GroupConfig group = new C3_GroupConfig();
		for (GroupConfig gro : data.getGroupConfigVec()) {
			if (gro.getGroupName().equals(groupName)) {
				group.parseFromSysData(gro);
			}
		}
		group.parseFromSysData(data.getGroupConfigVec()[0]);
		setGroup(group);
	}

	public void parseFromSysData(OP_CTRL2001 data) throws Exception {
		C3_InstTypeTree[] instTypeTrees = new C3_InstTypeTree[data.getTree().length];
		for (int i = 0; i < data.getTree().length; i++) {
			instTypeTrees[i] = new C3_InstTypeTree();
			instTypeTrees[i].parseFromSysData(data.getTree()[i]);
		}
		setInstTypeTrees(instTypeTrees);
		C3_LangPack langPack = new C3_LangPack();
		langPack.parseFromSysData(data.getLangPack());
		setLangPack(langPack);
		setTimeZone(data.getServerTimeZone().getID());
	}

	public void parseFromSysData(OP_TRADESERV5030 data) throws Exception {
		C3_SystemConfig systemConfig = new C3_SystemConfig();
		systemConfig.parseFromSysData(data.getSystemConfig());
		setSystemConfig(systemConfig);
		C3_BasicCurrency[] currencys = new C3_BasicCurrency[data
				.getBasicCurrencyVec().length];
		for (int i = 0; i < data.getBasicCurrencyVec().length; i++) {
			currencys[i] = new C3_BasicCurrency();
			currencys[i].parseFromSysData(data.getBasicCurrencyVec()[i]);
		}
		setCurrencys(currencys);
		C3_Instrument[] instruments = new C3_Instrument[data.getInstrumentVec().length];
		for (int i = 0; i < data.getInstrumentVec().length; i++) {
			instruments[i] = new C3_Instrument();
			instruments[i].parseFromSysData(data.getInstrumentVec()[i]);
		}
		setInstruments(instruments);
		C3_InstrumentType[] instrumentTypes = new C3_InstrumentType[data
				.getInstrumentTypeVec().length];
		for (int i = 0; i < data.getInstrumentTypeVec().length; i++) {
			instrumentTypes[i] = new C3_InstrumentType();
			instrumentTypes[i].parseFromSysData(data.getInstrumentTypeVec()[i]);
		}
		setInstrumentTypes(instrumentTypes);

		// C3_TradeTypeConfig[] tradeTypeConfigs = new
		// C3_TradeTypeConfig[data.getTradeTypeConfigVec().length];
		// for (int i = 0; i < data.getTradeTypeConfigVec().length; i++) {
		// tradeTypeConfigs[i] = new C3_TradeTypeConfig();
		// tradeTypeConfigs[i].parseFromSysData(data.getTradeTypeConfigVec()[i]);
		// }
		// setTradeTypeConfigs(tradeTypeConfigs);

		C3_BatchRateGap[] batchRateGaps = new C3_BatchRateGap[data
				.getBatchRateGapVec().length];
		for (int i = 0; i < data.getBatchRateGapVec().length; i++) {
			batchRateGaps[i] = new C3_BatchRateGap();
			batchRateGaps[i].parseFromSysData(data.getBatchRateGapVec()[i]);
		}
		setBatchRateGaps(batchRateGaps);

		C3_InstrumentListed[] instrumentListeds = new C3_InstrumentListed[data
				.getInstrumentListedVec().length];
		for (int i = 0; i < data.getInstrumentListedVec().length; i++) {
			instrumentListeds[i] = new C3_InstrumentListed();
			instrumentListeds[i]
					.parseFromSysData(data.getInstrumentListedVec()[i]);
		}
		setInstrumentListed(instrumentListeds);

		C3_InstrumentListed[] oriInstrumentListeds = new C3_InstrumentListed[data
				.getOriInstrumentListedVec().length];
		for (int i = 0; i < data.getOriInstrumentListedVec().length; i++) {
			oriInstrumentListeds[i] = new C3_InstrumentListed();
			oriInstrumentListeds[i].parseFromSysData(data
					.getOriInstrumentListedVec()[i]);
		}
		setOriInstrumentListed(oriInstrumentListeds);
	}

	public C3_UserLogin getUserLogin() {
		try {
			C3_UserLogin data = getEntryObject(C3_OP_Web1001.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(C3_UserLogin userLogin) {
		setEntry(C3_OP_Web1001.userLogin, userLogin);
	}

	public C3_AccountStrategy getAccount() {
		try {
			C3_AccountStrategy data = getEntryObject(C3_OP_Web1001.account);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccount(C3_AccountStrategy account) {
		setEntry(C3_OP_Web1001.account, account);
	}

	public C3_MoneyAccount[] getMoneyaccounts() {
		try {
			C3_MoneyAccount[] data = getEntryObjectVec(
					C3_OP_Web1001.moneyaccounts, new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyaccounts(C3_MoneyAccount[] moneyaccounts) {
		setEntry(C3_OP_Web1001.moneyaccounts, moneyaccounts);
	}

	public C3_SystemConfig getSystemConfig() {
		try {
			C3_SystemConfig data = getEntryObject(C3_OP_Web1001.systemConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSystemConfig(C3_SystemConfig systemConfig) {
		setEntry(C3_OP_Web1001.systemConfig, systemConfig);
	}

	public C3_BasicCurrency[] getCurrencys() {
		try {
			C3_BasicCurrency[] data = getEntryObjectVec(
					C3_OP_Web1001.currencys, new C3_BasicCurrency[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencys(C3_BasicCurrency[] currencys) {
		setEntry(C3_OP_Web1001.currencys, currencys);
	}

	public C3_Instrument[] getInstruments() {
		try {
			C3_Instrument[] data = getEntryObjectVec(C3_OP_Web1001.instruments,
					new C3_Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(C3_Instrument[] instruments) {
		setEntry(C3_OP_Web1001.instruments, instruments);
	}

	public C3_InstrumentListed[] getInstrumentListeds() {
		try {
			return getEntryObjectVec(C3_OP_Web1001.instrumentListed,
					new C3_InstrumentListed[0]);
		} catch (Exception e) {
			return null;
		}
	}

	public void setInstrumentListed(C3_InstrumentListed[] instruments) {
		setEntry(C3_OP_Web1001.instrumentListed, instruments);
	}

	public C3_InstrumentListed[] getOriInstrumentListeds() {
		try {
			return getEntryObjectVec(C3_OP_Web1001.oriInstrumentListed,
					new C3_InstrumentListed[0]);
		} catch (Exception e) {
			return null;
		}
	}

	public void setOriInstrumentListed(C3_InstrumentListed[] instruments) {
		setEntry(C3_OP_Web1001.oriInstrumentListed, instruments);
	}

	public C3_TOrders4CFD[] getOrders() {
		try {
			C3_TOrders4CFD[] data = getEntryObjectVec(C3_OP_Web1001.orders,
					new C3_TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrders(C3_TOrders4CFD[] orders) {
		setEntry(C3_OP_Web1001.orders, orders);
	}

	public C3_TTrade4CFD[] getTrades() {
		try {
			C3_TTrade4CFD[] data = getEntryObjectVec(C3_OP_Web1001.trades,
					new C3_TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrades(C3_TTrade4CFD[] trades) {
		setEntry(C3_OP_Web1001.trades, trades);
	}

	public C3_InstTypeTree[] getInstTypeTrees() {
		try {
			C3_InstTypeTree[] data = getEntryObjectVec(
					C3_OP_Web1001.instTypeTrees, new C3_InstTypeTree[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstTypeTrees(C3_InstTypeTree[] instTypeTrees) {
		setEntry(C3_OP_Web1001.instTypeTrees, instTypeTrees);
	}

	public C3_LangPack getLangPack() {
		try {
			C3_LangPack data = getEntryObject(C3_OP_Web1001.langPack);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLangPack(C3_LangPack langPack) {
		setEntry(C3_OP_Web1001.langPack, langPack);
	}

	public C3_InstrumentType[] getInstrumentTypes() {
		try {
			C3_InstrumentType[] data = getEntryObjectVec(
					C3_OP_Web1001.instrumentTypes, new C3_InstrumentType[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypes(C3_InstrumentType[] instrumentTypes) {
		setEntry(C3_OP_Web1001.instrumentTypes, instrumentTypes);
	}

	// public C3_TradeTypeConfig[] getTradeTypeConfigs() {
	// try {
	// C3_TradeTypeConfig[] data =
	// getEntryObjectVec(C3_OP_Web1001.tradeTypeConfigs,
	// new C3_TradeTypeConfig[0]);
	// return data;
	// } catch (RuntimeException e) {
	// return null;
	// }
	// }
	//
	// public void setTradeTypeConfigs(C3_TradeTypeConfig[] tradeTypeConfigs) {
	// setEntry(C3_OP_Web1001.tradeTypeConfigs, tradeTypeConfigs);
	// }

	public C3_OtherClientConfig[] getOtherClientConfigVec() {
		try {
			C3_OtherClientConfig[] data = getEntryObjectVec(
					C3_OP_Web1001.otherClientConfigVec,
					new C3_OtherClientConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOtherClientConfigVec(
			C3_OtherClientConfig[] otherClientConfigVec) {
		setEntry(C3_OP_Web1001.otherClientConfigVec, otherClientConfigVec);
	}

	public C3_BatchRateGap[] getBatchRateGaps() {
		try {
			C3_BatchRateGap[] data = getEntryObjectVec(
					C3_OP_Web1001.batchRateGaps, new C3_BatchRateGap[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchRateGaps(C3_BatchRateGap[] batchRateGaps) {
		setEntry(C3_OP_Web1001.batchRateGaps, batchRateGaps);
	}

	public C3_GroupConfig getGroup() {
		try {
			C3_GroupConfig data = getEntryObject(C3_OP_Web1001.group);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroup(C3_GroupConfig group) {
		setEntry(C3_OP_Web1001.group, group);
	}

	public C3_QuoteData[] getQuoteList() {
		try {
			C3_QuoteData[] data = getEntryObjectVec(C3_OP_Web1001.quoteList,
					new C3_QuoteData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteList(C3_QuoteData[] quoteList) {
		setEntry(C3_OP_Web1001.quoteList, quoteList);
	}

	public String getTimeZone() {
		try {
			String data = getEntryString(C3_OP_Web1001.timeZone);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTimeZone(String timeZone) {
		setEntry(C3_OP_Web1001.timeZone, timeZone);
	}

}