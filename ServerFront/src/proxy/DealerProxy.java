package proxy;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ObjectOutputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.security.KeyPair;
import java.security.interfaces.RSAPublicKey;
import java.util.HashMap;
import java.util.LinkedList;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import server.define.DataTypeDefine;
import allone.crypto.AES.AESSecretKey;

import comm.DealerPing;
import comm.DealerTradeWaitObject;
import comm.KickBySysNode;
import comm.KickOutNode;
import comm.OPSplitNode;
import comm.OPSplitPart;
import comm.SplitOPTradeWaitObject;
import comm.SplitOPeventListener;
import comm.codeTable.IErrorCodeTable;
import comm.fix.BasicFIXData;
import comm.fix.FixDataUtil;
import comm.fix.FixIoUtil;
import comm.fix.data.ObjectData4FIX;
import comm.message.IPFather;
import comm.message.OPFather;
import comm.split.SplitRsp;

public class DealerProxy {
	public static boolean debug = true;
	private final static byte[] precheckbuf = { 0x01, 0xa, 0x2, 0xb, (byte) 0xcd };
	private final String guid = System.currentTimeMillis() + "_" + Math.random();
	private final static int type_dealer = 2;
	private Socket socket;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;

	private boolean isDestroy = false;
	private boolean logined = false;

	private DataListener listener;

	private HashMap<String, DealerTradeWaitObject> tradeMap = new HashMap<String, DealerTradeWaitObject>();
	private LinkedList<Object> sendList = new LinkedList<Object>();
	// private HashMap<String, QuoteData> quoteMap = new HashMap<String,
	// QuoteData>();
	private HashMap<String, Long> waitGapMap = new HashMap<String, Long>();
	private HashMap<String, SplitOPTradeWaitObject> splitMap = new HashMap<String, SplitOPTradeWaitObject>();
	private HashMap<String, OPSplitNode> splitNodeMap = new HashMap<String, OPSplitNode>();
	private AESSecretKey cryptSecretKey;

	private Object _streamLock = new Object();

	private int connectType = type_dealer;

	private PingCollector pingC = new PingCollector();

	public DealerProxy() {

	}

	public boolean init(Socket socket, DataListener ls, HashMap<String, Long> waitGapMap) throws Exception {
		if (waitGapMap != null) {
			this.waitGapMap = waitGapMap;
		}
		this.socket = socket;
		this.listener = ls;
		try {
			initNet();
			initCrypt();
			sendGuid();
			this.isDestroy = false;
			this.start();
			return true;
		} catch (Exception e) {
			clearNet();
			throw e;
		}
	}

