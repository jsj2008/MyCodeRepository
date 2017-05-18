package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl4001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl4001;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3046;
import allone.MTP.VerBank01.TDB.comm.IPOP.OP_TDB3046;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl4001 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl4001 ip = (IP_Ctrl4001) ipFather;
		OP_Ctrl4001 op = new OP_Ctrl4001(ip);
		
		if (ip.getOldPswd() == null || ip.getNewPswd() == null || ip.getOldPswd().equals(ip.getNewPswd())) {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_PasswordErr);
			op.setErrMessage("old password or new password is not correct!");
			return op;
		}
		
		IP_TDB3046 tip = new IP_TDB3046();
		tip.setAeid(ip.getAeid());
		tip.setAccount(ip.getAccount());
		tip.setOldPassword(ip.getOldPswd());
		tip.setNewPassword(ip.getNewPswd());
		tip.setRealName(ip.getRealName());
		tip.setIpAddress(ip.getIpAddress());
		
		OPFather opf = StaticContext.getTradeCaptain().callTrade(tip);
		if (opf.isSucceed()) {
			OP_TDB3046 top = (OP_TDB3046) opf;
			op.setSucceed(true);
			op.setResult(top.getChecktype());
		} else {
			op.setSucceed(false);
			op.setErrCode(opf.getErrCode());
			op.setErrMessage(opf.getErrMessage());
		}
		
		return op;
	}

}
