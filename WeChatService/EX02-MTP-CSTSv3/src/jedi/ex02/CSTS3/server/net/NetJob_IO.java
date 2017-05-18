package jedi.ex02.CSTS3.server.net;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.net.Socket;
import java.util.HashMap;
import java.util.LinkedList;

import jedi.ex02.CSTS3.comm.fix.BasicFIXData;
import jedi.ex02.CSTS3.comm.fix.FIXioUtil;
import jedi.ex02.CSTS3.comm.fix.data.EchoData4Fix;
import jedi.ex02.CSTS3.comm.fix.data.JsonData4Fix;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteList;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteSizeList;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteSizeData;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import allone.Log.simpleLog.log.LogProxy;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;

public class NetJob_IO implements I_NetJob {

	private Socket socket;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;
	private AESSecretKey cryptSecretKey;
	private String ipAddress;
	private int port;
	private boolean isDestroy = false;

	private I_ClientNode clientNode;

	private LinkedList<JsonData4Fix> sendList = new LinkedList<JsonData4Fix>();
	private HashMap<String, C3_QuoteData> needToSendQuoteMap = new HashMap<String, C3_QuoteData>();
	private HashMap<String, C3_QuoteSizeData> needToSendVolumnMap = new HashMap<String, C3_QuoteSizeData>();
	private Object _streamLock = new Object();

	public NetJob_IO(AESSecretKey cryptSecretKey, Socket socket, BufferedInputStream bis, BufferedOutputStream bos) {
		this.cryptSecretKey = cryptSecretKey;
		this.socket = socket;
		this.bis = bis;
		this.bos = bos;
		this.ipAddress = socket.getInetAddress().getHostAddress();
		this.port = socket.getPort();

	}

	public void init(I_ClientNode clientNode) {
		this.clientNode = clientNode;

		Runnable4Client_read read = new Runnable4Client_read(this);
		Runnable4Client_send send = new Runnable4Client_send(this);
		new Thread(read).start();
		new Thread(send).start();
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public int getPort() {
		return port;
	}

	public void sendJsonData(AbstractJsonData data, boolean needToBeSealed, boolean needEncrypt, boolean Immediately) {
		if (isDestroy) {
			LogProxy.OutPrintln("Destroy=true | " + ipAddress);
//			StackTraceElement[] eles = Thread.currentThread().getStackTrace();
//			for (StackTraceElement stackTraceElement : eles) {
//				System.out.println(stackTraceElement);
//			}
			clientNode.onDestroy();
			return;
		}

		JsonData4Fix fixData = new JsonData4Fix();
		fixData.setData(data);
		if (needEncrypt) {
			fixData.setIsEncrypt(MTP4CommDataInterface.TRUE);
			fixData.setKey(cryptSecretKey);
		}
		if (needToBeSealed) {
			fixData.setIsZip(MTP4CommDataInterface.TRUE);
		}
		if (Immediately) {
			sendObject(fixData);
			return;
		} else {
			synchronized (this.sendList) {
				sendList.addFirst(fixData);
				sendList.notifyAll();
			}
		}

	}

	public void sendQuote(C3_QuoteData quote) {
		synchronized (this.sendList) {
			needToSendQuoteMap.put(quote.getInstrument(), quote);
			sendList.notifyAll();
		}
	}

	public void sendVolumn(C3_QuoteSizeData quote) {
		synchronized (this.sendList) {
			needToSendVolumnMap.put(quote.getInstrument() + "[ TYPE FOR ]" + quote.getPriceType(), quote);
			sendList.notifyAll();
		}
	}

	public AESSecretKey getCryptSecretKey() {
		return cryptSecretKey;
	}

	public void destroy() {
		if (!isDestroy) {
			isDestroy = true;
			clearNet();
			clientNode.onDestroy();
			synchronized (sendList) {
				sendList.clear();
				sendList.notifyAll();
			}
		}
	}

	public void clearNet() {
		if (socket != null) {
			try {
				socket.shutdownInput();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				socket.shutdownOutput();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (bis != null) {
			try {
				bis.close();
			} catch (Exception e) {
			}
			bis = null;
		}
		if (bos != null) {
			try {
				bos.close();
			} catch (Exception e) {
			}
			bos = null;
		}
		if (socket != null) {
			try {
				socket.close();
			} catch (Exception e) {
			}
			socket = null;
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

	private BasicFIXData readObject() {
		try {
			return FIXioUtil.readData(bis, cryptSecretKey);
		} catch (Exception e) {
			e.printStackTrace();
			destroy();
			return null;
		}
	}

	void runRead() {
		while (!isDestroy) {
			try {
				BasicFIXData obj = readObject();
				// System.out.println(obj);
				if (obj != null) {
					dealWithInData(obj);
				}
			} catch (Exception e) {
				LogProxy.printException(e);
				destroy();
			}
		}
	}

	void runSend() {
		while (!isDestroy) {
			BasicFIXData toSendObj = null;
			BasicFIXData toSendQuote = null;
			BasicFIXData toSendQuoteSize = null;

			synchronized (this.sendList) {
				if (!sendList.isEmpty()) {
					toSendObj = sendList.removeLast();
				}
				if (!needToSendQuoteMap.isEmpty()) {
					C3_QuoteData[] quotes = needToSendQuoteMap.values().toArray(new C3_QuoteData[0]);
					C3_QuoteList list = new C3_QuoteList();
					list.setQuotes(quotes);
					JsonData4Fix json = new JsonData4Fix();
					json.setData(list);
					json.setIsEncrypt(MTP4CommDataInterface.FALSE);
					json.setIsZip(MTP4CommDataInterface.TRUE);
					toSendQuote = json;
					needToSendQuoteMap.clear();
				}
				if (!needToSendVolumnMap.isEmpty()) {
					C3_QuoteSizeData[] quotes = needToSendVolumnMap.values().toArray(new C3_QuoteSizeData[0]);
					C3_QuoteSizeList list = new C3_QuoteSizeList();
					list.setSizes(quotes);
					JsonData4Fix json = new JsonData4Fix();
					json.setData(list);
					json.setIsEncrypt(MTP4CommDataInterface.FALSE);
					json.setIsZip(MTP4CommDataInterface.TRUE);
					toSendQuoteSize = json;
					needToSendVolumnMap.clear();
				}
			}

			if (toSendObj == null && toSendQuote == null && toSendQuoteSize == null) {

				synchronized (sendList) {
					try {
						sendList.wait(5000);
					} catch (Exception e) {
					}
				}
			} else {
				if (toSendObj != null) {
					sendObject(toSendObj);
				}
				if (toSendQuote != null) {
					sendObject(toSendQuote);
				}
				if (toSendQuoteSize != null) {
					sendObject(toSendQuoteSize);
				}
			}

		}
	}

	private void dealWithInData(BasicFIXData indata) {
		if (indata instanceof EchoData4Fix) {
			sendObject(indata);
		} else if (indata instanceof JsonData4Fix) {
			JsonData4Fix data = (JsonData4Fix) indata;
			clientNode.dealWithInData(data.getData());
		}
	}

}

class Runnable4Client_read implements Runnable {
	private NetJob_IO job;

	public Runnable4Client_read(NetJob_IO job) {
		this.job = job;
	}

	public void run() {
		job.runRead();
	}
}

class Runnable4Client_send implements Runnable {
	private NetJob_IO job;

	public Runnable4Client_send(NetJob_IO job) {
		this.job = job;
	}

	public void run() {
		job.runSend();
	}
}
