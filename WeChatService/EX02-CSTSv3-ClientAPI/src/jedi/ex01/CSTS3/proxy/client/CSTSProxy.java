package jedi.ex01.CSTS3.proxy.client;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.math.BigInteger;
import java.net.Socket;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.interfaces.RSAPublicKey;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.LinkedList;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5001;
import jedi.ex01.CSTS3.comm.jsondata.CSTSPing;
import jedi.ex01.CSTS3.comm.jsondata.KickBySysNode;
import jedi.ex01.CSTS3.comm.jsondata.KickOutNode;
import jedi.ex01.CSTS3.comm.jsondata.QuoteList;
import jedi.ex01.CSTS3.comm.jsondata.QuoteSizeList;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.CSTS3.proxy.client.ping.PingCaptain;
import jedi.ex01.CSTS3.proxy.client.ping.PingDealerable;
import jedi.ex01.CSTS3.proxy.client.ping.PingResult;
import jedi.ex01.CSTS3.proxy.comm.CSTSTradeWaitObject;
import jedi.ex01.CSTS3.proxy.comm.IPOPErrCodeTable;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.CSTS3.proxy.debug.RunningTimeDebugTools;
import jedi.ex01.client.station.api.debug.APIDebugLog;
import jedi.ex02.CSTS3.comm.fix.BasicFIXData;
import jedi.ex02.CSTS3.comm.fix.FIXioUtil;
import jedi.ex02.CSTS3.comm.fix.data.JsonData4Fix;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;
import allone.json.AlloneJSONObject;

public class CSTSProxy implements PingDealerable {
	public static boolean debug = false;
	private final static byte[] precheckbuf = { 97, 65, 108, 111, 110, 25 };
	private final static int type_androind = 3;
	private Socket socket;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;

	private boolean isDestroy = false;
	private boolean logined = false;

	private DataListener listener;

	private final long lastSendTime = System.currentTimeMillis();
	private final HashMap tradeMap = new HashMap();
	private final HashMap newsMap = new HashMap();
	private final LinkedList<AbstractJsonData> sendList = new LinkedList<AbstractJsonData>();
	private final HashMap quoteMap = new HashMap();
	private AESSecretKey cryptSecretKey;

	private int connectType = type_androind;
	private PingCaptain pingCaptain = null;
	private final Object _streamLock = new Object();

	private static KeyPair keypair;

	public CSTSProxy() {
		pingCaptain = new PingCaptain(this);
	}

	public boolean init(Socket socket, DataListener ls) throws Exception {
		connectType = type_androind;
		try {
			this.socket = socket;
			long p1 = System.currentTimeMillis();
			initNet();
			long p2 = System.currentTimeMillis();
			System.out.println("Login used time登陆所花时间为[p2-p1]" + (p2 - p1) + "秒");
			APIDebugLog.getInstance().logout("Login used time[p2-p1]" + (p2 - p1), APIDebugLog.level_info);
			initCrypt();
			long p3 = System.currentTimeMillis();
			System.out.println("Login used time[p3-p2]" + (p3 - p2));
			APIDebugLog.getInstance().logout("Login used time[p3-p2]" + (p3 - p2), APIDebugLog.level_info);
			this.isDestroy = false;
			start();
			this.listener = ls;
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			debugPrint(e);
			clearNet();
			throw e;
		}
	}

	private void initNet() throws Exception {

		// long t3 = System.currentTimeMillis();
		// socket.setSoTimeout(20 * 1000);
		// socket.setSoLinger(true, 0);
		// socket.setTcpNoDelay(true);
		// socket.setKeepAlive(true);
		bis = new BufferedInputStream(socket.getInputStream());
		bos = new BufferedOutputStream(socket.getOutputStream());
		bos.write(precheckbuf);
		bos.flush();
		bos.write(connectType);
		bos.flush();
		// long t4 = System.currentTimeMillis();
		// System.out.println("CSTS init net " + (t2 - t1) + "," + (t3 - t2) +
		// ","
		// + (t4 - t3));
	}

