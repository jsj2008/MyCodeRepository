package server.network.client;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import server.start.ServerContext;

import comm.struct.ClientLoginInfo;

public class NetCaptain {
	private AcceptWorker acceptWorker = new AcceptWorker();

	private HashMap<String, ClientNode> clientMap = new HashMap<String, ClientNode>();
	private ReentrantReadWriteLock lock = new ReentrantReadWriteLock();

	public ClientLoginInfo[] getDealerLoginInfo() {
		String serverName = ServerContext.getConfigCaptain().getServerName();
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		ArrayList<ClientLoginInfo> list = new ArrayList<ClientLoginInfo>();
		try {
			for (ClientNode node : clientMap.values()) {
				ClientLoginInfo data = new ClientLoginInfo();
				data.setUserName(node.getUserName());
				data.setIpAddress(node.getIpAddress());
				data.setLoginTime(node.getLoginTime());
				data.setServerName(serverName);
				data.setGuid(node.getGuid());
				list.add(data);
			}
		} finally {
			writeLock.unlock();
		}
		return list.toArray(new ClientLoginInfo[0]);
	}

	public void addDealer(ClientNode clientNode) {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			ClientNode tempClientNode = clientMap.get(clientNode.getUserName());
			if (tempClientNode != null && !tempClientNode.getUserName().equals(clientNode.getUserName())) {
				System.out.println("is allready exist!");
			}
			clientMap.put(clientNode.getUserName(), clientNode);
		} finally {
			writeLock.unlock();
		}
	}

	public void removeDealer(ClientNode clientNode) {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			ClientNode tempClientNode = clientMap.get(clientNode.getUserName());
			if (tempClientNode == null) {
				return;
			}
			if (clientNode.getUserName().equals(tempClientNode.getGuid())) {
				clientNode.destroy(false);
				clientMap.remove(clientNode.getUserName());
			}
		} finally {
			writeLock.unlock();
		}
	}

	public boolean containsDealer(String userName) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			return clientMap.containsKey(userName);
		} finally {
			readLock.unlock();
		}
	}

	public void kickAll() {
		ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
		writeLock.lock();
		try {
			Collection<ClientNode> dealersCollection = clientMap.values();
			clientMap.clear();
			for (ClientNode dealerNode : dealersCollection) {
				dealerNode.destroy(false);
			}
		} finally {
			writeLock.unlock();
		}
	}

	public String getIpByDealer(String userName) {
		ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
		readLock.lock();
		try {
			ClientNode dealer = clientMap.get(userName);
			if (dealer != null) {
				return dealer.getIpAddress();
			} else {
				return null;
			}
		} finally {
			readLock.unlock();
		}
	}

	public boolean init() {
		return acceptWorker.init(ServerContext.getConfigCaptain().getClientSocketPort());
	}

	public void destroy() {
		kickAll();
		acceptWorker.destroy();
	}
}
