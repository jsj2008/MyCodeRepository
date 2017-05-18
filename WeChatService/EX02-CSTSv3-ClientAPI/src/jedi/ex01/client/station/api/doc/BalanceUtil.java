package jedi.ex01.client.station.api.doc;

import jedi.ex01.CSTS3.comm.struct.BatchRateGap;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.QuoteData;

/**
 * 用来做货币兑换的工具
 * 
 * @author guosheng
 * 
 */
public class BalanceUtil {
	private final static String CONNECTION = "[and]";
	
	public static BalanceUtil newInstance(String instrumentCurrency,
			String balanceCurrency) throws Exception{
		return new BalanceUtil(instrumentCurrency,balanceCurrency);
	}
	
	private String instrumentCurrency;
	private String balanceCurrency;
	private String utilName;
	private String instrumentName;
	private double onePointPrice;// 价格的最小点数，如0.0001
	private boolean isStrightConvert;

	public BalanceUtil(String instrumentCurrency, String balanceCurrency)
			throws Exception {
		this.instrumentCurrency = instrumentCurrency;
		this.balanceCurrency = balanceCurrency;
		this.utilName = getBalanceUtilName(instrumentCurrency, balanceCurrency);
		if (instrumentCurrency.equals(balanceCurrency)) {
			isStrightConvert = true;
		} else {
			this.instrumentName = DataDoc.getInstance()
					.getBalanceInstrumentName(instrumentCurrency,
							balanceCurrency);
			if (instrumentName == null) {
				throw new Exception("No balance util for " + utilName);
			}
			Instrument instrument = DataDoc.getInstance().getInstrument(
					instrumentName);
			onePointPrice = Math.pow(10, -instrument.getDigits());
			isStrightConvert = instrument.getCurrencyName().equals(
					balanceCurrency);
		}
	}

	public static String getBalanceUtilName(String instCurr, String balCurr) {
		if (instCurr.compareTo(balCurr) > 0) {
			return instCurr + CONNECTION + balCurr;
		} else {
			return balCurr + CONNECTION + instCurr;
		}
	}

	public String getInstrumentCurrency() {
		return instrumentCurrency;
	}

	public String getBalanceCurrency() {
		return balanceCurrency;
	}

	public String getUtilName() {
		return utilName;
	}

	public double getBalanceMoney(double money) {
		BalancePricePair pair = this.getPricePair();
		double price = this.getExchangePrice(money, pair);
		return this.exchangeForBalanceCurr(money, price);
	}

	public BalanceSnapShort getBalanceSnapShort(double money) {
		BalancePricePair pair = this.getPricePair();
		double price = this.getExchangePrice(money, pair);
		double result = this.exchangeForBalanceCurr(money, price);
		BalanceSnapShort snap = new BalanceSnapShort(instrumentCurrency,
				balanceCurrency, price, money, result);
		return snap;
	}

	private double exchangeForBalanceCurr(double money, double price) {
		if (this.isStrightConvert) {
			if (money > 0.0001) {
				return money * price;
			} else {
				return money * price;
			}
		} else {
			if (money > 0.0001) {
				return money / price;
			} else {
				return money / price;
			}
		}
	}

	private double getExchangePrice(double money, BalancePricePair pair) {
		if (this.isStrightConvert) {
			if (money > 0.0001) {
				return pair.bid;
			} else {
				return pair.ask;
			}
		} else {
			if (money > 0.0001) {
				return pair.ask;
			} else {
				return pair.bid;
			}
		}
	}

	/**
	 * get price pair for this calculation. If batch rate gap for this currency
	 * pair is set,plus the gap to real price else,plus AccountInstrumentCfg and
	 * GroupInstrumentCfg's spread to real price
	 */
	private BalancePricePair getPricePair() {
		BalancePricePair pair = new BalancePricePair();
		if (this.instrumentCurrency.equals(balanceCurrency)) {
			pair.bid = 1;
			pair.ask = 1;
			return pair;
		}
		QuoteData quote = DataDoc.getInstance().getQuote(instrumentName);
		if (quote == null) {
			System.err.println("[TradeServer] quote not find :"
					+ instrumentName);
			return null;
		}
		BatchRateGap gap = DataDoc.getInstance()
				.getBatchRateGap(instrumentName);
		pair.bid = quote.getBid();
		pair.ask = quote.getAsk();
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrumentName);
		double priceSpreed2Add = Math.max(0, instrumentNode
				.getAccount_spread2Add())
				+ Math.max(0, instrumentNode.getGroup_spread2Add());
		if (gap == null) {
			pair.ask += priceSpreed2Add * onePointPrice;
		} else {
			pair.bid -= gap.getBidPriceGap() * onePointPrice;
			pair.ask += gap.getAskPriceGap() * onePointPrice;
		}
		return pair;
	}

	public String getInstrumentName() {
		if (this.isStrightConvert) {
			return "";
		}
		return instrumentName;
	}
}

class BalancePricePair {
	double bid;
	double ask;
}