	private void initCrypt() throws Exception {
		RunningTimeDebugTools print = RunningTimeDebugTools.newInstance("crypt");
		if (keypair == null) {
			KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
			keyPairGen.initialize(1024);
			keypair = keyPairGen.generateKeyPair();
		}
		print.stepTo("key pair");
		RSAPublicKey publicKey = (RSAPublicKey) keypair.getPublic();
		BigInteger modulus = publicKey.getModulus();
		BigInteger publicExponent = publicKey.getPublicExponent();
		String key = modulus.toString(16) + ";" + publicExponent.toString(16);
		byte[] buffer = key.getBytes("UTF-8");
		byte[] lengthBuff = formatInt(buffer.length + 8, 8);
		print.stepTo("public key");
		bos.write(lengthBuff);
		bos.write(buffer);
		bos.flush();
		print.stepTo("write");
		// byte lengthBuf[] = new byte[8];
		// read(bis, lengthBuf);
		byte lengthBuf[] = FIXioUtil.readBuffer(bis, 8);
		printBuffer(lengthBuf);
		int length = Integer.valueOf(new String(lengthBuf).trim());
		// byte buf[] = new byte[length - 8];
		// read(bis, buf);
		System.out.println("[Received length] " + length);
		APIDebugLog.getInstance().logout("[Received length] " + length, APIDebugLog.level_info);
		byte buf[] = FIXioUtil.readBuffer(bis, length - 8);
		printBuffer(buf);
		print.stepTo("aes buff");
		// Cipher cipher = Cipher.getInstance("RSA");
		// Cipher cipher = Cipher.getInstance("RSA/ECB/NoPadding");
		Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
		cipher.init(Cipher.DECRYPT_MODE, keypair.getPrivate());
		byte[] aesbuff = cipher.doFinal(buf);
		System.out.println("AES key:");
		printBuffer(aesbuff);
		SecretKeySpec aeskey = new SecretKeySpec(aesbuff, "AES");
		cryptSecretKey = new AESSecretKey(aeskey);
		print.stepTo("aes key");
		System.out.println(print.format());
		APIDebugLog.getInstance().logout(print.format(), APIDebugLog.level_info);
	}

	private static byte[] formatInt(int number, int length) {
		DecimalFormat format = new DecimalFormat();
		format.setMaximumIntegerDigits(length);
		format.setMinimumIntegerDigits(length);
		format.setGroupingUsed(false);
		return format.format(number).getBytes();
	}

	// private static void read(InputStream is, byte buf[]) throws IOException {
	// is.read(buf);
	// StringBuffer sb = new StringBuffer();
	// sb.append("--------------");
	// sb.append("\r\n");
	// sb.append("Read:");
	// sb.append(buf.length);
	// sb.append("\r\n");
	// sb.append(" [ ");
	// for (int i = 0; i < buf.length; i++) {
	// sb.append(buf[i]);
	// sb.append(",");
	// }
	// sb.append(" ] ");
	// sb.append("\r\n");
	// sb.append("--------------");
	// sb.append("\r\n");
	// sb.append(new String(buf));
	// System.out.println(sb);
	// }

	// public static byte[] readBuffer(InputStream is, int length) throws
	// Exception {
	// byte buf[] = new byte[length];
	// for (int i = 0; i < length; i++) {
	// int v = is.read();
	// if (v < 0) {
	// throw new EOFException();
	// }
	// buf[i] = (byte) v;
	// }
	// printBuffer(buf);
	// return buf;
	// }

	private static void printBuffer(byte buffer[]) {
		StringBuffer sb = new StringBuffer();
		sb.append("\r\n");
		sb.append("-------------------------------------");
		sb.append("\r\n");
		sb.append(buffer.length);
		sb.append("\r\n");
		for (int i = 0; i < buffer.length; i++) {
			sb.append(buffer[i]);
			sb.append(",");
		}
		sb.append("\r\n");
		sb.append(new String(buffer));
		sb.append("\r\n");
		sb.append("-------------------------------------");
		sb.append("\r\n");
		System.out.println(sb);
	}

	private void start() {
		Runnable4Client_read read = new Runnable4Client_read(this);
		Runnable4Client_send send = new Runnable4Client_send(this);
		Runnable4Client_quoteDispatch quoteDispatch = new Runnable4Client_quoteDispatch(this);
		new Thread(read).start();
		new Thread(send).start();
		new Thread(quoteDispatch).start();
		pingCaptain.init();
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

	public OPFather doTrade(IPFather ip) {
		// ���ж��ǲ��ǵ�½����
		// ����ǵ�½����,���Ѿ�login��,�򷵻ش���
		if (ip.getID().equals("TRADESERV5001")) {
			if (logined) {
				OPFather op = new OPFather(ip);
				op.setSucceed(false);
				op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
				op.setErrMessage("Has logined before!");
				return op;
			}
			// ����ǵ�½����,��û��login,���ش���
		} else if (!logined) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage("Not login yet!");
			return op;
		}
		// ���״���
		CSTSTradeWaitObject wait = new CSTSTradeWaitObject(ip);
		this.tradeMap.put(wait.get_hashCode(), wait);
		addDataToSend(ip);
		OPFather op = null;
		if (ip.getID().equals("TRADESERV5001")) {
			op = wait.waitTrade(60 * 1000);
		} else {
			op = wait.waitTrade();
		}
		tradeMap.remove(wait.get_hashCode());
		// ���׽����,����ǵ�½����,����login״̬
		if (ip.getID().equals("TRADESERV5001")) {
			if (op.isSucceed()) {
				OP_TRADESERV5001 op5001 = (OP_TRADESERV5001) op;
				this.logined = op5001.getResult() == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED;
			} else {
				this.logined = false;
			}
		}
		// ���ؽ��׽��
		return op;
	}

