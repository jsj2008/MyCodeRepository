package jedi.ex01.client.station.api.doc;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;

/**
 * description： 商品的价格快照 该快照中包含了商品当时的行情和转化为结算货币的行情 可以通过此快照来计算快照时的盈亏
 * 
 * @author Sean
 * 
 */
public class PriceSnapShot implements Cloneable {
	private String instrument;
	private double systemBid;
	private double systemAsk;
	private double systemLastBid;
	private double systemLastAsk;
	// 当委托单形式的成交，即成交价格不是市场价格，而是指定价格时，通过设置的这个价格来计算盈亏
	private double tradePrice;
	private boolean tradePriceSetted = false;
	private long snapshotTime;
	private boolean isLastQuoteUsefull = false;
	private boolean isFirstQuote = false;

	PriceSnapShot() {
		snapshotTime = System.currentTimeMillis();
	}

	public String getInstrument() {
		return instrument;
	}

	public void setInstrument(String instrument) {
		this.instrument = instrument;
	}

	public double getBid() {
		return systemBid;
	}

	public void setSystemBid(double bid) {
		this.systemBid = bid;
	}

	public double getAsk() {
		double price = systemAsk;
		price += getAskPriceShift();
		return price;
	}

	public void setSystemAsk(double ask) {
		this.systemAsk = ask;
	}

	/**
	 * 计算实际盈亏 给定交易的量、开仓单的入场价，买入卖出信息，计算出实际上的盈亏金额 如：GBPJPY
	 * 在228.40买入100,000，现在用户的卖出价为228.45,则实际上用户盈利5000JPY
	 * 
	 * @param amount
	 *            交易的数量
	 * @param openTradePrice
	 *            开仓价位
	 * @param isBuyNotSell
	 *            仓位本身是买入还是卖出
	 * @return
	 */
	public double caculateRealPL(double amount, double openTradePrice,
			int toBuyOrSell) {
		double temptradePrice = getTradePrice(toBuyOrSell == MTP4CommDataInterface.BUY ? MTP4CommDataInterface.SELL
				: MTP4CommDataInterface.BUY);
		if (toBuyOrSell == MTP4CommDataInterface.BUY) {
			return (temptradePrice - openTradePrice) * amount;
		} else {
			return (openTradePrice - temptradePrice) * amount;
		}
	}

	/**
	 * 计算实际值多少钱 给定交易的量、买入卖出信息，计算出实际上的盈亏金额 如：GBPJPY
	 * 买入100,000，现在用户的卖出价为228.45,则实际上用户盈利228450000JPY
	 * 
	 * @param amount
	 *            交易的数量
	 * @param isBuyNotSell
	 *            仓位本身是买入还是卖出
	 * @return
	 */
	public double caculateRealMoney(double amount, int buyOrSell) {
		double temptradePrice = getTradePrice(buyOrSell);
		return temptradePrice * amount;
	}

	public long getSnapshotTime() {
		return snapshotTime;
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		PriceSnapShot shot = (PriceSnapShot) super.clone();
		return shot;
	}

	public void setSystemLastBid(double systemLastBid) {
		this.systemLastBid = systemLastBid;
	}

	public void setSystemLastAsk(double systemLastAsk) {
		this.systemLastAsk = systemLastAsk;
	}

	public double getLastBid() {
		return systemLastBid;
	}

	private double getAskPriceShift() {
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode != null) {
			double shift = 0;
			if(instrumentNode.getGroupName()!=null){
				shift += instrumentNode.getGroup_spread2Add();
			}
			if(instrumentNode.getAccount()>0){
				shift += instrumentNode.getAccount_spread2Add();
			}
			return new Double(Math.pow(10,-1*instrumentNode.getDigits())*shift);
		}
		return 0;
	}

	public double getLastAsk() {
		if (systemLastAsk <= 0.00001) {
			return systemLastAsk;
		}
		return systemLastAsk + getAskPriceShift();
	}

	public double getTradePrice(int buySell) {
		if (tradePrice > 0.0001) {
			return tradePrice;
		} else {
			if (buySell == MTP4CommDataInterface.BUY) {
				return this.getAsk();
			} else {
				return this.getBid();
			}
		}
	}

	public void setTradePrice(double tradePrice) {
		tradePriceSetted = tradePrice > 0.00001;
		this.tradePrice = tradePrice;
	}

	public boolean isLastQuoteUsefull() {
		return isLastQuoteUsefull;
	}

	public void setLastQuoteUsefull(boolean isLastQuoteUsefull) {
		this.isLastQuoteUsefull = isLastQuoteUsefull;
	}

	public boolean isFirstQuote() {
		return isFirstQuote;
	}

	public void setFirstQuote(boolean isFirstQuote) {
		this.isFirstQuote = isFirstQuote;
	}

	public static void main(String args[]) {
		System.out.println(Math.pow(0.1, 3));
	}
}
