package allone.MTP.VerBank01.Ctrl.trade;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.UUID;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.ca.check.CSHelper;
import allone.MTP.VerBank01.Ctrl.ca.check.CheckDoc;
import allone.MTP.VerBank01.Ctrl.ca.check.ResultReader;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5003;
import allone.MTP.VerBank01.Ctrl.comm.structure.UserCertState;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

public class TradeCtrl5003 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5003 ip = (IP_Ctrl5003) ipFather;
		OP_Ctrl5003 op = new OP_Ctrl5003(ip);
//		if (CheckDoc.getInstance().isChecked(ip.getAeid())) {
//			op.setState(CheckDoc.getInstance().get(ip.getAeid()));
//			op.setSucceed(true);
//			return op;
//		}
		try {
			String getURL = StaticContext.getConfigCaptain().getCaCheckCertStateUrl() + "?CN="
					+ URLEncoder.encode(ip.getAeid(), "utf-8") + "&UID=" + UUID.randomUUID().toString();
			URL getUrl = new URL(getURL);
			// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
			// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
			HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection();
			connection.setDoInput(true);
			connection.setUseCaches(false);
			// 进行连接，但是实际上get request要在下一句的connection.getInputStream()函数中才会真正发到
			// 服务器
			connection.connect();
			// 取得输入流，并使用Reader读取
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String lines;
			String value = null;
			while ((lines = reader.readLine()) != null) {
				if (lines.trim().length() > 0) {
					value = lines;
				}
			}
			LogProxy.OutPrintln(getURL + "\r\n" + value);
			reader.close();
			connection.disconnect();
			UserCertState state = ResultReader.getUserCertState(value);
			if (state.getCertStateDesc() == null) {
				state.setCertStateDesc(CSHelper.desc(String.valueOf(state.getCertState())));
			}
			state.setCertStateDesc(new String(state.getCertStateDesc().getBytes(), Charset.defaultCharset()));
			CheckDoc.getInstance().setChecked(ip.getAeid(), state);
			op.setState(state);
			op.setSucceed(true);
			// op.setErrMessage("\r\n" + getURL + "\r\n" + value + "\r\n");
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		return op;
	}

}
