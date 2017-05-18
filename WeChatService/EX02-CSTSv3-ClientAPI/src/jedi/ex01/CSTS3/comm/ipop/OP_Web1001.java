package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.AccountStrategy;
import jedi.ex01.CSTS3.comm.struct.BasicCurrency;
import jedi.ex01.CSTS3.comm.struct.BatchRateGap;
import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.InstTypeTree;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.InstrumentType;
import jedi.ex01.CSTS3.comm.struct.LangPack;
import jedi.ex01.CSTS3.comm.struct.MoneyAccount;
import jedi.ex01.CSTS3.comm.struct.OtherClientConfig;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.comm.struct.SystemConfig;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.comm.struct.TradeTypeConfig;
import jedi.ex01.CSTS3.comm.struct.UserLogin;


public class OP_Web1001 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

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
	public static final String tradeTypeConfigs = "12";
	public static final String otherClientConfigVec = "13";
	public static final String batchRateGaps = "14";
	public static final String group = "15";
	public static final String quoteList = "16";
	public static final String timeZone = "17";

	public OP_Web1001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public UserLogin getUserLogin() {
		try {
			UserLogin data=getEntryObject(OP_Web1001.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(UserLogin userLogin) {
		setEntry(OP_Web1001.userLogin, userLogin);
	}

	public AccountStrategy getAccount() {
		try {
			AccountStrategy data=getEntryObject(OP_Web1001.account);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccount(AccountStrategy account) {
		setEntry(OP_Web1001.account, account);
	}

	public MoneyAccount[] getMoneyaccounts() {
		try {
			MoneyAccount[] data=getEntryObjectVec(OP_Web1001.moneyaccounts,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyaccounts(MoneyAccount[] moneyaccounts) {
		setEntry(OP_Web1001.moneyaccounts, moneyaccounts);
	}

	public SystemConfig getSystemConfig() {
		try {
			SystemConfig data=getEntryObject(OP_Web1001.systemConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSystemConfig(SystemConfig systemConfig) {
		setEntry(OP_Web1001.systemConfig, systemConfig);
	}

	public BasicCurrency[] getCurrencys() {
		try {
			BasicCurrency[] data=getEntryObjectVec(OP_Web1001.currencys,new BasicCurrency[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrencys(BasicCurrency[] currencys) {
		setEntry(OP_Web1001.currencys, currencys);
	}

	public Instrument[] getInstruments() {
		try {
			Instrument[] data=getEntryObjectVec(OP_Web1001.instruments,new Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(Instrument[] instruments) {
		setEntry(OP_Web1001.instruments, instruments);
	}

	public TOrders4CFD[] getOrders() {
		try {
			TOrders4CFD[] data=getEntryObjectVec(OP_Web1001.orders,new TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrders(TOrders4CFD[] orders) {
		setEntry(OP_Web1001.orders, orders);
	}

	public TTrade4CFD[] getTrades() {
		try {
			TTrade4CFD[] data=getEntryObjectVec(OP_Web1001.trades,new TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrades(TTrade4CFD[] trades) {
		setEntry(OP_Web1001.trades, trades);
	}

	public InstTypeTree[] getInstTypeTrees() {
		try {
			InstTypeTree[] data=getEntryObjectVec(OP_Web1001.instTypeTrees,new InstTypeTree[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstTypeTrees(InstTypeTree[] instTypeTrees) {
		setEntry(OP_Web1001.instTypeTrees, instTypeTrees);
	}

	public LangPack getLangPack() {
		try {
			LangPack data=getEntryObject(OP_Web1001.langPack);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLangPack(LangPack langPack) {
		setEntry(OP_Web1001.langPack, langPack);
	}

	public InstrumentType[] getInstrumentTypes() {
		try {
			InstrumentType[] data=getEntryObjectVec(OP_Web1001.instrumentTypes,new InstrumentType[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypes(InstrumentType[] instrumentTypes) {
		setEntry(OP_Web1001.instrumentTypes, instrumentTypes);
	}

	public TradeTypeConfig[] getTradeTypeConfigs() {
		try {
			TradeTypeConfig[] data=getEntryObjectVec(OP_Web1001.tradeTypeConfigs,new TradeTypeConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeTypeConfigs(TradeTypeConfig[] tradeTypeConfigs) {
		setEntry(OP_Web1001.tradeTypeConfigs, tradeTypeConfigs);
	}

	public OtherClientConfig[] getOtherClientConfigVec() {
		try {
			OtherClientConfig[] data=getEntryObjectVec(OP_Web1001.otherClientConfigVec,new OtherClientConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOtherClientConfigVec(OtherClientConfig[] otherClientConfigVec) {
		setEntry(OP_Web1001.otherClientConfigVec, otherClientConfigVec);
	}

	public BatchRateGap[] getBatchRateGaps() {
		try {
			BatchRateGap[] data=getEntryObjectVec(OP_Web1001.batchRateGaps,new BatchRateGap[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchRateGaps(BatchRateGap[] batchRateGaps) {
		setEntry(OP_Web1001.batchRateGaps, batchRateGaps);
	}

	public GroupConfig getGroup() {
		try {
			GroupConfig data=getEntryObject(OP_Web1001.group);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroup(GroupConfig group) {
		setEntry(OP_Web1001.group, group);
	}

	public QuoteData[] getQuoteList() {
		try {
			QuoteData[] data=getEntryObjectVec(OP_Web1001.quoteList,new QuoteData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setQuoteList(QuoteData[] quoteList) {
		setEntry(OP_Web1001.quoteList, quoteList);
	}

	public String getTimeZone() {
		try {
			String data=getEntryString(OP_Web1001.timeZone);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTimeZone(String timeZone) {
		setEntry(OP_Web1001.timeZone, timeZone);
	}


}