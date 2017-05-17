package proxy;

import comm.KickBySysNode;
import comm.KickOutNode;

public interface DataListener {
	// public void onQuoteRec(QuoteData[] quote);
	//
	// public void onInforRec(FundInforFather info);

	public void onNetLost();

	public void onKickedOut(KickOutNode kicknode);

	public void onKickBySysNode(KickBySysNode kickNode);

	public void onPing(long ping, long avePing, double lostPerc);

	// public void onOtherData(Object obj);

}
