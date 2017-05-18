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

public class APadSender implements I_Sender {

	static boolean isChecked = false;

	@Override
	public void sendInfoToUser(String accountID, String info) {

		if (!isChecked) {
			checkPort("http://android.googleapis.com/", 5228);
			checkPort("http://android.googleapis.com/", 5229);
			checkPort("http://android.googleapis.com/", 5230);
			isChecked = true;
		}

		String deviceToken = RegisterDoc.getInstance().getAPadDevice(accountID);

		Sender sender = new Sender(StaticContext.getSendConfig().getaPadApiKey());
		Message message = new Message.Builder().addData("message", info).build();
		Result result = null;

		try {

			result = sender.send(message, deviceToken, 5);

			LogProxy.OutPrintln("APad deviceToken is : " + deviceToken);
			LogProxy.OutPrintln("APad sendMessage is : " + info);
			LogProxy.OutPrintln("APad account is : " + accountID);

			if (result == null) {
				LogProxy.OutPrintln("APad sender  result is null!");
			} else {
				LogProxy.OutPrintln("APad sender " + result.toString());
			}

		} catch (IOException e) {
			e.printStackTrace();
			LogProxy.OutPrintln("APad sender err" + e);
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
				LogProxy.OutPrintln("APad not registered at google ");
			}
		}
	}

	@Override
	public void onDestroy() {
		// TODO Auto-generated method stub
	}

	@Override
	public void sendInfoToAllUser(String info) {
		Collection<String> androidAccounts = RegisterDoc.getInstance().getAllAPadAccount();
		for (String accountID : androidAccounts) {
			sendInfoToUser(accountID, info);
		}
	}

	private void checkPort(String ip, int port) {
		try {
			Socket s = new Socket(ip, port);
			LogProxy.OutPrintln("APad : " + ip + " : " + port + " is open");
			s.close();
		} catch (Exception e) {
			LogProxy.OutPrintln("APad : " + ip + " : " + port + " is not open");
		}
	}
}
