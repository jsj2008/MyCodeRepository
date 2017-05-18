package jedi.ex02.CSTS3.server.doc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.server.net.ClientNode;
import jedi.ex02.CSTS3.server.net.I_ClientNode;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.quote.common.QuoteSizeData;
import allone.Log.simpleLog.log.LogProxy;

public class CSTSDoc {
	private HashMap<String, UserNode> userMap = new HashMap<String, UserNode>();
	private ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
	private HashMap<String, Long> forbiddenMap = new HashMap<String, Long>();
	private HashMap<String, QuoteSizeData[]> quoteVolumnMap = new HashMap<String, QuoteSizeData[]>();

	private boolean isDestroy;
	private long lastRecTime = 0;
	private long lastQuoteTime = 0;
	private NetWeightOperator netWeightOperator = new NetWeightOperator();

	public boolean init() {
		isDestroy = false;
		new _RunPrintTime().start();
		netWeightOperator.init();
		return true;
	}

	public void destroy() {
		netWeightOperator.destroy();
		isDestroy = true;
	}

	public UserNode[] getUserList() {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			return userMap.values().toArray(new UserNode[0]);
		} finally {
			readLock.unlock();
		}
	}

	public UserNode getUserNode(String userName) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			return userMap.get(userName);
		} finally {
			readLock.unlock();
		}
	}

	public void addClient(I_ClientNode client) {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			UserNode userNode = userMap.get(client.getAeid());
			if (userNode == null) {
				userNode = new UserNode();
				if (userNode.addClient(client)) {
					userMap.put(userNode.getAeid(), userNode);
				} else {
					client.destroy();
				}
			} else {
				if (!userNode.addClient(client)) {
					client.destroy();
				}
			}
		} finally {
			writeLock.unlock();
		}
	}

	public void removeClient(I_ClientNode client) {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			UserNode userNode = userMap.get(client.getAeid());
			if (userNode == null) {
				return;
			}
			I_ClientNode removedClient = userNode.removeClient(client.get_hashID());
			if (removedClient != null) {
				removedClient.destroy();
			}
			if (userNode.getClientNumber() <= 0) {
				userMap.remove(userNode.getAeid());
			}
		} finally {
			writeLock.unlock();
		}
	}

	public boolean containsUser(String userName) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			return userMap.containsKey(userName);
		} finally {
			readLock.unlock();
		}
	}

	public void sendInfoToAll(C3_InfoFather infor) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			Iterator<UserNode> it = userMap.values().iterator();
			while (it.hasNext()) {
				UserNode userNode = (UserNode) it.next();
				userNode.sendData(infor);
			}
		} finally {
			readLock.unlock();
		}
	}

	public void sendInfor(String[] groups, C3_InfoFather infor) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			if (groups == null) {
				for (UserNode userNode : userMap.values()) {
					userNode.sendData(infor);
				}
			} else {
				for (UserNode userNode : userMap.values()) {
					for (String group : groups) {
						if (userNode.checkGroup(group)) {
							userNode.sendData(infor);
							break;
						}
					}
				}
			}
		} finally {
			readLock.unlock();
		}
	}

	public void sendInforToUserList(String[] userList, C3_InfoFather infor) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			for (int i = 0; i < userList.length; i++) {
				UserNode userNode = userMap.get(userList[i]);
				if (userNode != null) {
					userNode.sendData(infor);
				}
			}
		} finally {
			readLock.unlock();
		}
	}

	public void sendInfor(String aeid, C3_InfoFather infor) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			UserNode userNode = userMap.get(aeid);
			if (userNode != null) {
				userNode.sendData(infor);
			}
		} finally {
			readLock.unlock();
		}
	}

	public void sendQuote(Object obj) {
		lastQuoteTime = System.currentTimeMillis();
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			for (UserNode userNode : userMap.values()) {
				userNode.sendData(obj);
			}
		} finally {
			readLock.unlock();
		}
	}

	public QuoteSizeData[] getVolumn(String instrument) {
		return (QuoteSizeData[]) quoteVolumnMap.get(instrument);
	}

	public void sendVolumn(Object obj) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			QuoteSizeData[] qss = (QuoteSizeData[]) obj;
			for (int i = 0; i < qss.length; i++) {
				QuoteSizeData qsd = qss[i];
				QuoteSizeData[] qsdV = (QuoteSizeData[]) quoteVolumnMap.get(qsd.getInstrument());
				if (qsdV == null) {
					qsdV = new QuoteSizeData[2];
					quoteVolumnMap.put(qsd.getInstrument(), qsdV);
				}
				if (qsd.getPriceType() == MTP4CommDataInterface.PRICETYPE_BID) {
					qsdV[0] = qsd;
				} else if (qsd.getPriceType() == MTP4CommDataInterface.PRICETYPE_ASK) {
					qsdV[1] = qsd;
				}
			}
			for (UserNode userNode : userMap.values()) {
				userNode.sendData(obj);
			}
		} finally {
			readLock.unlock();
		}
	}

	public void sendSimpleNews(Object obj) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			for (UserNode userNode : userMap.values()) {
				userNode.sendData(obj);
			}
		} finally {
			readLock.unlock();
		}
	}

	public int getOnlineUserNum() {
		int num = 0;
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			for (UserNode userNode : userMap.values()) {
				if (userNode.isDebug()) {
					continue;
				}
				int clientNum = userNode.getListSize();
				if (clientNum > 0) {
					num += clientNum;
				}
			}
		} finally {
			readLock.unlock();
		}
		return num;
	}

	public void kickAll() {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			for (UserNode userNode : userMap.values()) {
				userNode.removeAll();
			}
			userMap.clear();
		} finally {
			writeLock.unlock();
		}
	}

	public void kickUser(String userName) {
		UserNode userNode = this.getUserNode(userName);
		if (userNode != null) {
			userNode.kickAll();
		}
	}

	public void setUserForbidden(String userName, long forbiddenTime) {
		if (forbiddenTime <= 1000) {
			forbiddenMap.remove(userName);
		} else {
			forbiddenMap.put(userName, System.currentTimeMillis() + forbiddenTime);
		}
	}

	// public void kickUserByUser(String userName,String userGuid,String ipAddress){
	// UserNode userNode = this.getUserNode(userName);
	// if (userNode != null) {
	// userNode.kickAll();
	// }
	// }

	public void kickUserByAnotherLogin(String userName, String hashID, String fromIPAddress) {
		UserNode userNode = this.getUserNode(userName);
		if (userNode != null) {
			ArrayList<I_ClientNode> list = new ArrayList<I_ClientNode>();
			for (int i = 0; i < userNode.getClientList().size(); i++) {
				I_ClientNode cn = userNode.getClientList().get(i);
				if (cn.get_hashID().equals(hashID)) {
					list.add(cn);
				}
			}
			for (int i = 0; i < list.size(); i++) {
				list.get(i).kickedOut(fromIPAddress);
			}
		}
		// DealerNode dealer = dealerMap.get(userName);
		// if (dealer != null) {
		// if (dealer.get_hashID().equals(hashID)) {
		// dealer.destroy();
		// }
		// }
		// BrokerNode broker = brokerMap.get(userName);
		// if (broker != null) {
		// if (broker.get_hashID().equals(hashID)) {
		// broker.destroy();
		// }
		// }
	}

	public boolean isUserForbidden(String userName) {
		if (!forbiddenMap.containsKey(userName)) {
			return false;
		}
		Long time = forbiddenMap.get(userName);
		if (System.currentTimeMillis() < time.longValue()) {
			return true;
		} else {
			forbiddenMap.remove(userName);
			return false;
		}
	}

	public int getNetWeight() {
		return netWeightOperator.getNetWeight();
	}

	class _RunPrintTime extends Thread {

		@Override
		public void run() {
			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm:ss");
			while (!isDestroy) {
				try {
					sleep(30 * 1000);
				} catch (Exception e) {
					e.printStackTrace();
				}
				LogProxy.OutPrintln("currentTime=" + sdf.format(new Date()) + "|| lastRecTime="
						+ sdf.format(new Date(lastRecTime)) + "|| lastQuoteTime=" + sdf.format(new Date(lastQuoteTime)));
			}
		}

	}
	
	
//	public static void main(String[] agrs){
//		ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
//		System.out.println("-------------------> ");
//		testLock(lock, 5);
//		System.out.println("-------------------> ");
//	}
//	
//	private static void testLock(ReentrantReadWriteLock lock, int nSize){
//		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
//		writeLock.lock();
//		try{
//			if(nSize > 0){
//				testLock(lock, --nSize);	
//			}
//			System.out.println("----> " + nSize);
//		}catch(Exception ex){
//			ex.printStackTrace();
//		}finally{
//			writeLock.unlock();
//		}
//	}
}
