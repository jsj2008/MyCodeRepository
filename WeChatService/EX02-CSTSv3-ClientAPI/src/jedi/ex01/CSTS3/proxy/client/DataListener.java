package jedi.ex01.CSTS3.proxy.client;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.jsondata.KickOutNode;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.comm.struct.QuoteSizeData;

public interface DataListener {
	public void onQuoteRec(QuoteData[] quote);
	
	public void onVolumnRec(QuoteSizeData[] quoteSize);

	public void onInforRec(InfoFather info);
	
	public void onNetLost();
	public void onPing(long  ping,long avePing,double lostPerc);
	public void onKickedOut(KickOutNode kicknode);
	public void onKickedOutBySys();
	public void onPingTimeOut();
	
}
