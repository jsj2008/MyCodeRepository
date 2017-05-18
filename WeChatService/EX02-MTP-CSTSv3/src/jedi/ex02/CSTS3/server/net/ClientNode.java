package jedi.ex02.CSTS3.server.net;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5001;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5001;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5040;
import jedi.ex02.CSTS3.comm.jsondata.C3_CSTSPing;
import jedi.ex02.CSTS3.comm.jsondata.C3_KickBySysNode;
import jedi.ex02.CSTS3.comm.jsondata.C3_KickOutNode;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteRequest;
import jedi.ex02.CSTS3.comm.jsondata.C3_VolumnRequest;
import jedi.ex02.CSTS3.comm.struct.C3_GroupConfig;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteSizeData;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.debug.DebugLogCaptain;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.quote.common.QuoteData;
import jedi.v7.quote.common.QuoteSizeData;
import jedi.v7.trade.comm.IPOP.TradeServiceErrCodeTable;
import allone.CADTS.proxy.ping.PingResult;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;

public class ClientNode implements I_ClientNode {
	private String _hashID = System.currentTimeMillis() + "_" + this.hashCode() + "_" + Math.random();
	private boolean logined = false;
	private String aeid;
	private int type;
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

	public ClientNode(I_NetJob netJob, int type) {
		this.netJob = netJob;
		this.ipAddress = netJob.getIpAddress();
		this.type = type;
		netJob.init(this);
	}

