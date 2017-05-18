package allone.MTP.VerBank01.Ctrl.push.send;

import java.util.List;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.push.register.PushCommInterface;
import allone.MTP.VerBank01.Ctrl.push.register.RegisterDoc;

public class SendCaptain {
	private static SendCaptain instance = new SendCaptain();

	private SendCaptain() {

	}

	public static SendCaptain getInstance() {
		return instance;
	}

	public boolean init(String rootPath) {
		return true;
	}

	public void sendToUser(String accountID, String info) {
		I_Sender sender = getSender(accountID);
		if (sender == null) {
			LogProxy.OutPrintln(accountID + " is null");

			return;
		}
		sender.sendInfoToUser(accountID, info);
	}

	public void sendToAllUser(String info) {
		sendIOSAll(info);
		sendAndroidAll(info);
	}

	public void sendToGroups(String[] groups, String info) {
		List<String> accountList = RegisterDoc.getInstance().getAccountByGroups(groups);
		for (String accountID : accountList) {
			sendToUser(accountID, info);
		}
	}

	public void sendToAeids(String[] aeids, String info) {
		List<String> accountList = RegisterDoc.getInstance().getAccountByAeids(aeids);
		for (String accountID : accountList) {
			sendToUser(accountID, info);
		}
	}

	public void sendToAccounts(String[] accounts, String info) {
		for (String accountID : accounts) {
			sendToUser(accountID, info);
		}
	}

	private void sendIOSAll(String info) {
		(new IPhoneSender()).sendInfoToAllUser(info);
		(new IPadSender()).sendInfoToAllUser(info);
	}

	private void sendAndroidAll(String info) {
		(new APhoneSender()).sendInfoToAllUser(info);
		(new APadSender()).sendInfoToAllUser(info);
	}

	private I_Sender getSender(String accountID) {
		int type = RegisterDoc.getInstance().checkDeviceType(accountID);
		I_Sender sender = null;
		switch (type) {
		case PushCommInterface.PUSH_TYPE_APHONE:
			sender = new APhoneSender();
			break;
		case PushCommInterface.PUSH_TYPE_IPHONE:
			sender = new IPhoneSender();
			break;
		case PushCommInterface.PUSH_TYPE_IPAD:
			sender = new IPadSender();
			break;
		case PushCommInterface.PUSH_TYPE_APAD:
			sender = new APadSender();
			break;

		default:
			break;
		}
		return sender;
	}

	// public static void main(String[] args) {
	// String ip = "gateway.sandbox.push.apple.com";
	// int port = 1111;
	// try {
	//
	// Socket s = new Socket(ip, port);
	// System.out.println(ip + " : " + port + " is open");
	// LogProxy.OutPrintln(ip + " : " + port + " is open");
	// s.close();
	// } catch (Exception e) {
	// System.out.println(ip + " : " + port + " is not open");
	// LogProxy.OutPrintln(ip + " : " + port + " is not open");
	// }
	// System.out.print("end");
	// }

}
