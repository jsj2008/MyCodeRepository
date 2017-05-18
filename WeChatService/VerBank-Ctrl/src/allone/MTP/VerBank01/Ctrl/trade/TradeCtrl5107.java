package allone.MTP.VerBank01.Ctrl.trade;

import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5107;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5107;
import allone.MTP.VerBank01.Ctrl.comm.structure.FnCertState;
import allone.MTP.VerBank01.Ctrl.util.URLConnectionUtil;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.datastruct.CommDataInterface;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: TradeCtrl5107.java 
 * @Package allone.MTP.VerBank01.Ctrl.trade 
 * @Description: 取得憑證　(QueryCert)
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月16日 上午11:54:53 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class TradeCtrl5107 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5107 ip = (IP_Ctrl5107) ipFather;
		OP_Ctrl5107 op = new OP_Ctrl5107(ip);
		String value = "";
		try {
			String getURL = StaticContext.getConfigCaptain().getPhone_CAServletUrl() + "/" + StaticContext.getConfigCaptain().getPhone_queryCert() + "?id=" + URLEncoder.encode(ip.getAeid(), "utf-8")
					+ "&deviceType=" + ip.getDeviceType() + "&deviceId=" + ip.getDeviceId() + "&venderId=" + ip.getVenderId() + "&serial=" + ip.getSerial();
			URL getUrl = new URL(getURL);
			// 根据拼凑的URL，打开连接，URL.openConnection函数会根据URL的类型，
			// 返回不同的URLConnection子类的对象，这里URL是一个http，因此实际返回的是HttpURLConnection
			value = URLConnectionUtil.connection(getUrl);
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode("Err_CATRADE_ServerNotConnection");
			op.setErrMessage(e.getMessage());
			return op;
		}
		try {
			if (value.equals("")) {
				op.setSucceed(false);
				op.setErrCode("Err_CATRADE_ResultIsNull");
			} else {
				String fnStatusVec[] = value.split("\\|");
				if (fnStatusVec != null) {
					FnCertState fnCertState = new FnCertState();
					int returnCode = Integer.parseInt(fnStatusVec[0]);
					fnCertState.setReturnCode(returnCode);
					if (returnCode == CommDataInterface.CA_TRADE_SUCCEED) {

						int requestID = Integer.parseInt(fnStatusVec[1]);
						// 憑證序號
						String caSerial = fnStatusVec[2];
						// 憑證狀態代碼
						int caState = Integer.parseInt(fnStatusVec[3]);
						// CN
						String cn = fnStatusVec[4];
						// 憑證效期起
						long beginValidTime = Long.parseLong(fnStatusVec[5]);
						// 憑證效期迄
						long endValidTime = Long.parseLong(fnStatusVec[6]);
						fnCertState.setRequestID(requestID);
						fnCertState.setCaSerial(caSerial);
						fnCertState.setCaState(caState);
						fnCertState.setCn(cn);
						fnCertState.setBeginValidTime(beginValidTime);
						fnCertState.setEndValidTime(endValidTime);
					}
					op.setCertState(fnCertState);
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
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(date));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MINUTE, 30);
		System.out.println(sdf.format(calendar.getTime()));
	}
}
