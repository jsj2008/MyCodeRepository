package jedi.ex02.CSTS3.server.net.web;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.LinkedList;

import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
import jedi.ex02.CSTS3.comm.struct.C3_QuoteSizeData;
import jedi.ex02.CSTS3.comm.fix.BasicFIXData;
import jedi.ex02.CSTS3.comm.fix.FIXioUtil;
import jedi.ex02.CSTS3.comm.fix.data.EchoData4Fix;
import jedi.ex02.CSTS3.comm.fix.data.JsonData4Fix;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteList;
import jedi.ex02.CSTS3.comm.jsondata.C3_QuoteSizeList;
import jedi.ex02.CSTS3.server.net.I_ClientNode;
import jedi.ex02.CSTS3.server.net.I_NetJob;
import jedi.ex02.CSTS3.server.net.web.INetWebSocket;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import allone.Log.simpleLog.log.LogProxy;
import allone.crypto.AES.AESSecretKey;
import allone.json.AbstractJsonData;

public class WsNetJob implements I_NetJob {

	private boolean isDestroy = false;
	private String ipAddress;
	private int port;

	private I_ClientNode clientNode;
	private INetWebSocket netWebSocket;

	private LinkedList<JsonData4Fix> sendList = new LinkedList<JsonData4Fix>();
	private HashMap<String, C3_QuoteData> needToSendQuoteMap = new HashMap<String, C3_QuoteData>();
	private HashMap<String, C3_QuoteSizeData> needToSendVolumnMap = new HashMap<String, C3_QuoteSizeData>();
	private Object _streamLock = new Object();
	
	class deferredSender extends Thread {
		public void run() {
			WsNetJob.this.runSend();
		}
	}

	public WsNetJob(INetWebSocket ws) {
		this.netWebSocket = ws;
		this.ipAddress = ws.getRemoteIp();
		this.port = ws.getRemotePort();
		new deferredSender().start();
	}

	@Override
	public void init(I_ClientNode clientNode) {
		this.clientNode = clientNode;
	}

	@Override
	public String getIpAddress() {
		return ipAddress;
	}

	@Override
	public int getPort() {
		return port;
	}

	@Override
	public void sendJsonData(AbstractJsonData data, boolean needToBeSealed,
			boolean needEncrypt, boolean Immediately) {
		if (isDestroy) {
			LogProxy.OutPrintln("Destroy=true");
			StackTraceElement[] eles = Thread.currentThread().getStackTrace();
			for (StackTraceElement stackTraceElement : eles) {
				System.out.println(stackTraceElement);
			}
			clientNode.onDestroy();
			return;
		}

		JsonData4Fix fixData = new JsonData4Fix();
		fixData.setData(data);
		if (needEncrypt) {
			//
			// felix, do not set encrypt to fix data. we used ssl for websocket.
			//
			fixData.setIsEncrypt(MTP4CommDataInterface.FALSE);
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

	@Override
	public void sendQuote(C3_QuoteData quote) {
		synchronized (this.sendList) {
			needToSendQuoteMap.put(quote.getInstrument(), quote);
			sendList.notifyAll();
		}
	}

	@Override
	public void sendVolumn(C3_QuoteSizeData quote) {
		synchronized (this.sendList) {
			needToSendVolumnMap.put(quote.getInstrument() + "[ TYPE FOR ]" + quote.getPriceType(), quote);
			sendList.notifyAll();
		}		
	}

	@Override
	public AESSecretKey getCryptSecretKey() {
		//throw new Exception("There no secret key for web socket connection.");
		return null;
	}

	@Override
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
		if (this.netWebSocket != null) {
			this.netWebSocket.closeNetSocket();
		}
	}

	public void onReadBinary(ByteBuffer byteBuffer) {
		if (this.isDestroy) {
			return;
		}
		try {
			BasicFIXData obj = FIXioUtil.readWsData(byteBuffer);
			if (obj != null) {
				dealWithInData(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			destroy();
		}
	}

	public void onReadJsonText(String jsonString) {
		if (this.isDestroy) {
			return;
		}
		try {
			BasicFIXData obj = FIXioUtil.readWsData(jsonString);
			if (obj != null) {
				dealWithInData(obj);
			}
		} catch (Exception e) {
			e.printStackTrace();
			destroy();
		}
	}

	private void sendObject(BasicFIXData data) {
		synchronized (_streamLock) {
			try {
				if (this.netWebSocket != null) {
					if (data instanceof JsonData4Fix) {
						this.netWebSocket.sendTextMessage(((JsonData4Fix) data).formatJson());
					} else {
						ByteBuffer byteBuffer = FIXioUtil.writeWsData(data.format());
						this.netWebSocket.sendBinaryMessage(byteBuffer);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				destroy();
			}
		}
	}

	private void runSend() {
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
					C3_QuoteSizeData[] quotes = needToSendQuoteMap.values().toArray(new C3_QuoteSizeData[0]);
					C3_QuoteSizeList list = new C3_QuoteSizeList();
					list.setSizes(quotes);
					JsonData4Fix json = new JsonData4Fix();
					json.setData(list);
					json.setIsEncrypt(MTP4CommDataInterface.FALSE);
					json.setIsZip(MTP4CommDataInterface.TRUE);
					toSendQuote = json;
					needToSendQuoteMap.clear();
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
