package allone.MTP.VerBank01.Ctrl.trade;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5201;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5201;
import allone.MTP.VerBank01.Ctrl.push.register.PushCommInterface;
import allone.MTP.VerBank01.Ctrl.push.register.RegisterDoc;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

/**
 * 
 * @Project: Ctrl 
 * @Title: TradeCtrl5201.java 
 * @Package allone.MTP.VerBank01.Ctrl.trade 
 * @Description: TODO  DeviceToken store
 * @author zl zhang.lei@allone.cn 
 * @date 2015年10月28日 下午9:13:23 
 * @Copyright: 2015 www.allone.cn Inc. All rights reserved. 
 * @version V3.0.0   
 */

public class TradeCtrl5201 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5201 ip = (IP_Ctrl5201) ipFather;
		OP_Ctrl5201 op = new OP_Ctrl5201(ip);
		try {
			if (ip.getDeviceType() == PushCommInterface.PUSH_TYPE_IPHONE) {
				RegisterDoc.getInstance().addIPhoneDevice(ip.getAccountID(), ip.getAeid(), ip.getGroupName(), ip.getDeviceToken());
				op.setSucceed(true);
			} else if (ip.getDeviceType() == PushCommInterface.PUSH_TYPE_APHONE) {
				RegisterDoc.getInstance().addAPhoneDevice(ip.getAccountID(), ip.getAeid(), ip.getGroupName(), ip.getDeviceToken());
				op.setSucceed(true);
			} else if (ip.getDeviceType() == PushCommInterface.PUSH_TYPE_IPAD) {
				RegisterDoc.getInstance().addIPadDevice(ip.getAccountID(), ip.getAeid(), ip.getGroupName(), ip.getDeviceToken());
				op.setSucceed(true);
			} else if (ip.getDeviceType() == PushCommInterface.PUSH_TYPE_APAD) {
				RegisterDoc.getInstance().addAPadDevice(ip.getAccountID(), ip.getAeid(), ip.getGroupName(), ip.getDeviceToken());
				op.setSucceed(true);
			} else {
				op.setSucceed(false);
				op.setErrCode("Unknow DeviceType");
				op.setErrMessage("Unknow DeviceType");
			}
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_TradeFailed);
			op.setErrMessage("RegisterDoc failed");
		}
		return op;
	}
}
