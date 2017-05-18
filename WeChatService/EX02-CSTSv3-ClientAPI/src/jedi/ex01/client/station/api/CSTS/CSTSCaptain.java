package jedi.ex01.client.station.api.CSTS;

import java.net.Socket;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.jsondata.KickOutNode;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.comm.struct.QuoteSizeData;
import jedi.ex01.CSTS3.proxy.client.CSTSProxy;
import jedi.ex01.CSTS3.proxy.client.DataListener;
import jedi.ex01.CSTS3.proxy.client.ping.PingCaptain;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;
import jedi.ex01.client.station.api.info.InfoCaptain;
import allone.json.AbstractJsonData;
import allone.util.socket.address.AddressCaptain;
import allone.util.socket.address.AddressNode;

public class CSTSCaptain implements DataListener {
	public static boolean debug = false;
	private static CSTSCaptain instance = new CSTSCaptain();

	String ATTRNAME_CMD = "ATTRNAME_CMD";
	String ATTR_QUERYSYSTEM = "ATTRNAME_QUERYSYSTEM";
	String ATTRNAME_ID = "ATTRNAME_ID";
	private CSTSProxy proxy;
	private boolean inited = false;

	private CSTSCaptain() {
	}

	public static CSTSCaptain getInstance() {
		return instance;
	}

	public boolean init(AddressCaptain captain, AddressNode address)
			throws Exception {
		inited = false;
		if (proxy != null) {
			proxy.destroy();
			proxy = null;
		}
		proxy = new CSTSProxy();
		Socket socket = captain.createSocket(address);
		// Socket[addr=/192.168.0.216,port=54321,localport=51248]
		if (!proxy.init(socket, this)) {
			return false;
		}
		System.out.println("net init finished!");
		inited = true;
		return true;
	}

	@Override
	public void onInforRec(InfoFather arg0) {
		// System.out.println(arg0);
		boolean result = InfoCaptain.getInstance().onInfo(arg0);
	}

	@Override
	public void onQuoteRec(QuoteData[] quotes) {
		for (int i = 0; i < quotes.length; i++) {
			QuoteData quote = quotes[i];
			doDispachQuote(quote);
		}
	}

	public void doDispachQuote(QuoteData quoteData) {
		if (quoteData != null) {
			DataDoc.getInstance().addQuote(quoteData);
			API_IDEventCaptain.fireEventChanged(
					API_IDEvent_NameInterface.DATA_ON_NewQuote, quoteData);
		}
	}

