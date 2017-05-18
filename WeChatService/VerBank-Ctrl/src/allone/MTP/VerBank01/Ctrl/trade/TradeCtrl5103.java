package allone.MTP.VerBank01.Ctrl.trade;

import java.net.URL;
import java.net.URLEncoder;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5103;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5103;
import allone.MTP.VerBank01.Ctrl.util.URLConnectionUtil;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: TradeCtrl5103.java 
 * @Package allone.MTP.VerBank01.Ctrl.trade 
 * @Description: 更新憑證　(ReNewCert)：呼叫此API前需驗章成功
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月16日 上午11:14:53 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class TradeCtrl5103 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5103 ip = (IP_Ctrl5103) ipFather;
		OP_Ctrl5103 op = new OP_Ctrl5103(ip);
		try {
			String getURL = StaticContext.getConfigCaptain().getPhone_CAServletUrl() + "/" + StaticContext.getConfigCaptain().getPhone_reNewCert() + "?id=" + URLEncoder.encode(ip.getAeid(), "utf-8")
					+ "&deviceType=" + ip.getDeviceType() + "&deviceId=" + ip.getDeviceId() + "&venderId=" + ip.getVenderId() + "&csr=" + ip.getCSR() + "&sign=" + ip.getSign() + "&certSn="
					+ ip.getSign();
			URL getUrl = new URL(getURL);
			// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
			// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
			String value = URLConnectionUtil.connection(getUrl);
			if (value.equals("")) {
				op.setSucceed(false);
				op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			} else {
				String fnStatusVec[] = value.split("\\|");
				if (fnStatusVec != null) {
					int returnCode = Integer.parseInt(fnStatusVec[0]);
					String previousCA = fnStatusVec[1];
					op.setReturnCode(returnCode);
					op.setPreviousCA(previousCA);
				}
				op.setSucceed(true);
			}
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		return op;
	}
}
