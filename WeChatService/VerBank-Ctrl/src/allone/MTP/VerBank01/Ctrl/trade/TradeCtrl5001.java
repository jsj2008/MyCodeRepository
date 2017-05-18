package allone.MTP.VerBank01.Ctrl.trade;

import allone.Log.simpleLog.log.LogProxy;
import allone.MTP.VerBank01.Ctrl.ca.CASignException;
import allone.MTP.VerBank01.Ctrl.ca.server.CAServerProxy;
import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5001;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

public class TradeCtrl5001 extends TradeFather {

	private CAServerProxy proxy = new CAServerProxy();
	
	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl5001 ip = (IP_Ctrl5001) ipFather;
		OP_Ctrl5001 op = new OP_Ctrl5001(ip);
		
		if (StaticContext.getConfigCaptain().isDebug()) {
			op.setSucceed(true);
			op.setVerify(true);
			return op;
		}
		
		String sd = ip.getSignatureData();
		String od = ip.getOriginalData();
		
		if (sd == null || sd.isEmpty() || od == null || od.isEmpty()) {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Parameter_Error);
			op.setErrMessage("signatureData or originalData is null");
			LogProxy.ErrPrintln("signatureData or originalData is null");
			return op;
		}
		
		op.setSucceed(true);
		
		try {
			proxy.verifySignData(sd, od);
			op.setVerify(true);
		} catch (CASignException e) {
			op.setVerify(false);
			op.setFailedReason(e.getReason());
		} catch (Exception e) {
			LogProxy.printException(e);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		
		return op;
	}

}