	@Override
	public void onNetLost() {
		if (inited) {
			NetInfoNode info = new NetInfoNode();
			info.setIpAddress(ClientAPI.getInstance().getCurrentAddress()
					.getIp());
			info.setPort(ClientAPI.getInstance().getCurrentAddress().getPort());
			info.setTime(System.currentTimeMillis());
			info.setType(NetInfoNode.TYPE_LOST);
			info.setReason(NetInfoNode.REASON_NETLOST);
			System.out
					.println("*********************** Net Lost Notified by API");
			// add by Sean,2010-01-25
			destroy();
			// end
			if (ClientAPI.getInstance() != null) {
				API_IDEventCaptain
						.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_NET_LOST);
				API_IDEventCaptain
						.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT);
			}
		} else {
			System.out
					.println("*********************** Net Lost ,not inited, API");
		}
	}

	public OPFather trade(IPFather ip) {
		long begin = System.currentTimeMillis();
		if (!inited || proxy == null) {
			OPFather opfather = new OPFather(ip);
			opfather.setSucceed(false);
			opfather.setErrCode("NetLost网络连接失败");
			opfather.setErrMessage("Proxy lost net connection代理网络无法连接");
			// LogProxy.printTrade(ip.get_ID(), ip, opfather,
			// opfather.isSucceed());
			return opfather;
		}
		OPFather opfather = proxy.doTrade(ip);
		long end = System.currentTimeMillis();
		opfather.setUsedTime(end - begin);
		// LogProxy.printTrade(ip.get_ID(), ip, opfather, opfather.isSucceed());
		return opfather;
	}

	public void sendObject(AbstractJsonData obj) {
		proxy.addDataToSend(obj);
	}

	public void destroy() {
		inited = false;
		if (proxy != null) {
			proxy.destroy();
			proxy = null;
		}
	}

	@Override
	public void onKickedOut(KickOutNode kick) {
		if (inited) {
			API_IDEventCaptain.fireEventChanged(
					API_IDEvent_NameInterface.OTHER_ON_KICKOUT, kick);
		}
	}

	@Override
	public void onVolumnRec(QuoteSizeData[] quoteSizeDatas) {
		for (int i = 0; i < quoteSizeDatas.length; i++) {
			QuoteSizeData qsd = quoteSizeDatas[i];
			if (qsd == null) {
				continue;
			}
			Instrument ins = DataDoc.getInstance().getInstrument(
					qsd.getInstrument());
			if (ins == null) {
				continue;
			}
			double lots = qsd.getAmmount() / ins.getAmountPerLot();
			if (qsd.getPriceType() == MTP4CommDataInterface.PRICETYPE_BID) {
				// ListenerCaptain.getApiDataChangeListener().onNewBidVolumn(ins.getInstrument(),
				// lots);
			} else if (qsd.getPriceType() == MTP4CommDataInterface.PRICETYPE_ASK) {
				// ListenerCaptain.getApiDataChangeListener().onNewAskVolumn(ins.getInstrument(),
				// lots);
			}
		}
	}

	@Override
	public void onKickedOutBySys() {
		if (inited) {
			API_IDEventCaptain
					.fireEventChanged(API_IDEvent_NameInterface.OTHER_ON_KICK_BY_SYS);
		}
	}

	@Override
	public void onPing(long ping, long avePing, double lostPerc) {
		API_IDEventCaptain.fireEventChanged(
				API_IDEvent_NameInterface.OTHER_ON_PING, ping, avePing,
				lostPerc);
	}

	@Override
	public void onPingTimeOut() {
		PingCaptain.getCurrentInstance().clearTimeoutRecords();
		AddressNode address = ClientAPI.getInstance().getAddressCaptain()
				.getBestAddress();
		AddressNode current = ClientAPI.getInstance().getCurrentAddress();
		API_IDEvent timeOut = new API_IDEvent(
				API_IDEvent_NameInterface.DEBUG_NET_TIMEOUT);
		StringBuffer sb = new StringBuffer();
		sb.append("------------------------------------------------------------\r\n");
		sb.append("current:" + current.getName() + " | " + current.getIp()
				+ " | " + current.getPort() + " | " + current.getPing()
				+ "\r\n");
		sb.append("best   :" + address.getName() + " | " + address.getIp()
				+ " | " + address.getPort() + " | " + address.getPing()
				+ "\r\n");
		if (address.getIp().equals(current.getIp())
				&& address.getPort() == current.getPort()) {
			if (address.getPing() >= (PingCaptain.getTIMEOUTPING())) {
				sb.append("result :reject by ping\r\n");
				timeOut.setEventData(new Object[] { sb.toString() });
				API_IDEventCaptain.getInstance().fireEventChanged(timeOut);
				return;
			}
		} else {
			if (address.getPing() >= (PingCaptain.getTIMEOUTPING() * 2)) {
				sb.append("result :reject by ping\r\n");
				timeOut.setEventData(new Object[] { sb.toString() });
				API_IDEventCaptain.getInstance().fireEventChanged(timeOut);
				return;
			}
		}
		sb.append("result :reconnect\r\n");
		timeOut.setEventData(new Object[] { sb.toString() });
		API_IDEventCaptain.getInstance().fireEventChanged(timeOut);
		NetInfoNode info = new NetInfoNode();
		info.setIpAddress(ClientAPI.getInstance().getCurrentAddress().getIp());
		info.setPort(ClientAPI.getInstance().getCurrentAddress().getPort());
		info.setTime(System.currentTimeMillis());
		info.setType(NetInfoNode.TYPE_LOST);
		info.setReason(NetInfoNode.REASON_TIMEOUT);
		System.out.println("*********************** Net Lost Notified by API");
		long t1 = System.currentTimeMillis();
		destroy();
		long t2 = System.currentTimeMillis();
		long tgap = t2 - t1;

		if (ClientAPI.getInstance() != null) {
			API_IDEventCaptain.fireEventChanged(
					API_IDEvent_NameInterface.DEBUG_INFO,
					"Destroy used time : " + tgap);
			API_IDEventCaptain.fireEventChanged(
					API_IDEvent_NameInterface.NAME_ON_NET_LOST, info);
			API_IDEventCaptain
					.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT);

		}

	}

	public boolean isNetOK() {
		if (proxy == null) {
			return false;
		}
		return proxy.isLogined();
	}

}