	private void onKickedOut(KickOutNode node) {
		isDestroy = true;
		if (listener != null) {
			listener.onKickedOut(node);
		}
		listener = null;
		clearNet();
		CSTSTradeWaitObject[] wl = (CSTSTradeWaitObject[]) this.tradeMap.values().toArray(new CSTSTradeWaitObject[0]);
		for (int i = 0; i < wl.length; i++) {
			wl[i].setErr();
		}
	}

	private void onKickedOutBySys() {
		isDestroy = true;
		if (listener != null) {
			listener.onKickedOutBySys();
		}
		listener = null;
		clearNet();
		CSTSTradeWaitObject[] wl = (CSTSTradeWaitObject[]) this.tradeMap.values().toArray(new CSTSTradeWaitObject[0]);
		for (int i = 0; i < wl.length; i++) {
			wl[i].setErr();
		}
	}

	public void suicide() {
		isDestroy = true;
		listener = null;
		pingCaptain.destroy();
		clearNet();
		CSTSTradeWaitObject[] wl = (CSTSTradeWaitObject[]) this.tradeMap.values().toArray(new CSTSTradeWaitObject[0]);
		for (int i = 0; i < wl.length; i++) {
			wl[i].setErr();
		}
	}

	public void destroy() {
		pingCaptain.destroy();
		CSTSTradeWaitObject[] wl = (CSTSTradeWaitObject[]) this.tradeMap.values().toArray(new CSTSTradeWaitObject[0]);
		for (int i = 0; i < wl.length; i++) {
			wl[i].setErr();
		}
		if (!isDestroy) {
			isDestroy = true;
			clearNet();
			if (listener != null) {
				DataListener templis = listener;
				listener = null;
				if (this.logined) {
					templis.onNetLost();
					System.out.println("************** Net lost notified by CSTS");
					APIDebugLog.getInstance().logout("************** Net lost notified by CSTS", APIDebugLog.level_error);
				} else {
					System.out.println("************** Net lost , Not logined, CSTS");
					APIDebugLog.getInstance().logout("************** Net lost , Not logined, CSTS", APIDebugLog.level_error);
				}
			}
		}
	}

	private void tradeReturned(OPFather op) {
		CSTSTradeWaitObject wait = (CSTSTradeWaitObject) tradeMap.get(op.getOperateId());
		if (wait != null) {
			wait.tradeReturn(op);
		} else {
			System.out.println("Unknow CSTS wait object." + op.getID() + ",HashCode=" + op.getOperateId());
			APIDebugLog.getInstance().logout("Unknow CSTS wait object." + op.getID() + ",HashCode=" + op.getOperateId(),
					APIDebugLog.level_error);
		}
	}

	public void addDataToSend(AbstractJsonData obj) {
		synchronized (this.sendList) {
			sendList.addFirst(obj);
			sendList.notifyAll();
		}
	}

	private void sendObject(BasicFIXData data) {
		synchronized (_streamLock) {
			try {
				// System.out.println(new String(data.format()));
				FIXioUtil.writeData(data.format(), bos);
			} catch (Exception e) {
				e.printStackTrace();
				destroy();
			}
		}
	}

	// private void sendObject(Object obj, boolean needToSealed) {
	// try {
	// ObjectOutputStream oos = new ObjectOutputStream(bos);
	// if (needToSealed) {
	// AESAlloneSealedObject sealedObject = new AESAlloneSealedObject(obj,
	// cryptSecretKey, true);
	// oos.writeObject(sealedObject);
	// // PackageLog.log_Package(sealedObject, "Send Sealed: " +
	// obj.getClass().getName());
	// } else {
	// oos.writeObject(obj);
	// // PackageLog.log_Package(obj, "Send Object: " +
	// obj.getClass().getName());
	// }
	// oos.flush();
	// lastSendTime = System.currentTimeMillis();
	// } catch (Exception e) {
	// if (!isDestroy) {
	// e.printStackTrace();
	// destroy();
	// } else if (obj instanceof IPFather) {
	// try {
	// IPFather tempip = (IPFather) obj;
	// CSTSTradeWaitObject wait = (CSTSTradeWaitObject)
	// tradeMap.get(tempip.getOperateId());
	// if (wait != null) {
	// wait.setErr();
	// }
	// System.out.println("************** Send IP failed");
	// } catch (Exception e1) {
	// }
	// }
	// }
	// }

