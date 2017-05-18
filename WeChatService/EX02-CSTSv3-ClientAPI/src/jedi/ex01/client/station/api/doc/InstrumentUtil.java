package jedi.ex01.client.station.api.doc;

import java.text.NumberFormat;

import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.QuoteData;

/**
 * Description: 商品的工具类 此类提供该商品的所有计算和操作接口
 * 
 * @author guosheng
 * 
 */
public class InstrumentUtil {
	private String instrument;

	private double onePointPrice;// 价格的最小点数，如0.0001
	private NumberFormat format;// 格式化价格的

	public InstrumentUtil(String instrument) throws Exception {
		this.instrument = instrument;
		Instrument instrumentNode = DataDoc.getInstance().getInstrument(
				instrument);
		if (instrumentNode == null) {
			throw new Exception("No instrument for " + instrument);
		}
		double opp = 1;
		for (int i = 0; i < instrumentNode.getDigits(); i++) {
			opp /= 10.0;
		}
		onePointPrice = opp;
		format = NumberFormat.getInstance();
		format.setMinimumFractionDigits(instrumentNode.getDigits()
				+ instrumentNode.getExtraDigit());
		format.setMaximumFractionDigits(instrumentNode.getDigits()
				+ instrumentNode.getExtraDigit());
		format.setGroupingUsed(false);
	}

	/**
	 * 得到该商品的价格快照 可以通过快照计算盈亏数据
	 * 
	 * @return
	 * @throws KeyNotFindException
	 */
	public PriceSnapShot getPriceSnapShot() throws Exception {
		PriceSnapShot shot = new PriceSnapShot();
		shot.setInstrument(this.instrument);
		QuoteData quote = DataDoc.getInstance().getQuote(instrument);
		shot.setFirstQuote(true);
		if (quote != null && quote.getBid() > 0.0001 && quote.getAsk() > 0.0001) {
			shot.setSystemBid(quote.getBid());
			shot.setSystemAsk(quote.getAsk());
			QuoteData lastQuote = DataDoc.getInstance()
					.getLastQuote(instrument);
			shot.setLastQuoteUsefull(true);
			if (lastQuote != null) {
				shot.setSystemLastBid(lastQuote.getBid());
				shot.setSystemLastAsk(lastQuote.getAsk());
				if (!lastQuote.getQuoteDay().equalsIgnoreCase(
						quote.getQuoteDay())) {
					shot.setLastQuoteUsefull(false);
					shot.setFirstQuote(true);
				} else {
					shot.setFirstQuote(false);
				}
			} else {
				shot.setLastQuoteUsefull(false);
				shot.setSystemLastBid(0);
				shot.setSystemLastAsk(0);
			}
		} else {
			throw new Exception("PriceSnapShot can't get quote data for "
					+ instrument);
		}
		return shot;
	}

	public PriceSnapShot getPriceSnapShotForGivenPrice(double bid, double ask) {
		PriceSnapShot shot = new PriceSnapShot();
		shot.setInstrument(this.instrument);
		shot.setSystemBid(bid);
		shot.setSystemAsk(ask);
		return shot;
	}

	public double getOnePointPrice() {
		return onePointPrice;
	}

	/**
	 * 格式化价格
	 * 
	 * @param price
	 * @return
	 */
	public String formatPrice(double price) {
		synchronized (this.format) {
			return format.format(price);
		}
	}
}