	public void addObjectToSend(Object obj) {
		if (obj instanceof QuoteSizeData[]) {
			QuoteSizeData[] quotes = (QuoteSizeData[]) obj;
			for (QuoteSizeData data : quotes) {
				C3_QuoteSizeData quote = new C3_QuoteSizeData();
				try {
					quote.parseFromSysData(data);
					sendVolumn(quote);
				} catch (Exception e) {
				}
			}
		} else if (obj instanceof QuoteData[]) {
			QuoteData[] quotes = (QuoteData[]) obj;
			for (QuoteData data : quotes) {
				if (Math.abs(data.getQuoteTime() - System.currentTimeMillis()) > 60 * 1000) {
					System.out.println(data.getQuoteTime() + ":" + System.currentTimeMillis());
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

	private void sendVolumn(C3_QuoteSizeData quote) {
		if (this.needToSendVolumnSet.contains(quote.getInstrument())) {
			netJob.sendVolumn(quote);
		}
	}

	private void setVolumnRequest(C3_VolumnRequest request) {
		needToSendVolumnSet.clear();
		for (int i = 0; i < request.getInstruments().length; i++) {
			needToSendVolumnSet.add(request.getInstruments()[i]);
			this.addObjectToSend(StaticContext.getCSTSDoc().getVolumn(request.getInstruments()[i]));
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
					groupSet.addAll(Arrays.asList(op.getGroupVec()));
					aeid = ip.getUserName();
					maxOnlineNum = op.getMaxOnlineNumber();
					fixedIPAddress = op.getFixedIPVector();
					if (fixedIPAddress != null && fixedIPAddress.length > 0) {
						logined = false;
						for (int i = 0; i < fixedIPAddress.length; i++) {
							if (fixedIPAddress[i].equals(this.ipAddress)) {
								logined = true;
								break;
							}
						}
						if (!logined) {
							op.setResult(MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_IP_ERR);
						}
					} else {
						logined = true;
					}
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

	public void dealWithInData(AbstractJsonData indata) {
		// System.out.println(indata);
		DebugLogCaptain.getInstance().log(ipAddress, "dealWithInData: " + ipAddress + " | " + indata);
		if (indata instanceof C3_IPFather) {
			C3_IPFather ip = (C3_IPFather) indata;
			new Thread(new Runnable4Client_trade(this, ip)).start();
		} else if (indata instanceof C3_QuoteRequest) {
			// System.out
			// .println("-------------------------------------------------");
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
			// for (Object obj : set) {
			// System.out.println("["+obj+"]");
			// }

			// System.out
			// .println("-------------------------------------------------");
			this.quoteNameSet = set;
		} else if (indata instanceof C3_VolumnRequest) {
			C3_VolumnRequest request = (C3_VolumnRequest) indata;
			setVolumnRequest(request);
		} else if (indata instanceof C3_CSTSPing) {
			C3_CSTSPing ping = (C3_CSTSPing) indata;
			PingResult result = StaticContext.getCADTSCaptain().getPingCaptain().getPingResult();
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
		DebugLogCaptain.getInstance().log(ipAddress, "dealWithInData end");
		DebugLogCaptain.getInstance().printLog();
	}

	void runDealWithTrade(C3_IPFather _ip) {
		DebugLogCaptain.getInstance().log(ipAddress, "runDealWithTrade: " + ipAddress + " | " + _ip);
		if (!this.isLogined()) {
			DebugLogCaptain.getInstance().log(ipAddress, "begin login ");
			boolean loginSucceed = false;
			if (_ip.getID().equalsIgnoreCase("TRADESERV5001")) {
				C3_IP_TRADESERV5001 ip = (C3_IP_TRADESERV5001) _ip;
				if (StaticContext.getCSTSDoc().isUserForbidden(ip.getUserName())) {
					this.destroy();
					return;
				}
				ip.setIPAddress(this.getIpAddress());
				C3_OPFather op = StaticContext.getClientTradeCaptain().doClientTrade(ip, ip.getUserName(), this.ipAddress);
				loginSucceed = onLogin(ip, op);
			}
			DebugLogCaptain.getInstance().log(ipAddress, "login result:"+loginSucceed);
			if (loginSucceed) {
				StaticContext.getCSTSDoc().addClient(this);
			} else {
				this.destroy();
			}
			DebugLogCaptain.getInstance().log(ipAddress, "login end:");
		} else {
			if (!forcedToFixIP(_ip)) {
				C3_OPFather op = new C3_OPFather(_ip);
				op.setSucceed(false);
				op.setErrCode(TradeServiceErrCodeTable.ERR_Unknown);
				op.setErrMessage("Fix ip failed!");
				this.addObjectToSend(op);
				DebugLogCaptain.getInstance().log(ipAddress, "runDealWithTrade end");
				DebugLogCaptain.getInstance().printLog();
				return;
			}
			DebugLogCaptain.getInstance().log(ipAddress, "trade begin");
			C3_OPFather op = StaticContext.getClientTradeCaptain().doClientTrade(_ip, this.aeid, this.ipAddress);
			if (op.isSucceed()) {
				if (_ip.getID().equals("TRADESERV5040")) {
					C3_OP_TRADESERV5040 op_TRADESERV5040 = (C3_OP_TRADESERV5040) op;
					C3_GroupConfig groupCfg = op_TRADESERV5040.getGroupConfig();
					groupSet.clear();
					groupSet.add(groupCfg.getGroupName());
				} else if (_ip.getID().equals("Web1001")) {

				}
			}
			DebugLogCaptain.getInstance().log(ipAddress, "trade end");
			this.addObjectToSend(op);
		}
		DebugLogCaptain.getInstance().log(ipAddress, "runDealWithTrade end");
		DebugLogCaptain.getInstance().printLog();
	}

	// void runDealWithNews(RequestFather req) {
	// ResponseFather op = StaticContext.getTradeCaptain().doClientQueryNews(
	// req, aeid, ipAddress);
	// this.addObjectToSend(op);
	// }

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

	public String[] getFixedIPAddress() {
		return fixedIPAddress;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public long getLoginTime() {
		return loginTime;
	}

	public String get_hashID() {
		return _hashID;
	}

	public int getMaxOnlineNum() {
		return maxOnlineNum;
	}

	public boolean checkGroup(String groupName) {
		return this.groupSet.contains(groupName);
	}

	public AESSecretKey getCryptSecretKey() {
		return netJob.getCryptSecretKey();
	}

	public HashSet<String> getGroupSet() {
		return groupSet;
	}

	public long getDestroyTime() {
		return destroyTime;
	}

	public String getSecKeyDigest() {
		byte keyBuf[] = netJob.getCryptSecretKey().getKey().getEncoded();
		return allone.crypto.Digest.MdigestMD5(keyBuf == null ? new byte[] { 01 } : keyBuf);
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

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}

class Runnable4Client_trade implements Runnable {
	private ClientNode clientNode;
	private C3_IPFather ip;

	public Runnable4Client_trade(ClientNode clientNode, C3_IPFather ip) {
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
