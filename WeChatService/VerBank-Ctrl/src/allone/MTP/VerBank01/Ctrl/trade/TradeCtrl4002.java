package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl4002;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl4002;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3135;
import allone.MTP.VerBank01.TDB.comm.IPOP.OP_TDB3135;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl4002 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl4002 ip = (IP_Ctrl4002) ipFather;
		OP_Ctrl4002 op = new OP_Ctrl4002(ip);
		
		if (ip.getAccount() <= 0) {
			op.setErrCode(IPOPErrCodeTable.ERR_Parameter_Error);
			op.setErrMessage("account must be large than zero.");
			return op;
		}
		
		String opp = ip.getOldPhonePin();
		String npp = ip.getNewPhonePin();
		
		if (opp == null || npp == null || opp.equals(npp)) {
			op.setErrCode(IPOPErrCodeTable.ERR_Parameter_Error);
			op.setErrMessage("old phonepin or new phonepin is invalid.");
			return op;
		}
		
		IP_TDB3135 tip = new IP_TDB3135();
		tip.setAeid(ip.getAeid());
		tip.setAccount(ip.getAccount());
		tip.setOldPhonePin(opp);
		tip.setNewPhonePin(npp);
		tip.setRealName(ip.getRealName());
		tip.setIpAddress(ip.getIpAddress());
		
		OPFather opf = StaticContext.getTradeCaptain().callTrade(tip);
		if (opf.isSucceed()) {
			OP_TDB3135 top = (OP_TDB3135) opf;
			op.setSucceed(true);
			op.setCheckType(top.getChecktype());
		} else {
			op.setSucceed(false);
			op.setErrCode(opf.getErrCode());
			op.setErrMessage(opf.getErrMessage());
		}
		
		return op;
	}

}