	public OPFather doTrade(IPFather ip, SplitOPeventListener splitListener) {
		if (ip.get_ID().equals("Client1001")) {
			if (logined) {
				OPFather op = new OPFather(ip);
				op.setSucceed(false);
				op.setErrCode(IErrorCodeTable.errUnknown);
				op.setErrMessage("Has logined before!");
				return op;
			}
		} else if (!logined) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IErrorCodeTable.errUnknown);
			op.setErrMessage("Not login yet!");
			return op;
		}
		debugPrint("Send new IPFather:" + ip);
		Long timeGap = null;
		try {
			timeGap = waitGapMap.get(ip.get_ID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (timeGap == null) {
			timeGap = new Long(0);
		}

//		DealerTradeWaitObject wait = new DealerTradeWaitObject(ip, timeGap, splitListener);
//		this.tradeMap.put(wait.get_hashCode(), wait);
//		long begin = System.currentTimeMillis();
//		addDataToSend(ip);
//		OPFather op = wait.waitTrade();
//		long end = System.currentTimeMillis();
//		op.set_tradeUsedTime(end - begin);
//		tradeMap.remove(wait.get_hashCode());
//		if (ip.get_ID().equals("Client1001")) {
//			if (op.isSucceed()) {
//				OP_Client1001 op1001 = (OP_Client1001) op;
//				this.logined = op1001.getResult() == DataTypeDefine.Login_Result_Success;
//			} else {
//				this.logined = false;
//			}
//		}
		
		DealerTradeWaitObject wait = new DealerTradeWaitObject(ip, timeGap, splitListener);
		this.tradeMap.put(wait.get_hashCode(), wait);
		long begin = System.currentTimeMillis();
		addDataToSend(ip);
		OPFather op = wait.waitTrade();
		long end = System.currentTimeMillis();
		op.set_tradeUsedTime(end - begin);
		tradeMap.remove(wait.get_hashCode());
		if (ip.get_ID().equals("Client1001")) {
			if (op.isSucceed()) {
				OPFather op1001 = (OPFather) op;
				this.logined = op1001.isSucceed();
			} else {
				this.logined = false;
			}
		}
		return op;
		
//		return ServerContext.getTradeCaptain().doTrade(ip);
	}

	private void sendGuid() throws Exception {
		ObjectOutputStream oos = new ObjectOutputStream(bos);
		oos.writeObject(guid);
		oos.flush();
	}

	public void destroy() {
		if (!isDestroy) {
			isDestroy = true;
			clearNet();
			DealerTradeWaitObject[] wl = (DealerTradeWaitObject[]) this.tradeMap.values().toArray(new DealerTradeWaitObject[0]);
			for (int i = 0; i < wl.length; i++) {
				wl[i].setErr();
			}
			DataListener templistener = listener;
			listener = null;
			if (templistener != null && logined) {
				templistener.onNetLost();
			}
		}
	}

	private void initNet() throws Exception {
		socket.setSoTimeout(1000 * 1000);
		socket.setSoLinger(true, 0);
		socket.setTcpNoDelay(true);
		socket.setKeepAlive(true);
		bis = new BufferedInputStream(socket.getInputStream());
		bos = new BufferedOutputStream(socket.getOutputStream());
		bos.write(precheckbuf);
		bos.flush();
		bos.write(connectType);
		bos.flush();
	}

	private void start() {
		Runnable4Client_read read = new Runnable4Client_read(this);
		Runnable4Client_send send = new Runnable4Client_send(this);
		// Runnable4Client_quoteDispatch quoteDispatch = new
		// Runnable4Client_quoteDispatch(this);
		Runnable4Client_ping pingThread = new Runnable4Client_ping(this);
		Runnable4Client_pingCheck pingCheckThread = new Runnable4Client_pingCheck(this);

		new Thread(read, "NetworkRead").start();
		new Thread(send, "NetworkSend").start();
		new Thread(pingCheckThread, "PingCheckThread").start();
		new Thread(pingThread, "PingThread").start();
		// new Thread(quoteDispatch, "QuoteDispatch").start();
	}

	private void initCrypt() throws Exception {
		long t1 = System.currentTimeMillis();
		KeyPair keypair = allone.crypto.RSA.RSACrypt.createRsaKeyPair();
		RSAPublicKey publicKey = (RSAPublicKey) keypair.getPublic();
		BigInteger modulus = publicKey.getModulus();
		BigInteger publicExponent = publicKey.getPublicExponent();
		String key = modulus.toString(16) + ";" + publicExponent.toString(16);
		byte[] buffer = key.getBytes("UTF-8");
		byte[] lengthBuff = FixDataUtil.formatInt(buffer.length + 8, 8);
		bos.write(lengthBuff);
		bos.write(buffer);
		bos.flush();

		long t2 = System.currentTimeMillis();
		byte lengthBuf[] = FixIoUtil.readBuffer(bis, 8);
		int length = Integer.valueOf(new String(lengthBuf).trim());
		byte buf[] = FixIoUtil.readBuffer(bis, length - 8);
		long t3 = System.currentTimeMillis();
		Cipher cipher = Cipher.getInstance("RSA");
		cipher.init(Cipher.DECRYPT_MODE, keypair.getPrivate());
		byte[] aesbuff = cipher.doFinal(buf);
		SecretKeySpec aeskey = new SecretKeySpec(aesbuff, "AES");
		cryptSecretKey = new AESSecretKey(aeskey);
		long t4 = System.currentTimeMillis();

		System.out.println("dealer crypt init " + (t2 - t1) + "," + (t3 - t2) + "," + (t4 - t3));
	}

	private void clearNet() {
		if (bis != null) {
			try {
				bis.close();
				bis = null;
			} catch (Exception e) {
			}
		}
		if (bos != null) {
			try {
				bos.close();
				bos = null;
			} catch (Exception e) {
			}
		}
		if (socket != null) {
			try {
				socket.close();
				socket = null;
			} catch (Exception e) {
			}
		}
	}

	private void tradeReturned(OPFather op) {
		DealerTradeWaitObject wait = (DealerTradeWaitObject) tradeMap.get(op.get_HashID());
		if (wait != null) {
			wait.tradeReturn(op);
		} else {
			System.out.println("Unknow trade wait object." + op.get_ID() + ",HashCode=" + op.get_HashID());
		}
	}

	private void splitRsp(SplitRsp op) {
		SplitOPTradeWaitObject wait = (SplitOPTradeWaitObject) splitMap.get(op.get_HashID());
		if (wait != null) {
			wait.tradeReturn(op);
		} else {
			System.out.println("Unknow split wait object.SplitRsp,HashCode=" + op.get_HashID());
		}
	}

	private void tradeTimeout(String guid) {
		DealerTradeWaitObject wait = (DealerTradeWaitObject) tradeMap.get(guid);
		if (wait != null) {
			wait.timeout();
		} else {
			System.out.println("Unknow trade wait object. HashCode=" + guid);
		}
	}

	public void addDataToSend(Object obj) {
		synchronized (this.sendList) {
			sendList.addFirst(obj);
		}
	}

	private void sendObject(BasicFIXData data, boolean isEcho) {
		synchronized (_streamLock) {
			try {
				if (isEcho) {
					FixIoUtil.writeEcho(bos);
				} else {
					FixIoUtil.writeData(data.format(), bos);
				}
				// lastSendTime = System.currentTimeMillis();
			} catch (Exception e) {
				if (!isDestroy) {
					e.printStackTrace();
					destroy();
				}
			}
		}
	}

	private BasicFIXData readObject() {
		try {
			return FixIoUtil.readData(bis, cryptSecretKey);
		} catch (Exception e) {
			if (!isDestroy) {
				debugPrint(e);
				destroy();
			}
			return null;
		}
	}

	// private void dealWithQuotes(QuoteData quote) {
	// synchronized (quoteMap) {
	// quoteMap.put(quote.getInstrument(), quote);
	// quoteMap.notifyAll();
	// }
	// }

	private void dealWithInData(final Object indata) {
		try {
			if (indata != null) {
				if (indata instanceof OPFather) {
					OPFather op = (OPFather) indata;
					debugPrint("Received new OPFather:" + op);
					tradeReturned(op);
				} else if (indata instanceof DealerPing) {
					DealerPing ping = (DealerPing) indata;
					pingC.returnPing(ping);
					if (listener != null) {
						PingResult pr = pingC.getPing();
						listener.onPing(pr.getPing(), pr.getAvePing(), pr.getLostPerc());
					}
				} else if (indata instanceof SplitRsp) {
					SplitRsp op = (SplitRsp) indata;
					debugPrint("Received new SplitRsp: index" + op);
					splitRsp(op);
				} else if (indata instanceof OPSplitPart) {
					OPSplitPart part = (OPSplitPart) indata;
					debugPrint("Received new OPSplitPart: index=" + part.getIndex());
					OPSplitNode node = splitNodeMap.get(part.getGuid());
					if (node.getListener() != null) {
						node.getListener().splitEvent(node.getMaxSplit(), node.getCurSplit());
						node.getListener().splitResult(part.getIndex(), true, null, null);
					}
					node.addSplit_Client(part.getIndex(), part.getBuf(), part.isEndPart());
				}
				// else if (indata instanceof FundInforFather) {
				// debugPrint("Received new InfoFather:" + indata);
				// new Thread() {
				// public void run() {
				// listener.onInforRec((FundInforFather) indata);
				// }
				// }.start();
				// }
				else if (indata instanceof KickOutNode) {
					logined = false;
					listener.onKickedOut((KickOutNode) indata);
					debugPrint("Kicked out by:" + ((KickOutNode) indata).getKickerIp());
				} else if (indata instanceof KickBySysNode) {
					logined = false;
					listener.onKickBySysNode((KickBySysNode) indata);
					debugPrint("Kicked out by:" + ((KickBySysNode) indata));
				} else {
					// listener.onOtherData(indata);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void runRead() {
		while (!isDestroy) {
			Object obj = null;
			BasicFIXData data = readObject();
			if (data != null) {
				if (data instanceof ObjectData4FIX) {
					ObjectData4FIX temp = (ObjectData4FIX) data;
					obj = temp.getObj();
				}
				// else if (data instanceof QuoteData4FIX) {
				// QuoteData4FIX temp = (QuoteData4FIX) data;
				// dealWithQuotes(temp.getQuoteData());
				// continue;
				// }
				// try {
				// DSTSLogCaptain.getInstance().getIDSTSProxyLog().logoutReceivePack(NetDataLogFormat.format(data));
				// } catch (Exception e) {
				// }
				dealWithInData(obj);
			}
		}
	}

	void runSend() {
		while (!isDestroy) {
			synchronized (this.sendList) {
				if (!sendList.isEmpty()) {
					ObjectData4FIX temp = new ObjectData4FIX();
					Object obj = sendList.removeLast();
					temp.setIsZip(DataTypeDefine.TRUE);
					temp.setIsEncrypt(DataTypeDefine.TRUE);
					temp.setKey(cryptSecretKey);
					temp.setObj(obj);
					sendObject(temp, false);
					continue;
				}
			}
			try {
				Thread.sleep(200);
			} catch (Exception e) {
			}
		}
	}

	void runPing() {
		while (!isDestroy) {
			if (logined) {
				ObjectData4FIX temp = new ObjectData4FIX();
				temp.setIsZip(DataTypeDefine.TRUE);
				temp.setIsEncrypt(DataTypeDefine.FALSE);
				temp.setObj(pingC.createPing());
				this.sendObject(temp, false);
			}
			try {
				Thread.sleep(5000);
			} catch (Exception e) {
			}
		}
	}

	void runPingCheck() {
		while (!isDestroy) {
			if (listener != null) {
				PingResult pr = pingC.removePing();
				listener.onPing(pr.getPing(), pr.getAvePing(), pr.getLostPerc());
			}
			try {
				Thread.sleep(10000);
			} catch (Exception e) {
			}
		}
	}

	// void runDispatchQuote() {
	// while (!isDestroy) {
	// QuoteData quoteVec[] = null;
	// synchronized (quoteMap) {
	// if (!quoteMap.isEmpty()) {
	// quoteVec = (QuoteData[]) quoteMap.values().toArray(new QuoteData[0]);
	// quoteMap.clear();
	// }
	// }
	// if (quoteVec != null) {
	// if (listener != null) {
	// listener.onQuoteRec(quoteVec);
	// }
	// } else {
	// synchronized (quoteMap) {
	// try {
	// quoteMap.wait(5000);
	// } catch (Exception e) {
	// }
	// }
	// }
	// }
	// }

	// void runSplitOp(OPSplitNode node) {
	// int errTimes = 2;
	// try {
	// OPFather op = null;
	// node.doWait(node.getTimeOutGap() / 2);
	// for (int i = 1; i <= node.getMaxSplit(); i++) {
	// byte[] buf = node.getSplit_Client(i);
	// if (buf == null) {
	// for (int j = 0; j < errTimes; j++) {
	// SplitReq ip = new SplitReq();
	// ip.setGuid(node.getGuid());
	// ip.setIndex(i);
	// SplitOPTradeWaitObject wait = new SplitOPTradeWaitObject(ip,
	// OPSplitNode.TIMEOUTSPLIT);
	// splitMap.put(wait.get_hashCode(), wait);
	// addDataToSend(ip);
	// SplitRsp oop = wait.waitTrade();
	// splitMap.remove(wait.get_hashCode());
	// try {
	// if (node.getListener() != null) {
	// node.getListener().splitResult(i, oop.isSucceed(), oop.getErrCode(),
	// oop.getErrMessage());
	// }
	// } catch (Exception e) {
	// }
	// if (!oop.isSucceed() && j == errTimes - 1) {
	// tradeTimeout(node.getGuid());
	// return;
	// }
	// if (oop.isSucceed()) {
	// try {
	// if (node.getListener() != null) {
	// node.getListener().splitEvent(node.getMaxSplit(), node.getCurSplit());
	// }
	// } catch (Exception e1) {
	// }
	// node.addSplit_Client(i, oop.getBuffer(), false);
	// break;
	// }
	// }
	// }
	// }
	// try {
	// MultiByteArray mba = new MultiByteArray();
	// for (int i = 1; i <= node.getMaxSplit(); i++) {
	// mba.add(node.getSplit_Client(i));
	// }
	// byte[] header = new byte[10];
	// mba.get(header);
	// MultiByteArrayInputStream mi = new MultiByteArrayInputStream(mba);
	// GZIPInputStream gi = new GZIPInputStream(mi);
	// ObjectInputStream oi = new ObjectInputStream(gi);
	// Object obj = oi.readObject();
	// oi.close();
	//
	// op = (OPFather) obj;
	// debugPrint("ID:" + op.get_ID() + " || size:" + mba.size());
	// tradeReturned(op);
	// try {
	// if (node.getListener() != null) {
	// node.getListener().opResult(op.isSucceed(), op.getErrCode(),
	// op.getErrMessage());
	// }
	// } catch (Exception e1) {
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// tradeTimeout(node.getGuid());
	// }
	// } finally {
	// splitNodeMap.remove(node.getGuid());
	// }
	// }

	private void debugPrint(String str) {
		if (debug) {
			System.out.println("[Dealer Proxy Debug]" + str);
		}
	}

	private void debugPrint(Exception e) {
		if (debug) {
			e.printStackTrace();
		}
	}
}

class Runnable4Client_read implements Runnable {
	private DealerProxy clientNode;

	public Runnable4Client_read(DealerProxy clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runRead();
	}
}

class Runnable4Client_send implements Runnable {
	private DealerProxy clientNode;

	public Runnable4Client_send(DealerProxy clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runSend();
	}
}

// class Runnable4Client_quoteDispatch implements Runnable {
// private DealerProxy clientNode;
//
// public Runnable4Client_quoteDispatch(DealerProxy clientNode) {
// this.clientNode = clientNode;
// }
//
// public void run() {
// clientNode.runDispatchQuote();
// }
// }

// class Runnable4Client_SplitOp implements Runnable {
//
// private DealerProxy clientNode;
// private OPSplitNode node;
//
// public Runnable4Client_SplitOp(DealerProxy clientNode, OPSplitNode node) {
// this.clientNode = clientNode;
// this.node = node;
// }
//
// public void run() {
// clientNode.runSplitOp(node);
// }
//
// }

class Runnable4Client_ping implements Runnable {
	private DealerProxy clientNode;

	public Runnable4Client_ping(DealerProxy clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runPing();
	}
}

class Runnable4Client_pingCheck implements Runnable {
	private DealerProxy clientNode;

	public Runnable4Client_pingCheck(DealerProxy clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runPingCheck();
	}
}