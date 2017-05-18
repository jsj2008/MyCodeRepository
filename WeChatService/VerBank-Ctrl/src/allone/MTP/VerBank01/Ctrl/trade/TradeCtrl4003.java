package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl4003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl4003;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3053;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl4003 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl4003 ip = (IP_Ctrl4003) ipFather;
		OP_Ctrl4003 op = new OP_Ctrl4003(ip);
		
		if (ip.getAeid() == null || ip.getUserName() == null) {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Parameter_Error);
			op.setErrMessage("aeid or username is null!");
			return op;
		}
		
		IP_TDB3053 tip = new IP_TDB3053();
		tip.setAeid(ip.getAeid());
		tip.setUserName(ip.getUserName());
		
		OPFather opf = StaticContext.getTradeCaptain().callTrade(tip);
		if (opf.isSucceed()) {
			op.setSucceed(true);
		} else {
			op.setSucceed(false);
			op.setErrCode(opf.getErrCode());
			op.setErrMessage(opf.getErrMessage());
		}
		
		return op;
	}

}
