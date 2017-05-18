package jedi.ex01.client.station.api.doc;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;

/**
 * description�� ��Ʒ�ļ۸���� �ÿ����а�������Ʒ��ʱ�������ת��Ϊ������ҵ����� ����ͨ���˿������������ʱ��ӯ��
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
	// ��ί�е���ʽ�ĳɽ������ɽ��۸����г��۸񣬶���ָ���۸�ʱ��ͨ�����õ�����۸�������ӯ��
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
	 * ����ʵ��ӯ�� �������׵��������ֵ����볡�ۣ�����������Ϣ�������ʵ���ϵ�ӯ����� �磺GBPJPY
	 * ��228.40����100,000�������û���������Ϊ228.45,��ʵ�����û�ӯ��5000JPY
	 * 
	 * @param amount
	 *            ���׵�����
	 * @param openTradePrice
	 *            ���ּ�λ
	 * @param isBuyNotSell
	 *            ��λ���������뻹������
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
	 * ����ʵ��ֵ����Ǯ �������׵���������������Ϣ�������ʵ���ϵ�ӯ����� �磺GBPJPY
	 * ����100,000�������û���������Ϊ228.45,��ʵ�����û�ӯ��228450000JPY
	 * 
	 * @param amount
	 *            ���׵�����
	 * @param isBuyNotSell
	 *            ��λ���������뻹������
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
