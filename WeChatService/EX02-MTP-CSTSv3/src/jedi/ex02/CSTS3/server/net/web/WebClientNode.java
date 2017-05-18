package jedi.ex02.CSTS3.server.net.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;

import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5001;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5001;
import jedi.ex02.CSTS3.comm.jsondata.C3_CSTSPing;
import jedi.ex02.CSTS3.comm.jsondata.C3_KickBySysNode;
import jedi.ex02.CSTS3.comm.jsondata.C3_KickOutNode;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteRequest;
import jedi.ex02.CSTS3.comm.jsondata.C3_VolumnRequest;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.net.I_NetJob;
import jedi.ex02.CSTS3.server.net.I_ClientNode;
import jedi.ex02.CSTS3.server.net.NewSocketDealer;
import jedi.v7.comm.ServCallNameTable;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.ctrl.comm.IPOP.IP_CTRL5001;
import jedi.v7.quote.common.QuoteData;
import jedi.v7.quote.common.QuoteSizeData;
import jedi.v7.trade.comm.IPOP.TradeServiceErrCodeTable;
import allone.CADTS.proxy.ping.PingResult;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;

public class WebClientNode implements I_ClientNode {
	private String _hashID = System.currentTimeMillis() + "_" + this.hashCode()
			+ "_" + Math.random();
	private boolean logined = false;
	private String aeid;
	private int maxOnlineNum;
	private String[] fixedIPAddress;
	private HashSet<String> groupSet = new HashSet<String>();
	private String ipAddress;
	private long loginTime;
	private long firstLoginTime;
	private boolean isDestroy = false;

	private long destroyTime;

	private HashSet<String> quoteNameSet = new HashSet<String>();
	private HashSet<String> needToSendVolumnSet = new HashSet<String>();

	private I_NetJob netJob;

	public WebClientNode(I_NetJob netJob) {
		this.netJob = netJob;
		this.ipAddress = netJob.getIpAddress();
		netJob.init(this);
	}
	
	public int getType() {
		return NewSocketDealer.type_flex;
	}

