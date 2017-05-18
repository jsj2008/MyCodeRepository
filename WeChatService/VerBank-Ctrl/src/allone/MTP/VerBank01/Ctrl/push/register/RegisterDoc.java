package allone.MTP.VerBank01.Ctrl.push.register;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

import allone.Log.simpleLog.log.LogProxy;

public class RegisterDoc {
	private static RegisterDoc instance = new RegisterDoc();

	// <groupName -- accountArray>
	private HashMap<String, List<String>> groupMap = new HashMap<String, List<String>>();

	// <aeid -- accountIDArray>
	private HashMap<String, List<String>> accountMap = new HashMap<String, List<String>>();

	// <accountID -- deviceToken>
	private HashMap<String, String> iPhoneDeviceTokenMap = new HashMap<String, String>();
	private HashMap<String, String> aPhoneDeviceTokenMap = new HashMap<String, String>();
	private HashMap<String, String> iPadDeviceTokenMap = new HashMap<String, String>();
	private HashMap<String, String> aPadDeviceTokenMap = new HashMap<String, String>();

	public static RegisterDoc getInstance() {
		return instance;
	}

	// 可能需要从数据库载入 DeviceID
	public void loadDeviceMap() {
		// 载入
	}

	private void removeDeviceToken(String accountID) {
		if (iPhoneDeviceTokenMap.containsKey(accountID)) {
			iPhoneDeviceTokenMap.remove(accountID);
		}
		if (aPhoneDeviceTokenMap.containsKey(accountID)) {
			aPhoneDeviceTokenMap.remove(accountID);
		}
		if (iPadDeviceTokenMap.containsKey(accountID)) {
			iPadDeviceTokenMap.remove(accountID);
		}
		if (aPadDeviceTokenMap.containsKey(accountID)) {
			aPadDeviceTokenMap.remove(accountID);
		}
	}

	public void addIPhoneDevice(String accountID, String aeid, String groupName, String deviceToken) {
		if (accountID == null) {
			return;
		}
		if (aeid == null) {
			return;
		}
		if (deviceToken == null) {
			return;
		}

		if (iPhoneDeviceTokenMap == null) {
			iPhoneDeviceTokenMap = new HashMap<String, String>();
		}
		Collection<String> values = iPhoneDeviceTokenMap.values();
		if (values.contains(deviceToken)) {
			values.remove(deviceToken);
		}

		// delete 原来的
		this.removeDeviceToken(accountID);

		iPhoneDeviceTokenMap.put(accountID, deviceToken);
		LogProxy.OutPrintln("add New iPhone account :" + accountID + " deviceToken : " + deviceToken);

		this.addAccountIDToAeid(accountID, aeid);
		this.addAccountIDToGroup(accountID, groupName);
	}

	public void addAPhoneDevice(String accountID, String aeid, String groupName, String deviceToken) {
		if (accountID == null) {
			return;
		}
		if (aeid == null) {
			return;
		}
		if (deviceToken == null) {
			return;
		}

		if (aPhoneDeviceTokenMap == null) {
			aPhoneDeviceTokenMap = new HashMap<String, String>();
		}

		LogProxy.OutPrintln(accountID + "　：" + aeid + "　：" + groupName + "　：" + deviceToken);

		Collection<String> values = aPhoneDeviceTokenMap.values();
		if (values.contains(deviceToken)) {
			values.remove(deviceToken);
		}

		// delete原来的
		this.removeDeviceToken(accountID);

		aPhoneDeviceTokenMap.put(accountID, deviceToken);
		LogProxy.OutPrintln("add New aPhone account :" + accountID + " deviceToken : " + deviceToken);

		this.addAccountIDToAeid(accountID, aeid);
		this.addAccountIDToGroup(accountID, groupName);
	}

	public void addIPadDevice(String accountID, String aeid, String groupName, String deviceToken) {
		if (accountID == null) {
			return;
		}
		if (aeid == null) {
			return;
		}
		if (deviceToken == null) {
			return;
		}

		if (iPadDeviceTokenMap == null) {
			iPadDeviceTokenMap = new HashMap<String, String>();
		}
		Collection<String> values = iPadDeviceTokenMap.values();
		if (values.contains(deviceToken)) {
			values.remove(deviceToken);
		}

		// delete 原来的
		this.removeDeviceToken(accountID);

		iPadDeviceTokenMap.put(accountID, deviceToken);
		LogProxy.OutPrintln("add New iPad account :" + accountID + " deviceToken : " + deviceToken);

		this.addAccountIDToAeid(accountID, aeid);
		this.addAccountIDToGroup(accountID, groupName);
	}

