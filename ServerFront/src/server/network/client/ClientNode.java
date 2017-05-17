package server.network.client;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.net.Socket;
import java.util.LinkedList;

import server.define.DataTypeDefine;
import server.start.ServerContext;
import allone.crypto.AES.AESSecretKey;

import comm.DealerPing;
import comm.fix.BasicFIXData;
import comm.fix.FixIoUtil;
import comm.fix.data.ObjectData4FIX;
import comm.message.IPFather;
import comm.message.IP_Client1001;
import comm.message.OPFather;
import comm.message.OP_Client1001;

public class ClientNode {

	private String _hashID = System.currentTimeMillis() + "_" + this.hashCode() + "_" + Math.random();

	private String guid = null;
	private AESSecretKey cryptSecretKey;
	private Socket socket;
	private BufferedInputStream bis;
	private BufferedOutputStream bos;
	private boolean logined = false;
	private String userName;
	private String ipAddress;
	private long loginTime;
	private boolean isDestroy = false;
	// private long lastSendTime = System.currentTimeMillis();
	private LinkedList<Object> sendList = new LinkedList<Object>();
	private Object _streamLock = new Object();

	public ClientNode(AESSecretKey cryptKey, Socket socket, BufferedInputStream bis, BufferedOutputStream bos, String guid) {
		this.cryptSecretKey = cryptKey;
		this.socket = socket;
		this.bis = bis;
		this.bos = bos;
		this.ipAddress = socket.getInetAddress().getHostAddress();
		this.guid = guid;
		start();
	}

	public void addObjectToSend(Object obj) {
		if (isDestroy) {
			// LogProxy.OutPrintln("Destroy=true");
			return;
		}
		synchronized (this.sendList) {
			sendList.addFirst(obj);
			sendList.notifyAll();
		}
	}

	private boolean onLogin(IP_Client1001 ip, OPFather _op) {
		if (logined) {
			return false;
		}
		try {
			if (_op.isSucceed()) {
				OP_Client1001 op = (OP_Client1001) _op;
				if (op.getResult() == DataTypeDefine.Login_Result_Success) {
					loginTime = System.currentTimeMillis();
					this.userName = ip.getUser().getUserName();
					logined = true;
				} else {
					logined = false;
				}
			}
			ObjectData4FIX data = new ObjectData4FIX();
			data.setIsZip(DataTypeDefine.TRUE);
			data.setIsEncrypt(DataTypeDefine.FALSE);
			data.setObj(_op);
			this.sendObject(data, false);
		} catch (Exception e) {
			e.printStackTrace();
			logined = false;
		}
		return logined;
	}

	public void destroy(boolean flag) {
		if (!isDestroy) {
			isDestroy = true;
			this.clearNet();
			synchronized (sendList) {
				sendList.clear();
				sendList.notifyAll();
			}
			if (flag) {
				ServerContext.getNetCaptain().removeDealer(this);
			}
		}
	}

	public void clearNet() {
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

	private void start() {
		Runnable4Client_read read = new Runnable4Client_read(this);
		Runnable4Client_send send = new Runnable4Client_send(this);
		new Thread(read).start();
		new Thread(send).start();
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
				e.printStackTrace();
				System.out.println("destroy by sendObject:" + userName);
				destroy(true);
			}
		}
	}

	private BasicFIXData readObject() {
		try {
			return FixIoUtil.readData(bis, cryptSecretKey);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("destroy by readObject:" + userName);
			destroy(true);
			return null;
		}
	}

	private void dealWithInData(Object indata) {
		if (indata instanceof DealerPing) {
			PingThreadPool.getInstance().execute(new Runnable4Dealer_ping(this, (DealerPing) indata));
		} else if (indata instanceof IPFather) {
			IPFather ip = (IPFather) indata;
			new Thread(new Runnable4Client_trade(this, ip)).start();
		} else {
			if (!this.isLogined()) {
				System.out.println("destroy by dealWithInData:" + userName);
				this.destroy(true);
			}
		}
	}

	public void runPing(DealerPing ping) {
		ping.pingReturned();
		this.addObjectToSend(ping);
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
				dealWithInData(obj);
			}
		}
	}

	void runSend() {
		while (!isDestroy) {
			ObjectData4FIX obj4Fix = null;
			synchronized (this.sendList) {
				if (!sendList.isEmpty()) {
					obj4Fix = new ObjectData4FIX();
					Object obj = sendList.removeLast();

					obj4Fix.setIsZip(DataTypeDefine.TRUE);
					obj4Fix.setIsEncrypt(DataTypeDefine.FALSE);
					obj4Fix.setObj(obj);
				}
			}
			if (obj4Fix == null) {
				synchronized (sendList) {
					try {
						sendList.wait(5000);
					} catch (Exception e) {
					}
				}
			} else {
				if (obj4Fix != null) {
					sendObject(obj4Fix, false);
				}
			}
		}
	}

	void runDealWithTrade(IPFather _ip) {
		if (!this.isLogined()) {
			boolean loginSucceed = false;
			if (_ip.get_ID().equalsIgnoreCase("Client1001")) {
				IP_Client1001 ip = (IP_Client1001) _ip;
				OPFather op = ServerContext.getTradeCaptain().doTrade(ip);
				loginSucceed = onLogin(ip, op);
			}

			if (loginSucceed) {
				ServerContext.getNetCaptain().addDealer(this);
			} else {
				System.out.println("destroy by runDealWithTrade:" + userName);
				this.destroy(true);
			}
		} else {
			OPFather op = null;
			if (_ip instanceof IPFather) {
				IPFather ip = (IPFather) _ip;
				ip.set_fromServer("client");
				op = ServerContext.getTradeCaptain().doTrade(ip);
			} else {
				System.out.println("unknown message");
			}
			this.addObjectToSend(op);

		}
	}

	public boolean isLogined() {
		return logined;
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

	public String getUserName() {
		return userName;
	}

	public String getGuid() {
		return guid;
	}

}

class Runnable4Client_read implements Runnable {
	private ClientNode clientNode;

	public Runnable4Client_read(ClientNode clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runRead();
	}
}

class Runnable4Client_send implements Runnable {
	private ClientNode clientNode;

	public Runnable4Client_send(ClientNode clientNode) {
		this.clientNode = clientNode;
	}

	public void run() {
		clientNode.runSend();
	}
}

class Runnable4Client_trade implements Runnable {
	private ClientNode clientNode;
	private IPFather ip;

	public Runnable4Client_trade(ClientNode clientNode, IPFather ip) {
		this.clientNode = clientNode;
		this.ip = ip;
	}

	public void run() {
		clientNode.runDealWithTrade(ip);
	}
}

class Runnable4Dealer_ping implements Runnable {

	private ClientNode dealerNode;
	private DealerPing ping;

	public Runnable4Dealer_ping(ClientNode dealerNode, DealerPing ping) {
		super();
		this.dealerNode = dealerNode;
		this.ping = ping;
	}

	public void run() {
		dealerNode.runPing(ping);
	}
}
