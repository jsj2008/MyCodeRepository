package allone.MTP.VerBank01.Ctrl.trade;

import java.net.URL;
import java.net.URLEncoder;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.ca.url.Base64Util;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5102;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5102;
import allone.MTP.VerBank01.Ctrl.util.URLConnectionUtil;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: TradeCtrl5102.java 
 * @Package allone.MTP.VerBank01.Ctrl.trade 
 * @Description: 申請憑證　(ApplyCert)
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月16日 上午10:44:10 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class TradeCtrl5102 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5102 ip = (IP_Ctrl5102) ipFather;
		OP_Ctrl5102 op = new OP_Ctrl5102(ip);
		try {
			String getURL = StaticContext.getConfigCaptain().getPhone_CAServletUrl() + "/" + StaticContext.getConfigCaptain().getPhone_applyCert() + "?id=" + URLEncoder.encode(ip.getAeid(), "utf-8")
					+ "&deviceType=" + ip.getDeviceType() + "&deviceId=" + ip.getDeviceId() + "&venderId=" + ip.getVenderId() + "&passwd=" + ip.getPassword() + "&csr=" + ip.getCSR();
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
					String replaceContext = previousCA.replace("-----BEGIN CERTIFICATE-----", "").replace("-----END CERTIFICATE-----", "");
					op.setPreviousCA(replaceContext);
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

	public static void main(String[] args) {
		String str = "MIIFnzCCA+OgAwIBAgIETs1s+";
		System.out.println(Base64Util.encode(str.getBytes()));
	}

}
