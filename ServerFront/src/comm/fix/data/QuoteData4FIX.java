//package comm.fix.data;
//
//import server.define.DataTypeDefine;
//
//import comm.fix.BasicFIXData;
//import comm.fix.FixByteBuffer;
//import comm.fix.FixDataUtil;
//import comm.fix.FixDateDefine;
//import comm.fix.FixStyledData;
//
//public class QuoteData4FIX extends BasicFIXData {
//
//	private String instrument;
//	private String instrumentType;
//	private long quoteTime;
//	private double openPrice;
//	private double highPrice;
//	private double lowPrice;
//	private double yclosePrice;
//	private double bid;
//	private double ask;
//	private double lastBid;
//	private boolean tradeable;
//	private boolean close;
//	private String quoteDay;
//	private long tradeVolume;
//	private long lots;
//
//	public QuoteData4FIX() {
//		super(FixDateDefine.DATATYPE_QUOTE);
//
//	}
//
//	FixStyledData fixData;
//
//	@Override
//	public byte[] format() throws Exception {
//		fixData = new FixStyledData();
//		fixData.addData(FixDateDefine.IDX_INSTRUMENT, instrument);
//		fixData.addData(FixDateDefine.IDX_INSTRUMENTTYPE, instrumentType);
//		fixData.addData(FixDateDefine.IDX_QUOTETIME, String.valueOf(quoteTime));
//		fixData.addData(FixDateDefine.IDX_OPENPRICE, openPrice, 6);
//		fixData.addData(FixDateDefine.IDX_HIGHPRICE, highPrice, 6);
//		fixData.addData(FixDateDefine.IDX_LOWPRICE, lowPrice, 6);
//		fixData.addData(FixDateDefine.IDX_YCLOSEPRICE, yclosePrice, 6);
//		fixData.addData(FixDateDefine.IDX_BID, bid, 6);
//		fixData.addData(FixDateDefine.IDX_ASK, ask, 6);
//		fixData.addData(FixDateDefine.IDX_LASTBID, lastBid, 6);
//		fixData.addData(FixDateDefine.IDX_TRADEABLE, String.valueOf(tradeable));
//		fixData.addData(FixDateDefine.IDX_CLOSE, String.valueOf(close));
//		fixData.addData(FixDateDefine.IDX_QUOTEDAY, quoteDay);
//		fixData.addData(FixDateDefine.IDX_TRADEVOLUME, String.valueOf(tradeVolume));
//		fixData.addData(FixDateDefine.IDX_LOTS, String.valueOf(lots));
//		fixData.format();
//		String data = fixData.getFormatedData();
//		FixByteBuffer buffer = FixByteBuffer.getWriteInstance();
//		buffer.writeInt(dataType, 2);
//		buffer.writeInt(isZip, 1);
//		buffer.writeInt(isEncrypt, 1);
//		byte[] buf = data.getBytes();
//		if (isZip == DataTypeDefine.TRUE) {
//			buf = FixDataUtil.zip(buf);
//		}
//		if (isEncrypt == DataTypeDefine.TRUE && key != null) {
//			buf = FixDataUtil.encrypt(buf, key);
//		}
//		buffer.writeBuffer(buf);
//		return buffer.getBuffer();
//	}
//
//	@Override
//	public void parse() throws Exception {
//		fixData = new FixStyledData();
//		byte[] buf = this.dataBuffer;
//		if (isEncrypt == DataTypeDefine.TRUE && key != null) {
//			buf = FixDataUtil.decrypt(buf, key);
//		}
//		if (isZip == DataTypeDefine.TRUE) {
//			buf = FixDataUtil.unzip(buf);
//		}
//		String data = new String(buf);
//		fixData.parse(data);
//		instrument = fixData.getAt(FixDateDefine.IDX_INSTRUMENT);
//		instrumentType = fixData.getAt(FixDateDefine.IDX_INSTRUMENTTYPE);
//		quoteTime = Long.parseLong(fixData.getAt(FixDateDefine.IDX_QUOTETIME));
//		openPrice = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_OPENPRICE));
//		highPrice = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_HIGHPRICE));
//		lowPrice = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_LOWPRICE));
//		yclosePrice = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_YCLOSEPRICE));
//		bid = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_BID));
//		ask = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_ASK));
//		lastBid = Double.parseDouble(fixData.getAt(FixDateDefine.IDX_LASTBID));
//		tradeable = Boolean.parseBoolean(fixData.getAt(FixDateDefine.IDX_TRADEABLE));
//		close = Boolean.parseBoolean(fixData.getAt(FixDateDefine.IDX_CLOSE));
//		quoteDay = fixData.getAt(FixDateDefine.IDX_QUOTEDAY);
//		tradeVolume = Long.parseLong(fixData.getAt(FixDateDefine.IDX_TRADEVOLUME));
//		lots = Long.parseLong(fixData.getAt(FixDateDefine.IDX_LOTS));
//	}
//
//	public void setQuoteData(QuoteData data) {
//		instrument = data.getInstrument();
//		instrumentType = data.getInstrumentType();
//		quoteTime = data.getQuoteTime();
//		highPrice = data.getHighPrice();
//		lowPrice = data.getLowPrice();
//		yclosePrice = data.getYclosePrice();
//		bid = data.getBid();
//		ask = data.getAsk();
//		lastBid = data.getLastBid();
//		tradeable = data.isTradeable();
//		close = data.isClose();
//		quoteDay = data.getQuoteDay();
//		tradeVolume = data.getTradeVolume();
//		lots = data.getLots();
//	}
//
//	public QuoteData getQuoteData() {
//		QuoteData data = new QuoteData();
//		data.setInstrument(instrument);
//		data.setInstrumentType(instrumentType);
//		data.setQuoteTime(quoteTime);
//		data.setHighPrice(highPrice);
//		data.setLowPrice(lowPrice);
//		data.setYclosePrice(yclosePrice);
//		data.setBid(bid);
//		data.setAsk(ask);
//		data.setLastBid(lastBid);
//		data.setTradeable(tradeable);
//		data.setClose(close);
//		data.setQuoteDay(quoteDay);
//		data.setTradeVolume(tradeVolume);
//		data.setLots(lots);
//		return data;
//	}
//
//	public String getInstrument() {
//		return instrument;
//	}
//
//	public void setInstrument(String instrument) {
//		this.instrument = instrument;
//	}
//
//	public String getInstrumentType() {
//		return instrumentType;
//	}
//
//	public void setInstrumentType(String instrumentType) {
//		this.instrumentType = instrumentType;
//	}
//
//	public long getQuoteTime() {
//		return quoteTime;
//	}
//
//	public void setQuoteTime(long quoteTime) {
//		this.quoteTime = quoteTime;
//	}
//
//	public double getOpenPrice() {
//		return openPrice;
//	}
//
//	public void setOpenPrice(double openPrice) {
//		this.openPrice = openPrice;
//	}
//
//	public double getHighPrice() {
//		return highPrice;
//	}
//
//	public void setHighPrice(double highPrice) {
//		this.highPrice = highPrice;
//	}
//
//	public double getLowPrice() {
//		return lowPrice;
//	}
//
//	public void setLowPrice(double lowPrice) {
//		this.lowPrice = lowPrice;
//	}
//
//	public double getYclosePrice() {
//		return yclosePrice;
//	}
//
//	public void setYclosePrice(double yclosePrice) {
//		this.yclosePrice = yclosePrice;
//	}
//
//	public double getBid() {
//		return bid;
//	}
//
//	public void setBid(double bid) {
//		this.bid = bid;
//	}
//
//	public double getAsk() {
//		return ask;
//	}
//
//	public void setAsk(double ask) {
//		this.ask = ask;
//	}
//
//	public double getLastBid() {
//		return lastBid;
//	}
//
//	public void setLastBid(double lastBid) {
//		this.lastBid = lastBid;
//	}
//
//	public boolean isTradeable() {
//		return tradeable;
//	}
//
//	public void setTradeable(boolean tradeable) {
//		this.tradeable = tradeable;
//	}
//
//	public boolean isClose() {
//		return close;
//	}
//
//	public void setClose(boolean close) {
//		this.close = close;
//	}
//
//	public String getQuoteDay() {
//		return quoteDay;
//	}
//
//	public void setQuoteDay(String quoteDay) {
//		this.quoteDay = quoteDay;
//	}
//
//	public long getTradeVolume() {
//		return tradeVolume;
//	}
//
//	public void setTradeVolume(long tradeVolume) {
//		this.tradeVolume = tradeVolume;
//	}
//
//	public long getLots() {
//		return lots;
//	}
//
//	public void setLots(long lots) {
//		this.lots = lots;
//	}
//
// }
