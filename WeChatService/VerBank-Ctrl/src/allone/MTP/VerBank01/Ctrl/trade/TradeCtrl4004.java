package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl4004;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl4004;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3136;
import allone.MTP.VerBank01.TDB.comm.IPOP.OP_TDB3136;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl4004 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl4004 ip = (IP_Ctrl4004) ipFather;
		OP_Ctrl4004 op = new OP_Ctrl4004(ip);

		IP_TDB3136 tip = new IP_TDB3136();
		tip.setPhonePin(ip.getPhonePin());
		tip.setAccount(ip.getAccount());

		OPFather opf = StaticContext.getTradeCaptain().callTrade(tip);
		if (opf.isSucceed()) {
			op.setSucceed(true);
			OP_TDB3136 top = (OP_TDB3136) opf;
			op.setCheckType(top.getChecktype());
		} else {
			op.setSucceed(false);
			op.setErrCode(opf.getErrCode());
			op.setErrMessage(opf.getErrMessage());
		}
		return op;
	}

}