	public void addObjectToSend(Object obj) {
		if (obj instanceof QuoteSizeData[]) {
		} else if (obj instanceof QuoteData[]) {
			QuoteData[] quotes = (QuoteData[]) obj;
			for (QuoteData data : quotes) {
				if (Math.abs(data.getQuoteTime() - System.currentTimeMillis()) > 60 * 1000) {
					System.out.println(data.getQuoteTime() + ":"
							+ System.currentTimeMillis());
				}
				C3_QuoteData quote = new C3_QuoteData();
				try {
					quote.parseFromSysData(data);
					sendQuote(quote);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else if (obj instanceof C3_OPFather) {
			sendJsonData((AbstractJsonData) obj);
		} else if (obj instanceof C3_InfoFather) {
			sendJsonData((AbstractJsonData) obj);
		}

	}

	private void sendJsonData(AbstractJsonData data) {
		netJob.sendJsonData(data, true, true, false);
	}

	private void sendQuote(C3_QuoteData quote) {
		if (StaticContext.getCSConfigCaptain().isSendAllQuote()) {
			netJob.sendQuote(quote);
		} else if (this.quoteNameSet.contains(quote.getInstrument())) {
			netJob.sendQuote(quote);
		}
	}

	private void setVolumnRequest(C3_VolumnRequest request) {
		needToSendVolumnSet.clear();
		for (int i = 0; i < request.getInstruments().length; i++) {
			needToSendVolumnSet.add(request.getInstruments()[i]);
			this.addObjectToSend(StaticContext.getCSTSDoc().getVolumn(
					request.getInstruments()[i]));
		}
	}

	private boolean onLogin(C3_IP_TRADESERV5001 ip, C3_OPFather _op) {
		if (logined) {
			return false;
		}
		try {
			if (_op.isSucceed()) {
				C3_OP_TRADESERV5001 op = (C3_OP_TRADESERV5001) _op;
				if (op.getResult() == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
					loginTime = op.getLoginTime();
					if (ip.getFirstLoginTime() > 0) {
						firstLoginTime = ip.getFirstLoginTime();
					} else {
						firstLoginTime = loginTime;
					}
					aeid = ip.getUserName();
					maxOnlineNum = op.getMaxOnlineNumber();
					fixedIPAddress = op.getFixedIPVector();
					groupSet.addAll(Arrays.asList(op.getGroupVec()));
					//accountID = op.getAccount();
					logined = true;
				} else {
					logined = false;
				}
			}
			netJob.sendJsonData(_op, true, true, true);
		} catch (Exception e) {
			e.printStackTrace();
			logined = false;
		}
		return logined;
	}

	public void kickedOutBySystem() {
		if (!isDestroy) {
			this.logined = false;
			isDestroy = true;
			new Thread() {
				public void run() {
					C3_KickBySysNode kicknode = new C3_KickBySysNode();
					netJob.sendJsonData(kicknode, true, false, true);
					netJob.destroy();
				}
			}.start();
			StaticContext.getCSTSDoc().removeClient(this);
		}
	}

	public void kickedOut(final String kickerIPAddress) {
		if (!isDestroy) {
			this.logined = false;
			isDestroy = true;
			new Thread() {
				public void run() {
					C3_KickOutNode kicknode = new C3_KickOutNode();
					kicknode.setKickerIp(kickerIPAddress);
					netJob.sendJsonData(kicknode, true, false, true);
					netJob.destroy();
				}
			}.start();
			StaticContext.getCSTSDoc().removeClient(this);
		}
	}

	public void destroy() {
		if (!isDestroy) {
			destroyTime = System.currentTimeMillis();
			isDestroy = true;
			netJob.destroy();
			StaticContext.getCSTSDoc().removeClient(this);
		}
	}

	public void destroyDontRemove() {
		if (!isDestroy) {
			destroyTime = System.currentTimeMillis();
			isDestroy = true;
			netJob.destroy();
		}
	}

	public void dealWithInData(AbstractJsonData indata) {
		if (indata instanceof C3_IPFather) {
			C3_IPFather ip = (C3_IPFather) indata;
			
			new Thread(new Runnable4Client_trade(this, ip)).start();
		} else if (indata instanceof C3_QuoteRequest) {
			C3_QuoteRequest request = (C3_QuoteRequest) indata;
			HashSet<String> set = new HashSet<String>();
			ArrayList<String> templist = new ArrayList<String>();
			for (int i = 0; i < request.getInstruments().length; i++) {
				String tempins = request.getInstruments()[i];
				if (!this.quoteNameSet.contains(tempins)) {
					templist.add(tempins);
				}
				set.add(tempins);
			}
			this.quoteNameSet = set;
		} else if (indata instanceof C3_VolumnRequest) {
			C3_VolumnRequest request = (C3_VolumnRequest) indata;
			setVolumnRequest(request);
		} else if (indata instanceof C3_CSTSPing) {
			C3_CSTSPing ping = (C3_CSTSPing) indata;
			PingResult result = StaticContext.getCADTSCaptain()
					.getPingCaptain().getPingResult();
			if (result.isTimeout()) {
				destroy();
			} else {
				ping.setServerDelay(result.getPing());
				netJob.sendJsonData(ping, false, false, true);
			}
		} else {
			if (!this.isLogined()) {
				this.destroy();
			}
		}
	}

	private void tellCtrlNewUserLogin() {
		IP_CTRL5001 ip = new IP_CTRL5001();
		ip.setType(IP_CTRL5001.TYPE_USER);
		ip.setCSTSName(StaticContext.getCSConfigCaptain().getCstsName());
		ip.setMaxOnlineNum(this.getMaxOnlineNum());
		ip.setUserGUID(this.getHashID());
		ip.setUserIP(this.getIpAddress());
		ip.setUserName(this.getAeid());
		try {
			StaticContext.getCADTSCaptain().trade(
					ServCallNameTable.SERV_MTP4_CTRL,
					ServCallNameTable.FUN_MTP4_TRADE,
					ServCallNameTable.DATA_MTP4_DATA, ip);
		} catch (Exception e) {
		}
	}

	void runDealWithTrade(C3_IPFather _ip) {
		if (!this.isLogined()) {
			boolean loginSucceed = false;
			if (_ip.getID().equalsIgnoreCase("TRADESERV5001")) {
				C3_IP_TRADESERV5001 ip = (C3_IP_TRADESERV5001) _ip;
				if (StaticContext.getCSTSDoc().isUserForbidden(ip.getUserName())) {
					this.destroy();
					return;
				}
				ip.setIPAddress(this.getIpAddress());
				C3_OPFather op = StaticContext.getClientTradeCaptain().doClientTrade(ip, ip.getUserName(),this.ipAddress);
				loginSucceed = onLogin(ip, op);
			}
			if (loginSucceed) {
				StaticContext.getCSTSDoc().addClient(this);
				tellCtrlNewUserLogin();
			} else {
				this.destroy();
			}
		} else {
			if (!forcedToFixIP(_ip)) {
				C3_OPFather op = new C3_OPFather(_ip);
				op.setSucceed(false);
				op.setErrCode(TradeServiceErrCodeTable.ERR_Unknown);
				op.setErrMessage("Fix ip failed!");
				this.addObjectToSend(op);
				return;
			}
			C3_OPFather op = StaticContext.getClientTradeCaptain()
					.doClientTrade(_ip, this.aeid, this.ipAddress);
			this.addObjectToSend(op);
		}
	}

	private boolean forcedToFixIP(C3_IPFather ip) {
		ip.setUserName(this.getAeid());
		return true;
	}

	public boolean isLogined() {
		return logined;
	}

	public String getAeid() {
		return aeid;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public long getLoginTime() {
		return loginTime;
	}

	public String getHashID() {
		return _hashID;
	}

	public int getMaxOnlineNum() {
		return maxOnlineNum;
	}

	public AESSecretKey getCryptSecretKey() throws Exception {
		return netJob.getCryptSecretKey();
	}

	public long getDestroyTime() {
		return destroyTime;
	}

	public String getSecKeyDigest() throws Exception {
		byte keyBuf[] = netJob.getCryptSecretKey().getKey().getEncoded();
		return allone.crypto.Digest
				.MdigestMD5(keyBuf == null ? new byte[] { 01 } : keyBuf);
	}

	// public boolean isDebug_isSendingData() {
	// return debug_isSendingData;
	// }

	public long getFirstLoginTime() {
		return this.firstLoginTime;
	}

	public void onDestroy() {
		if (!isDestroy) {
			destroyTime = System.currentTimeMillis();
			isDestroy = true;
			StaticContext.getCSTSDoc().removeClient(this);
		}
	}

	@Override
	public String[] getFixedIPAddress() {
		return fixedIPAddress;
	}

	@Override
	public String get_hashID() {
		return _hashID;
	}

	@Override
	public HashSet<String> getGroupSet() {
		return groupSet;
	}
	
}

class Runnable4Client_trade implements Runnable {
	private WebClientNode clientNode;
	private C3_IPFather ip;

	public Runnable4Client_trade(WebClientNode clientNode, C3_IPFather ip) {
		this.clientNode = clientNode;
		this.ip = ip;
	}

	public void run() {
		clientNode.runDealWithTrade(ip);
	}
}

// class Runnable4Client_news implements Runnable {
// private ClientNode clientNode;
// private RequestFather req;

// public Runnable4Client_news(ClientNode clientNode, RequestFather req) {
// this.clientNode = clientNode;
// this.req = req;
// }

// public void run() {
// clientNode.runDealWithNews(req);
// }
// }