	boolean toDebugRead = false;

	private BasicFIXData readObject() {
		try {
			return FIXioUtil.readData(bis, cryptSecretKey);
		} catch (Exception e) {
			e.printStackTrace();
			destroy();
			return null;
		}
	}

	// private Object readObject() {
	// try {
	// ObjectInputStream ois = new ObjectInputStream(bis);
	// Object readObj = ois.readObject();
	// if (readObj instanceof CSTSPing) {
	// CSTSPing ping = (CSTSPing) readObj;
	// pingCaptain.onPingReturn(ping);
	// // PackageLog.log_Package(readObj, "Read Object: " +
	// readObj.getClass().getName());
	// return null;
	// } else if (readObj instanceof AESAlloneSealedObject) {
	// AESAlloneSealedObject sealedObject = (AESAlloneSealedObject) readObj;
	// Object obj = sealedObject.decrypt(this.cryptSecretKey);
	// debugLogRead(sealedObject, obj);
	// // PackageLog.log_Package(readObj, "Read Sealed: "
	// // + (sealedObject.isNeedEncrypt() ? "(Encrypt)" : "") +
	// obj.getClass().getName());
	// return obj;
	// } else if (readObj instanceof C3_EchoData) {
	// // PackageLog.log_Package(readObj, "Read Object: " +
	// readObj.getClass().getName());
	// return null;
	// } else {
	// // PackageLog.log_Package(readObj, "Read Object: " +
	// readObj.getClass().getName());
	// debugPrint("Received unknow object:" + readObj);
	// return null;
	// }
	// } catch (Exception e) {
	// if (!isDestroy) {
	// debugPrint(e);
	// destroy();
	// }
	// return null;
	// }
	// }

	long debug_lastReadTime = System.currentTimeMillis();

	private void debugLogRead(BasicFIXData sealedObject, Object obj) {
		if (!toDebugRead) {
			return;
		}
		long tempTime = System.currentTimeMillis();
		StringBuffer sb = new StringBuffer();
		sb.append(tempTime - debug_lastReadTime);
		sb.append(" ,\t");
		sb.append(System.currentTimeMillis());
		sb.append(" : ");
		sb.append(sealedObject.getIsZip() == MTP4CommDataInterface.TRUE);
		sb.append(" \t");
		sb.append(obj.getClass().getSimpleName());
		sb.append(" \t");
		if (obj instanceof Object[]) {
			sb.append("(" + ((Object[]) obj).length + ")");
		}
		sb.append(" \t");
		sb.append(sealedObject.getDataBuffer().length);
		debug_lastReadTime = tempTime;
		System.out.println(sb);
	}

	private void dealWithQuotes(QuoteData[] quoteVec) {
		synchronized (quoteMap) {
			for (int i = 0; i < quoteVec.length; i++) {
				quoteMap.put(quoteVec[i].getInstrument(), quoteVec[i]);
			}
			quoteMap.notifyAll();
		}
	}

