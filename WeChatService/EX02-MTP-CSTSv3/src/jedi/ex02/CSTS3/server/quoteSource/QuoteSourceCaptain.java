package jedi.ex02.CSTS3.server.quoteSource;

import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.quote.common.HistoricData;
import jedi.v7.quote.common.QuoteData;
import allone.quote.terminal.v01.CQTS.api.CQTSApi;
import allone.quote.terminal.v01.CQTS.api.listener.CQTSListener;
import allone.quote.terminal.v01.CQTS.api.listener.UserInfoOffer;
import allone.quote.terminal.v01.CQTS.api.net.CQTSClientNode;
import allone.quote.terminal.v01.comm.info.QuoteGateWayInforFather;
import allone.util.socket.address.AddressRecord;

public class QuoteSourceCaptain implements CQTSListener, UserInfoOffer {
	private final static QuoteSourceCaptain instance = new QuoteSourceCaptain();

	public static QuoteSourceCaptain getInstance() {
		return instance;
	}

	private CQTSApi api = new CQTSApi();

	public boolean init(String quoteSourceFile, boolean liveNotDemo) throws Exception {
		api.preAddSource(quoteSourceFile, liveNotDemo);
		api.init(this, this);
		return api.isConnected();
	}

	public boolean init(AddressRecord record, boolean liveNotDemo) throws Exception {
		api.preAddSource(record, liveNotDemo);
		api.init(this, this);
		return api.isConnected();
	}
	
	public void destroy() {
		api.destroy();
	}

	// user login 的字符串
	@Override
	public String getCode() {
		return "";
	}

	@Override
	public String getUserName() {
		return "";
	}

	public void onQuoteData(QuoteData quoteData) {
		StaticContext.getCSTSDoc().sendQuote(new QuoteData[]{quoteData});
	}

	public QuoteData[] getQuoteVec() throws Exception {
		return api.getQuoteVec();
	}

	public HistoricData[] getHistoricalData(String instrument, int cycle) throws Exception {
		return api.getHistoricalData(instrument, cycle);
	}

	public HistoricData[] getMoreHistoricalData(String instrument, int cycle, long fromTime) throws Exception {
		return api.getMoreHistoricalData(instrument, cycle, fromTime);
	}

	public void onQuoteInfo(QuoteGateWayInforFather info) {
		// TODO Auto-generated method stub
	}
	
	public boolean isConnected() {
		return api.isConnected();
	}

	@Override
	public void onConnected(CQTSClientNode arg0) {
		System.out.println("onConnect..." + isConnected() + " : " + getUserName());
		try {
			QuoteData[] datas = getQuoteVec();
			System.out.println(".............." + datas[0].getInstrument());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

//		InstrumentDocOperator.getInstrumentDocOperator().loadQuoteTable(null);
//		API_IDEventCaptain.getInstance().fireEventChanged(
//				new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_QT_CONNECTED, arg0, true, null));
//		ListenerCaptain.getApiOtherListener().onQTConnected(arg0);
	}

	@Override
	public void onNetLost(CQTSClientNode arg0) {
//		API_IDEventCaptain.getInstance().fireEventChanged(
//				new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_QT_NET_LOST, arg0, true, null));
//		ListenerCaptain.getApiOtherListener().onQTNetLost(arg0);
		System.out.println("Net lost......");
	}

}
