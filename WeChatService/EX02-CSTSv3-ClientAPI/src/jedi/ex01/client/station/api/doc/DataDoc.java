package jedi.ex01.client.station.api.doc;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.TimeZone;

import jedi.ex01.CSTS3.comm.struct.BasicCurrency;
import jedi.ex01.CSTS3.comm.struct.BatchRateGap;
import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.InstTypeTree;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.LangPack;
import jedi.ex01.CSTS3.comm.struct.OtherClientConfig;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.comm.struct.SystemConfig;
import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;
import jedi.ex01.CSTS3.comm.struct.TSettled4CFD;
import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;
import jedi.ex01.CSTS3.comm.struct.TradeTypeConfig;
import jedi.ex01.CSTS3.comm.struct.UserLogin;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.doc.lock.QuoteLock;

public class DataDoc {
	private final static DataDoc instance = new DataDoc();

	public static DataDoc getInstance() {
		return instance;
	}

	private DataDoc() {

	}
	
	private QuoteLock quoteLock = new QuoteLock();
	private String noExMarginTradeOpenDay;
	private SimpleDateFormat tradeDayFormatter = new SimpleDateFormat(MTP4CommDataInterface.PATTERN_TRADEDAY);
	
	private SystemConfig systemConfig = null;
	private GroupConfig group = null;
	private UserLogin userLogin = null;
//	private TradeTypeConfig cfdTradeTypeConfig = null;
	private AccountStore accountStore;
	private TimeZone timeZone;
	private InstTypeTree[] instTreeNodeVec = new InstTypeTree[0];
	private LangPack langPack = new LangPack();

	private DocMapList<Long, TTrade4CFD> tradeMapList = new DocMapList<Long, TTrade4CFD>();
	private DocMapList<Long, TOrders4CFD> orderMapList = new DocMapList<Long, TOrders4CFD>();
	private DocMapList<String, Instrument> instrumentMapList = new DocMapList<String, Instrument>();
	private DocMapList<String, BasicCurrency> basicCurrencyMapList = new DocMapList<String, BasicCurrency>();

	private HashMap<String, String> balanceInstrumentNameMap = new HashMap<String, String>();
	private HashMap<String, QuoteData> quoteMap = new HashMap<String, QuoteData>();
	private HashMap<String, QuoteData> lastQuoteMap = new HashMap<String, QuoteData>();
	private HashMap<String, BatchRateGap> batchRateGapMap = new HashMap<String, BatchRateGap>();

	private ArrayList<TSettled4CFD> settleList = new ArrayList<TSettled4CFD>();

	private HashMap<String, OtherClientConfig> otherClientConfigMap = new HashMap<String, OtherClientConfig>();

	public TimeZone getTimeZone() {
		return timeZone;
	}

	public void setTimeZone(TimeZone timeZone) {
		this.timeZone = timeZone;
	}

	public SystemConfig getSystemConfig() {
		return systemConfig;
	}

	public void setSystemConfig(SystemConfig systemConfig) {
		this.systemConfig = systemConfig;
		__calcualateNoExMarginTradeOpenDay();
	}

	public String getNoExMarginTradeOpenDay() {
		return noExMarginTradeOpenDay;
	}

	public void __calcualateNoExMarginTradeOpenDay() {
		String tradeDayStr = systemConfig.getTradeDay();
//		if (systemConfig.getMarginEXDueDay() <= 0) {
//			noExMarginTradeOpenDay = null;
//			return;
//		}
		Date tradeDay = null;
		synchronized (tradeDayFormatter) {
			try {
				tradeDay = this.tradeDayFormatter.parse(tradeDayStr);
			} catch (ParseException e) {
				e.printStackTrace();
				noExMarginTradeOpenDay = null;
				return;
			}
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(tradeDay);
//		for (int i = 0; i < systemConfig.getMarginEXDueDay();) {
//			cal.add(Calendar.DATE, -1);
//			int dayofweek = cal.get(Calendar.DAY_OF_WEEK);
//			if (dayofweek == Calendar.SATURDAY || dayofweek == Calendar.SUNDAY) {
//				continue;
//			} else {
//				i++;
//			}
//		}
		synchronized (tradeDayFormatter) {
			noExMarginTradeOpenDay = tradeDayFormatter.format(cal.getTime());
		}
	}

//	public TradeTypeConfig getCfdTradeTypeConfig() {
//		return cfdTradeTypeConfig;
//	}
//
//	public void setCfdTradeTypeConfig(TradeTypeConfig cfdTradeTypeConfig) {
//		this.cfdTradeTypeConfig = cfdTradeTypeConfig;
//	}

	public GroupConfig getGroup() {
		return group;
	}

	public void setGroup(GroupConfig group) {
		this.group = group;
	}

	public UserLogin getUserLogin() {
		return userLogin;
	}

	public void setUserLogin(UserLogin userLogin) {
		this.userLogin = userLogin;
	}

	public AccountStore getAccountStore() {
		return accountStore;
	}

	public void setAccountStore(AccountStore accountStore) {
		this.accountStore = accountStore;
	}

	// //////////////////////////////////////////////////////////////////////
	// / Trade //////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addTrade(TTrade4CFD trade) {
		synchronized (tradeMapList) {
			tradeMapList.put(trade.getTicket(), trade);
		}
	}