	private void dealWithInData(final AbstractJsonData indata) {
		try {
			if (indata != null) {
				if (indata instanceof CSTSPing) {
					CSTSPing ping = (CSTSPing) indata;
					pingCaptain.onPingReturn(ping);
					// PackageLog.log_Package(readObj, "Read Object: " +
					// readObj.getClass().getName());
				} else if (indata instanceof OPFather) {
					OPFather op = (OPFather) indata;
					debugPrint("Received new OPFather:" + op);
					tradeReturned(op);
				} else if (indata instanceof InfoFather) {
					new Thread() {
						@Override
						public void run() {
							if (listener != null) {
								listener.onInforRec((InfoFather) indata);
							}
						}
					}.start();
					debugPrint("Received new InfoFather:" + indata);
				} else if (indata instanceof KickOutNode) {
					onKickedOut((KickOutNode) indata);
					debugPrint("Kicked out by:" + ((KickOutNode) indata).getKickerIp());
				} else if (indata instanceof KickBySysNode) {
					onKickedOutBySys();
				} else {
					debugPrint("Unknow data!" + indata);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void runRead() {
		while (!isDestroy) {
			BasicFIXData obj = readObject();
			if (obj != null) {
				if (obj instanceof JsonData4Fix) {
					JsonData4Fix jsonData = (JsonData4Fix) obj;
					try {
						// jsonData.parse();
						debugPrint(jsonData.getJson());
						AbstractJsonData json = jsonData.getData();
						if (json instanceof QuoteList) {
							QuoteList data = (QuoteList) json;
							dealWithQuotes(data.getQuotes());
						} else if (json instanceof QuoteSizeList) {
							if (listener != null) {
								QuoteSizeList data = (QuoteSizeList) json;
								listener.onVolumnRec(data.getSizes());
							}
						} else {
							dealWithInData(json);
						}
					} catch (Exception e) {
						debugPrint(e);
					}
				}
			}
		}
	}

	void runSend() {
		while (!isDestroy) {
			AbstractJsonData toSendObj = null;
			synchronized (this.sendList) {
				if (!sendList.isEmpty()) {
					toSendObj = sendList.removeLast();
				}
			}
			if (toSendObj == null) {
				synchronized (sendList) {
					try {
						sendList.wait(5000);
					} catch (Exception e) {
					}
				}
			} else {
				AlloneJSONObject jsonObject = new AlloneJSONObject(toSendObj);
				String json = jsonObject.toString();
				debugPrint(json);

				JsonData4Fix data = new JsonData4Fix();
				data.setData(toSendObj);
				data.setIsEncrypt(MTP4CommDataInterface.TRUE);
				data.setIsZip(MTP4CommDataInterface.TRUE);
				data.setKey(cryptSecretKey);
				sendObject(data);
			}
		}
	}

	void runDispatchQuote() {
		while (!isDestroy) {
			QuoteData quoteVec[] = null;
			synchronized (quoteMap) {
				if (!quoteMap.isEmpty()) {
					quoteVec = (QuoteData[]) quoteMap.values().toArray(new QuoteData[0]);
					quoteMap.clear();
				}
			}
			if (quoteVec != null) {
				if (listener != null) {
					listener.onQuoteRec(quoteVec);
				}
			} else {
				synchronized (quoteMap) {
					try {
						quoteMap.wait(5000);
					} catch (Exception e) {
					}
				}
			}
		}
	}

	private void debugPrint(String str) {
		if (debug) {
			// System.out.println("[CSTS Proxy Debug]" + str);
		}
	}

	private void debugPrint(Exception e) {
		if (debug) {
			e.printStackTrace();
		}
	}

	protected AESSecretKey getCryptSecretKey() {
		return cryptSecretKey;
	}

	public boolean isToDebugRead() {
		return toDebugRead;
	}

	public void setToDebugRead(boolean toDebugRead) {
		this.toDebugRead = toDebugRead;
	}

	@Override
	public boolean sendPing(CSTSPing ping) {
		if (!isDestroy) {
			if (logined) {
				JsonData4Fix data = new JsonData4Fix();
				data.setData(ping);
				data.setIsEncrypt(MTP4CommDataInterface.FALSE);
				data.setIsZip(MTP4CommDataInterface.FALSE);
				data.setKey(cryptSecretKey);
				sendObject(data);
				return true;
			}
		}
		return false;
	}

	@Override
	public void onPingResult(PingResult pr) {
		if (this.listener != null) {
			listener.onPing(pr.getPing(), pr.getAvePing(), pr.getLostPerc());
			boolean isTimeout = pr.isNetTimeout();
			if (isTimeout) {
				listener.onPingTimeOut();
			}
		}
	}

	public boolean isDestroy() {
		return isDestroy;
	}

	public boolean isLogined() {
		return logined;
	}

	public static byte[] getPrecheckbuf() {
		return precheckbuf;
	}

}

class Runnable4Client_read implements Runnable {
	private final CSTSProxy clientNode;

	public Runnable4Client_read(CSTSProxy clientNode) {
		this.clientNode = clientNode;
	}

	@Override
	public void run() {
		clientNode.runRead();
	}
}

class Runnable4Client_send implements Runnable {
	private final CSTSProxy clientNode;

	public Runnable4Client_send(CSTSProxy clientNode) {
		this.clientNode = clientNode;
	}

	@Override
	public void run() {
		clientNode.runSend();
	}
}

class Runnable4Client_quoteDispatch implements Runnable {
	private final CSTSProxy clientNode;

	public Runnable4Client_quoteDispatch(CSTSProxy clientNode) {
		this.clientNode = clientNode;
	}

	@Override
	public void run() {
		clientNode.runDispatchQuote();
	}
}