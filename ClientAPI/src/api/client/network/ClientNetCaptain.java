package api.client.network;

import java.util.HashMap;

import proxy.DataListener;
import proxy.DealerProxy;
import allone.util.socket.address.AddressCaptain;
import allone.util.socket.address.AddressNode;

import comm.KickBySysNode;
import comm.KickOutNode;
import comm.SplitOPeventListener;
import comm.message.IPFather;
import comm.message.OPFather;

public class ClientNetCaptain implements DataListener {
	private static ClientNetCaptain instance = new ClientNetCaptain();
	private static HashMap<String, Long> timeGapMap = new HashMap<String, Long>();

	private DealerProxy proxy;
	private boolean inited = false;

	private ClientNetCaptain() {
	}

	public static ClientNetCaptain getInstance() {
		return instance;
	}

	public boolean init(AddressCaptain captain, AddressNode address) throws Exception {
		inited = false;
		if (proxy != null) {
			proxy.destroy();
			proxy = null;
		}

		proxy = new DealerProxy();
		if (!proxy.init(captain.createSocket(address), this, timeGapMap)) {
			return false;
		}

		System.out.println("net init finished!");
		inited = true;
		return true;
	}

	public void sendObject(Object obj) {
		if (proxy != null) {
			proxy.addDataToSend(obj);
		}
	}

	// public void onInforRec(FundInforFather info) {
	// InfoCaptain.getInstance().onInfo(info);
	// }

	// public void onQuoteRec(QuoteData[] quotes) {
	// if (inited) {
	// //
	// // update quote into cache
	// //
	// IFundDataCenter fdCenter = FundDealerApi.getInstance().getDataCenter();
	// QuoteCache quoteCache = (QuoteCache) fdCenter.getQuoteCache();
	// quoteCache.setQuote(quotes);
	// //
	// // fix position when quote changed
	// //
	// FundPositionScaner.scanerFundPosition();
	// //
	// // fire event to notify ui the quote changed.
	// //
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onQuoteReceived,
	// quotes);
	// }
	// }

	// public void onNetLost() {
	// if (inited && FundDealerApi.getInstance().getIsLogined()) {
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onNetLost, null);
	// }
	// }

	public OPFather doTrade(IPFather ip) {
		return this.doTrade(ip, null);
	}

	public OPFather doTrade(IPFather ip, SplitOPeventListener listener) {
		OPFather opfather = proxy.doTrade(ip, listener);
		return opfather;
	}

	public void destroy() {
		inited = false;
		if (proxy != null) {
			proxy.destroy();
		}
	}

	@Override
	public void onNetLost() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onKickedOut(KickOutNode kicknode) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onKickBySysNode(KickBySysNode kickNode) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onPing(long ping, long avePing, double lostPerc) {
		// TODO Auto-generated method stub
		
	}

	// public void onKickedOut(KickOutNode kick) {
	// if (inited) {
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onKickOut, kick);
	// }
	// }

	// public void onSimpleNews(SimpleNewsNode simpleNews) {
	// if (inited) {
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onSimpleNews,
	// simpleNews);
	// }
	// }

	// public void onKickBySysNode(KickBySysNode kickNode) {
	// if (inited) {
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onKickOutBySystem,
	// kickNode);
	// }
	// }

	// public void onPing(long ping, long avePing, double lostPerc) {
	// NetPingData pingData = new NetPingData(ping, avePing, lostPerc);
	// FundDealerApi.getInstance().fireEvent(ApiEventNameList.onNetPing,
	// pingData);
	// }

	// public void onOtherData(Object data) {
	// LogFactory.getLogLayer().logObject(data);
	// }
}
