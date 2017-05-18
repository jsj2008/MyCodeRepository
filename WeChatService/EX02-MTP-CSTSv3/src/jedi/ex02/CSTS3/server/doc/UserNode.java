package jedi.ex02.CSTS3.server.doc;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Set;

import allone.Log.simpleLog.log.LogProxy;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.net.ClientNode;
import jedi.ex02.CSTS3.server.net.I_ClientNode;
import jedi.ex02.CSTS3.server.net.NewSocketDealer;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.ctrl.csts.comm.IPOP.UserMsgNode;

public class UserNode {

	private String aeid;

	private LinkedList<I_ClientNode> clientList = new LinkedList<I_ClientNode>();

	private int maxConnect;

	private Set<String> IPs = new HashSet<String>();

	private long lastLoginTime;

	public int getClientNumber() {
		return clientList.size();
	}

	public UserMsgNode[] getUserMsgNode() {
		ArrayList<UserMsgNode> list = new ArrayList<UserMsgNode>();
		synchronized (clientList) {
			for (I_ClientNode client : clientList) {
				UserMsgNode userMsg = new UserMsgNode();
				userMsg.setUserName(client.getAeid());
				userMsg.setUserIp(client.getIpAddress());
				userMsg.setLoginTime(client.getFirstLoginTime());
				userMsg.setLastLoginTime(client.getLoginTime());
				userMsg.setCSTSName(StaticContext.getCSConfigCaptain().getCstsName());
				LogProxy.OutPrintln("cstslog..." + StaticContext.getCSConfigCaptain().getCstsName());
				int type = client.getType();
				switch (type) {
					case NewSocketDealer.type_androind:
						userMsg.setRoleType(MTP4CommDataInterface.ROLETYPE_USER_PHONE);
						break;
					case NewSocketDealer.type_flex:
						userMsg.setRoleType(MTP4CommDataInterface.ROLETYPE_USER_WEB);
						break;
					case NewSocketDealer.type_iphone:
						userMsg.setRoleType(MTP4CommDataInterface.ROLETYPE_USER_PHONE);
						break;
					case NewSocketDealer.type_java:
						userMsg.setRoleType(MTP4CommDataInterface.ROLETYPE_USER);
						break;
					default:
						userMsg.setRoleType(MTP4CommDataInterface.ROLETYPE_USER);
						break;
				}
				userMsg.setUserGUID(client.get_hashID());
				userMsg.setGroupNameVec(client.getGroupSet().toArray(new String[0]));
				userMsg.setMaxOnlineNum(maxConnect);
				list.add(userMsg);
			}
		}
		return list.toArray(new UserMsgNode[0]);
	}

	public long getLastLoginTime() {
		return lastLoginTime;
	}

	public int getMaxConnect() {
		return maxConnect;
	}

	public LinkedList<I_ClientNode> getClientList() {
		return clientList;
	}

	public int getListSize() {
		return clientList.size();
	}

	public boolean checkGroup(String group) {
		synchronized (clientList) {
			if (clientList.size() > 0) {
				return ((ClientNode) clientList.getLast()).checkGroup(group);
			}
		}
		return false;
	}

	private boolean checkIP(String ip) {
		return IPs.size() == 0 || IPs.contains(ip);
	}

	public boolean isDebug() {
		return aeid.equals("MTP4_Debug_User");
	}

	public String getAeid() {
		return aeid;
	}

	public boolean addClient(I_ClientNode client) {
		if (aeid == null) {
			this.aeid = client.getAeid();
		}
		this.IPs.clear();
		if (client.getFixedIPAddress() != null) {
			for (int i = 0; i < client.getFixedIPAddress().length; i++) {
				IPs.add(client.getFixedIPAddress()[i]);
			}
		}
		this.maxConnect = Math.max(1, client.getMaxOnlineNum());
		if (!this.checkIP(client.getIpAddress())) {
			return false;
		}
		I_ClientNode tokickclient = null;
		synchronized (clientList) {
			if (clientList.size() >= maxConnect) {
				tokickclient = clientList.removeFirst();
			}
			clientList.addLast(client);
			this.lastLoginTime = client.getLoginTime();
		}
		if (tokickclient != null) {
			tokickclient.kickedOut(client.getIpAddress());
		}
		return true;
	}

	public void sendData(Object obj) {
		synchronized (clientList) {
			for (I_ClientNode client : clientList) {
				client.addObjectToSend(obj);
			}
		}
	}

	public I_ClientNode removeClient(String clientId) {
		synchronized (clientList) {
			for (int i = 0; i < clientList.size(); i++) {
				I_ClientNode client = clientList.get(i);
				if (client.get_hashID().equals(clientId)) {
					clientList.remove(client);
					client.destroy();
					return client;
				}
			}
		}
		return null;
	}

	public void removeAll() {
		ClientNode[] clients = clientList.toArray(new ClientNode[0]);
		for (int i = 0; i < clients.length; i++) {
			clients[i].destroy();
		}
		clientList.clear();
	}

	public void kickAll() {
		ClientNode[] clients = clientList.toArray(new ClientNode[0]);
		for (int i = 0; i < clients.length; i++) {
			clients[i].kickedOutBySystem();
		}
		clientList.clear();
	}
}
