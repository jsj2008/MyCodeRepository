package allone.MTP.VerBank01.Ctrl.trade;

import java.net.URL;
import java.net.URLEncoder;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5101;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5101;
import allone.MTP.VerBank01.Ctrl.comm.structure.FnStatus;
import allone.MTP.VerBank01.Ctrl.util.URLConnectionUtil;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

/**
 * 
 * @Project: VerBank-Ctrl 
 * @Title: TradeCtrl5101.java 
 * @Package allone.MTP.VerBank01.Ctrl.trade 
 * @Description: 取得目前可用功能、狀態及 CSR 金鑰長度(GetFnStatus2)  
 * @author wyb wang.yubo@allone.cn 
 * @date 2015年10月16日 上午10:13:02 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */
public class TradeCtrl5101 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5101 ip = (IP_Ctrl5101) ipFather;
		OP_Ctrl5101 op = new OP_Ctrl5101(ip);
		try {
			String getURL = StaticContext.getConfigCaptain().getPhone_CAServletUrl() + "/" + StaticContext.getConfigCaptain().getPhone_fnStatus() + "?id=" + URLEncoder.encode(ip.getAeid(), "utf-8")
					+ "&deviceType=" + ip.getDeviceType() + "&deviceId=" + ip.getDeviceId() + "&venderId=" + ip.getVenderId();
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
					int returnMsg = Integer.parseInt(fnStatusVec[1]);

					int effectiveCAnumber = (fnStatusVec[2].equals("") ? 0 : Integer.parseInt(fnStatusVec[2]));
					// 已申請憑證數
					int requestCANumber = (fnStatusVec[3].equals("") ? 0 : Integer.parseInt(fnStatusVec[3]));
					// 最新一張憑證序號
					String lastCASerial = fnStatusVec[4];
					// 最新一張憑證狀態
					int lastCAState = (fnStatusVec[5].equals("") ? 0 : Integer.parseInt(fnStatusVec[5]));
					// CSR 金鑰長度
					int csrLength = Integer.parseInt(fnStatusVec[6]);
					// 前次未完成流程憑證
					String previousCA = "";
					try {
						previousCA = fnStatusVec[7];
					} catch (Exception e) {
						previousCA = "";
					}

					FnStatus fnStatus = new FnStatus();
					fnStatus.setReturnCode(returnCode);
					fnStatus.setReturnMessage(returnMsg);
					fnStatus.setEffectiveCAnumber(effectiveCAnumber);
					fnStatus.setRequestCANumber(requestCANumber);
					fnStatus.setLastCASerial(lastCASerial);
					fnStatus.setLastCAState(lastCAState);
					fnStatus.setCsrLength(csrLength);
					fnStatus.setPreviousCA(previousCA);
					op.setFnStatus(fnStatus);
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
