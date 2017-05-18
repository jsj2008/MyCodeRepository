package allone.MTP.VerBank01.Ctrl.push.send;

import java.io.InputStream;
import java.net.Socket;
import java.util.Collection;
import java.util.List;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.push.register.RegisterDoc;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.IApnsService;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.impl.ApnsServiceImpl;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.model.ApnsConfig;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.model.Feedback;
import allone.MTP.VerBank01.Ctrl.push.send.appleSender.model.Payload;

public class IPhoneSender implements I_Sender {

	static boolean isChecked = false;

	@Override
	public void sendInfoToUser(String _accountID, String _info) {

		if (!isChecked) {
			checkPort("gateway.sandbox.push.apple.com", 2195);
			checkPort("gateway.push.apple.com", 2195);
			isChecked = true;
		}

		String token = RegisterDoc.getInstance().getIPhoneDevice(_accountID);

		Payload payload = new Payload();
		payload.setAlert(_info);
		payload.setBadge(0);
		payload.setSound("default");

		IApnsService apnsService = getApnsService(_accountID);
		apnsService.sendNotification(token, payload);

		LogProxy.OutPrintln("IPhone Sender accountID : " + _accountID);
		LogProxy.OutPrintln("IPhone Sender sendToToken : " + token);
		LogProxy.OutPrintln("IPhone Sender message : " + _info);

		List<Feedback> list = apnsService.getFeedbacks();
		if (list != null && list.size() > 0) {
			for (Feedback feedback : list) {
				LogProxy.OutPrintln(feedback.getDate() + " " + feedback.getToken());
			}
		}
	}

	@Override
	public void sendInfoToAllUser(String info) {
		Collection<String> iOSAccounts = RegisterDoc.getInstance().getAllIPhoneAccount();
		for (String accountID : iOSAccounts) {
			sendInfoToUser(accountID, info);
		}
	}

	@Override
	public void onDestroy() {
		// TODO Auto-generated method stub
	}

	private IApnsService getApnsService(String accountID) {
		// 不能使用accountID 做service的key 当同一设备换用户后，改设备还会受到account的消息
		IApnsService apnsService = ApnsServiceImpl.getCachedService(accountID);
		if (apnsService == null) {
			ApnsConfig config = new ApnsConfig();
			InputStream is = StaticContext.getSendConfig().getiPhoneKeyStream();
			config.setKeyStore(is);
			config.setDevEnv(StaticContext.getSendConfig().isiPhoneIsDevelop());
			config.setPassword(StaticContext.getSendConfig().getiPhoneKeyPwd());
			config.setPoolSize(StaticContext.getSendConfig().getPoolSize());
			// 假如需要在同个java进程里给不同APP发送通知，那就需要设置为不同的name
			config.setName(accountID);
			apnsService = ApnsServiceImpl.createInstance(config);
		}
		return apnsService;
	}

	private void checkPort(String ip, int port) {
		try {
			Socket s = new Socket(ip, port);
			LogProxy.OutPrintln("iphone " + ip + " : " + port + " is open");
			s.close();
		} catch (Exception e) {
			LogProxy.OutPrintln("iphone " + ip + " : " + port + " is not open");
		}
	}

}