	public void addAPadDevice(String accountID, String aeid, String groupName, String deviceToken) {
		if (accountID == null) {
			return;
		}
		if (aeid == null) {
			return;
		}
		if (deviceToken == null) {
			return;
		}

		if (aPadDeviceTokenMap == null) {
			aPadDeviceTokenMap = new HashMap<String, String>();
		}

		LogProxy.OutPrintln(accountID + "　：" + aeid + "　：" + groupName + "　：" + deviceToken);

		Collection<String> values = aPadDeviceTokenMap.values();
		if (values.contains(deviceToken)) {
			values.remove(deviceToken);
		}

		// delete原来的
		this.removeDeviceToken(accountID);

		aPadDeviceTokenMap.put(accountID, deviceToken);
		LogProxy.OutPrintln("add New aPad account :" + accountID + " deviceToken : " + deviceToken);

		this.addAccountIDToAeid(accountID, aeid);
		this.addAccountIDToGroup(accountID, groupName);
	}

	public String getIPhoneDevice(String accountID) {
		if (iPhoneDeviceTokenMap == null) {
			return null;
		}
		return iPhoneDeviceTokenMap.get(accountID);
	}

	public String getAPhoneDevice(String accountID) {
		if (aPhoneDeviceTokenMap == null) {
			return null;
		}
		return aPhoneDeviceTokenMap.get(accountID);
	}

	public String getIPadDevice(String accountID) {
		if (iPadDeviceTokenMap == null) {
			return null;
		}
		return iPadDeviceTokenMap.get(accountID);
	}

	public String getAPadDevice(String accountID) {
		if (aPadDeviceTokenMap == null) {
			return null;
		}
		return aPadDeviceTokenMap.get(accountID);
	}

	// public Collection<String> getAllIOSDevice() {
	// if (iOSDeviceTokenMap == null) {
	// return null;
	// }
	//
	// return iOSDeviceTokenMap.values();
	// }
	//
	// public Collection<String> getAllAndroidDevice() {
	// if (androidDeviceTokenMap == null) {
	// return null;
	// }
	// return androidDeviceTokenMap.values();
	// }

	public Collection<String> getAllIPhoneAccount() {
		if (iPhoneDeviceTokenMap == null) {
			return null;
		}
		return iPhoneDeviceTokenMap.keySet();
	}

	public Collection<String> getAllAPhoneAccount() {
		if (aPhoneDeviceTokenMap == null) {
			return null;
		}
		return aPhoneDeviceTokenMap.keySet();
	}

	public Collection<String> getAllIPadAccount() {
		if (iPadDeviceTokenMap == null) {
			return null;
		}
		return iPadDeviceTokenMap.keySet();
	}

	public Collection<String> getAllAPadAccount() {
		if (aPadDeviceTokenMap == null) {
			return null;
		}
		return aPadDeviceTokenMap.keySet();
	}

	public List<String> getAccountByGroups(String[] groups) {
		ArrayList<String> tempList = new ArrayList<String>();
		for (String groupName : groups) {
			tempList.addAll(groupMap.get(groupName));
		}
		return tempList;
	}

	public List<String> getAccountByAeids(String[] aeids) {
		ArrayList<String> tempList = new ArrayList<String>();
		for (String aeid : aeids) {
			tempList.addAll(accountMap.get(aeid));
		}
		return tempList;
	}

	public int checkDeviceType(String accountID) {
		if (iPhoneDeviceTokenMap.keySet().contains(accountID)) {
			return PushCommInterface.PUSH_TYPE_IPHONE;
		} else if (aPhoneDeviceTokenMap.keySet().contains(accountID)) {
			return PushCommInterface.PUSH_TYPE_APHONE;
		} else if (iPadDeviceTokenMap.keySet().contains(accountID)) {
			return PushCommInterface.PUSH_TYPE_IPAD;
		} else if (aPadDeviceTokenMap.keySet().contains(accountID)) {
			return PushCommInterface.PUSH_TYPE_APAD;
		} else {
			return PushCommInterface.PUSH_TYPE_UNKNOW;
		}
	}

	private void addAccountIDToGroup(String accountID, String groupName) {
		if (groupMap == null) {
			return;
		}
		if (accountID == null) {
			return;
		}
		if (groupName == null) {
			return;
		}

		if (!groupMap.containsKey(groupName)) {
			List<String> accountList = new ArrayList<String>();
			groupMap.put(groupName, accountList);
		}
		List<String> tempList = groupMap.get(groupName);
		if (!tempList.contains(accountID)) {
			tempList.add(accountID);
		}
	}

	private void addAccountIDToAeid(String accountID, String aeid) {
		if (accountMap == null) {
			return;
		}
		if (aeid == null) {
			return;
		}
		if (accountID == null) {
			return;
		}

		if (!accountMap.containsKey(aeid)) {
			List<String> accountIDList = new ArrayList<String>();
			accountMap.put(aeid, accountIDList);
		}
		List<String> tempList = accountMap.get(aeid);
		if (!tempList.contains(accountID)) {
			tempList.add(accountID);
		}
	}
}
