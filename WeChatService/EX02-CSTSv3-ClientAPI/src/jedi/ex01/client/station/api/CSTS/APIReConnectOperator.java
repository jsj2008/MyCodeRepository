package jedi.ex01.client.station.api.CSTS;

import java.util.ArrayList;
import java.util.LinkedList;

import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEventListener;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;
import allone.util.socket.address.AddressNode;

public class APIReConnectOperator implements API_IDEventListener {

	public static final int STATUS_NET_LOST = -1;
	public static final int STATUS_CONNECTING = 0;
	public static final int STATUS_CONNECTED = 1;

	private int connectStatus = -1;

	private LinkedList<APIReConnectInfoNode> allList = new LinkedList<APIReConnectInfoNode>();
	private ArrayList<APIReConnectInfoNode> lastList = new ArrayList<APIReConnectInfoNode>();

	public synchronized void onStationEvent(API_IDEvent event) {
		try {
			if (connectStatus == STATUS_CONNECTING) {
				return;
			}
			if (!event.getEventName().equals(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT)) {
				return;
			}

			connectStatus = STATUS_CONNECTING;
			try {
				long beginTime = System.currentTimeMillis();
				int result = ClientAPI.getInstance().loginToBestAddress();
				long endTime = System.currentTimeMillis();
				APIReConnectInfoNode node = new APIReConnectInfoNode();
				AddressNode current = ClientAPI.getInstance().getCurrentAddress();
				node.setTime(endTime);
				node.setIpAddress(current.getIp());
				node.setPort(current.getPort());
				node.setLoginUsedTime(endTime - beginTime);
				node.setResult(result);
				node.setSucceed(result == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED);
				allList.addLast(node);
				lastList.add(node);

				if (result == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
					connectStatus = STATUS_CONNECTED;
					NetInfoNode info = new NetInfoNode();
					info.setIpAddress(ClientAPI.getInstance().getCurrentAddress().getIp());
					info.setPort(ClientAPI.getInstance().getCurrentAddress().getPort());
					info.setTime(System.currentTimeMillis());
					info.setType(NetInfoNode.TYPE_CONNECT);
					info.setReconnectVec(lastList.toArray(new APIReConnectInfoNode[0]));
					lastList.clear();
//					API_IDEvent resultEvent = new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_CONNECTED);
//					resultEvent.setEventData(info);
					API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_CONNECTED, info);
//					API_IDEventCaptain.getInstance().fireEventChanged(resultEvent);
				} else if (result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_USER_NOT_FOUND
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_IP_ERR
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_USER_LOCKED
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_PASSWORD_ERR
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_PASSWORD_EXPIRED) {
//					API_IDEvent resultEvent = new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_LOGIN_RESULT);
//					resultEvent.setEventData(result);
//					API_IDEventCaptain.getInstance().fireEventChanged(resultEvent);
					API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_LOGIN_RESULT, result);
				} else if (result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_NETERR
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_CADTSERR
						|| result == MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_UNKNOW) {
					try {
						Thread.sleep(500);
					} catch (Exception e1) {
					}
					API_IDEventCaptain.getInstance().fireEventChanged(
							new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT));
				}
			} catch (Exception e) {
				connectStatus = STATUS_NET_LOST;
				e.printStackTrace();
				try {
					Thread.sleep(500);
				} catch (Exception e1) {
				}
				API_IDEventCaptain.getInstance().fireEventChanged(
						new API_IDEvent(API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT));
			}
		} finally {
			if (connectStatus == STATUS_CONNECTING) {
				connectStatus = STATUS_NET_LOST;
			}
		}

	}

	public int getConnectStatus() {
		return connectStatus;
	}

	public boolean init() {
		API_IDEventCaptain.getInstance().addListener(this, API_IDEvent_NameInterface.NAME_ON_DO_RECONNECT);
		return true;
	}

	@SuppressWarnings("unchecked")
	public LinkedList<APIReConnectInfoNode> getAllList() {
		return (LinkedList<APIReConnectInfoNode>) allList.clone();
	}

}
