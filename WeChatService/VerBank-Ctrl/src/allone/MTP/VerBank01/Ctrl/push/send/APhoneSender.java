package allone.MTP.VerBank01.Ctrl.push.send;

import java.io.IOException;
import java.net.Socket;
import java.util.Collection;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.push.register.RegisterDoc;

import com.google.android.gcm.server.Constants;
import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

public class APhoneSender implements I_Sender {

	// private static String deviceRegId =
	// "APA91bHwe5H3Ihl-fKWIdXjq-xS76NLAOqpyt3IViUHVflyONw_xsfzbL69pRV_0FMEVVgCjKMEMLLDjOs4GTqR9t83ckzmG6nQDtjl4ZMFzNrFwar5GPue-J9vyNRjBdasLJEFo9AVZ";
	// private static String deviceRegId =
	// "APA91bHkqE9t5TwC3jusIKihNorDwzqlxidIndzE3WqkN7VwY2YOMclWt89AuO6sEtvlWhU6zQ8ktD6igatUru93i_KmVzbfDa4MzgrXwiVI-Hdn4aVPRgdTyvJLNq_JQPb-bgV63x7Y";

	static boolean isChecked = false;

	@Override
	public void sendInfoToUser(String accountID, String info) {

		if (!isChecked) {
			checkPort("http://android.googleapis.com/", 5228);
			checkPort("http://android.googleapis.com/", 5229);
			checkPort("http://android.googleapis.com/", 5230);
			isChecked = true;
		}

		String deviceToken = RegisterDoc.getInstance().getAPhoneDevice(accountID);

		Sender sender = new Sender(StaticContext.getSendConfig().getaPhoneApiKey());
		Message message = new Message.Builder().addData("message", info).build();
		Result result = null;

		try {

			result = sender.send(message, deviceToken, 5);

			LogProxy.OutPrintln("APhone deviceToken is : " + deviceToken);
			LogProxy.OutPrintln("APhone sendMessage is : " + info);
			LogProxy.OutPrintln("APhone account is : " + accountID);

			if (result == null) {
				LogProxy.OutPrintln("APhone sender  result is null!");
			} else {
				LogProxy.OutPrintln("APhone sender " + result.toString());
			}

		} catch (IOException e) {
			e.printStackTrace();
			LogProxy.OutPrintln("APhone sender err" + e);
		}
		// 为空，则消息未发送给任何设备

		if (result.getMessageId() != null) {

			String canonicalRegId = result.getCanonicalRegistrationId();
			// 用户注册了新的注册id，或者谷歌服务器刷新了注册id。
			// 用户注册了新id，旧的id会被保存一段时间。此时使用旧id发送消息，设备即使已使用新id，依然可以收到
			if (canonicalRegId != null) {
				// same device has more than on registration ID: update database
			}

		} else {
			String error = result.getErrorCodeName();
			if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
				LogProxy.OutPrintln("APhone not registered at google ");
			}
		}
	}

	@Override
	public void onDestroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void sendInfoToAllUser(String info) {
		Collection<String> androidAccounts = RegisterDoc.getInstance().getAllAPhoneAccount();
		for (String accountID : androidAccounts) {
			sendInfoToUser(accountID, info);
		}
	}

	private void checkPort(String ip, int port) {
		try {
			Socket s = new Socket(ip, port);
			LogProxy.OutPrintln("aphone : " + ip + " : " + port + " is open");
			s.close();
		} catch (Exception e) {
			LogProxy.OutPrintln("aphone : " + ip + " : " + port + " is not open");
		}
	}
}