	public void resetTrades(TTrade4CFD[] tradeVec) {
		synchronized (tradeMapList) {
			tradeMapList.clear();
			for (TTrade4CFD trade : tradeVec) {
				tradeMapList.put(trade.getTicket(), trade);
			}
		}
	}

	public TTrade4CFD getTrade(long ticket) {
		synchronized (tradeMapList) {
			return tradeMapList.getValue(ticket);
		}
	}

	public TTrade4CFD removeTrade(long ticket) {
		synchronized (tradeMapList) {
			return tradeMapList.remove(ticket);
		}
	}

	public List<TTrade4CFD> getTradeList() {
		synchronized (tradeMapList) {
			return tradeMapList.getList();
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / Order //////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addOrder(TOrders4CFD order) {
		synchronized (orderMapList) {
			orderMapList.put(order.getOrderID(), order);
		}
	}

	public void resetOrders(TOrders4CFD[] orderVec) {
		synchronized (orderMapList) {
			orderMapList.clear();
			for (TOrders4CFD order : orderVec) {
				orderMapList.put(order.getOrderID(), order);
			}
		}
	}

	public TOrders4CFD getOrder(long orderID) {
		synchronized (orderMapList) {
			return orderMapList.getValue(orderID);
		}
	}

	public TOrders4CFD removeOrder(long orderID) {
		synchronized (orderMapList) {
			return orderMapList.remove(orderID);
		}
	}

	public List<TOrders4CFD> getOrderList() {
		synchronized (orderMapList) {
			return orderMapList.getList();
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / Instrument //////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addInstrument(Instrument instrument) {
		synchronized (instrumentMapList) {
			instrumentMapList.put(instrument.getInstrument(), instrument);
			updateBalanceInstrument(instrument);
		}
	}

	public void resetInstruments(Instrument[] instrumentVec) {
		synchronized (instrumentMapList) {
			instrumentMapList.clear();
			for (Instrument instrument : instrumentVec) {
				instrumentMapList.put(instrument.getInstrument(), instrument);
				updateBalanceInstrument(instrument);
			}
		}
	}

	public Instrument getInstrument(String instrument) {
		synchronized (instrumentMapList) {
			return instrumentMapList.getValue(instrument);
		}
	}

	public Instrument removeInstrument(String instrument) {
		synchronized (instrumentMapList) {
			return instrumentMapList.remove(instrument);
		}
	}

	public List<Instrument> getInstrumentList() {
		synchronized (instrumentMapList) {
			return instrumentMapList.getList();
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / BasicCurrency
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addBasicCurrency(BasicCurrency basiccurrency) {
		synchronized (basicCurrencyMapList) {
			basicCurrencyMapList.put(basiccurrency.getCurrencyName(), basiccurrency);
		}
	}

	public void resetBasicCurrencys(BasicCurrency[] basiccurrencyVec) {
		synchronized (basicCurrencyMapList) {
			basicCurrencyMapList.clear();
			for (BasicCurrency basiccurrency : basiccurrencyVec) {
				basicCurrencyMapList.put(basiccurrency.getCurrencyName(), basiccurrency);
			}
		}
	}

	public BasicCurrency getBasicCurrency(String currencyName) {
		synchronized (basicCurrencyMapList) {
			return basicCurrencyMapList.getValue(currencyName);
		}
	}

	public BasicCurrency removeBasicCurrency(String currencyName) {
		synchronized (basicCurrencyMapList) {
			return basicCurrencyMapList.remove(currencyName);
		}
	}

	public List<BasicCurrency> getBasicCurrencyList() {
		synchronized (basicCurrencyMapList) {
			return basicCurrencyMapList.getList();
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / BalanceInstrument
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	private void updateBalanceInstrument(Instrument ins) {
		if (!ins.getSecType().equals(MTP4CommDataInterface.SECTYPE_CASH)) {
			return;
		}
		BasicCurrency currency1 = getBasicCurrency(ins.getMerchandiseName());
		if (currency1 == null) {
			return;
		}
		BasicCurrency currency2 = getBasicCurrency(ins.getCurrencyName());
		if (currency2 == null) {
			return;
		}
		if (currency1.getCanBeAccountCurrency() == MTP4CommDataInterface.TRUE) {
			balanceInstrumentNameMap.put(BalanceUtil.getBalanceUtilName(currency2.getCurrencyName(),
					currency1.getCurrencyName()), ins.getInstrument());
		}
		if (currency2.getCanBeAccountCurrency() == MTP4CommDataInterface.TRUE) {
			balanceInstrumentNameMap.put(BalanceUtil.getBalanceUtilName(currency1.getCurrencyName(),
					currency2.getCurrencyName()), ins.getInstrument());
		}
	}

	public String getBalanceInstrumentName(String cur1, String cur2) {
		return balanceInstrumentNameMap.get(BalanceUtil.getBalanceUtilName(cur1, cur2));
	}

	public String[] getBalanceInstrumentNames() {
		return balanceInstrumentNameMap.values().toArray(new String[0]);
	}

	// //////////////////////////////////////////////////////////////////////
	// / quote
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addQuote(QuoteData quote) {
		synchronized (quoteLock) {
			if (quoteMap.containsKey(quote.getInstrument())) {
				QuoteData lastQuote = quoteMap.get(quote.getInstrument());
				lastQuoteMap.put(lastQuote.getInstrument(), lastQuote);
			} else {
				lastQuoteMap.put(quote.getInstrument(), quote);
			}
			quoteMap.put(quote.getInstrument(), quote);
		}
	}
	
	public void resetQuoteTable(QuoteData[] quoteVec) {
		if (quoteVec==null) {
			return;
		}
		synchronized (quoteLock) {
			for (QuoteData quote : quoteVec) {
				if (quoteMap.containsKey(quote.getInstrument())) {
					QuoteData lastQuote = quoteMap.get(quote.getInstrument());
					lastQuoteMap.put(lastQuote.getInstrument(), lastQuote);
				} else {
					lastQuoteMap.put(quote.getInstrument(), quote);
				}
				quoteMap.put(quote.getInstrument(), quote);
			}
		}
	}

	public QuoteData getQuote(String inst) {
		synchronized (quoteMap) {
			return quoteMap.get(inst);
		}
	}

	public QuoteData getLastQuote(String inst) {
		synchronized (lastQuoteMap) {
			return lastQuoteMap.get(inst);
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / batchRateGapMap
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public void addBatchRateGap(BatchRateGap brg) {
		synchronized (batchRateGapMap) {
			batchRateGapMap.put(brg.getInstrument(), brg);
		}
	}
	
	public void resetBatchRateGap(BatchRateGap[] brgVec) {
		synchronized (batchRateGapMap) {
			batchRateGapMap.clear();
			for (BatchRateGap brg : brgVec) {
				batchRateGapMap.put(brg.getInstrument(), brg);
			}
		}
	}

	public BatchRateGap getBatchRateGap(String inst) {
		synchronized (batchRateGapMap) {
			return batchRateGapMap.get(inst);
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / TSettled4CFD
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public ArrayList<TSettled4CFD> getSettleList() {
		return settleList;
	}

	public void addSettle(TSettled4CFD[] settles) {
		for (TSettled4CFD settled4CFD : settles) {
			settleList.add(settled4CFD);
		}
	}

	// //////////////////////////////////////////////////////////////////////
	// / Lang and others
	// ////////////////////////////////////////////////////////////////////
	// ////////////////////////////////////////////////////////////////////
	public InstTypeTree[] getInstTreeNodeVec() {
		return instTreeNodeVec;
	}

	public void setInstTreeNodeVec(InstTypeTree[] instTreeNodeVec) {
		this.instTreeNodeVec = instTreeNodeVec;
	}

	public LangPack getLangPack() {
		return langPack;
	}

	public void setLangPack(LangPack langPack) {
		this.langPack = langPack;
	}

	public void addOtherClientConfig(OtherClientConfig[] cfgs) {
		if (cfgs == null) {
			return;
		}
		for (int i = 0; i < cfgs.length; i++) {
			OtherClientConfig cfg = cfgs[i];
			otherClientConfigMap.put(cfg.getKey(), cfg);
		}
	}

	public OtherClientConfig getOtherClientConfig(String key) {
		return (OtherClientConfig) otherClientConfigMap.get(key);
	}

	public QuoteLock getQuoteLock() {
		return quoteLock;
	}
	
}
