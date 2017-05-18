package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl5002;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl5002;
import allone.MTP.VerBank01.TDB.comm.IPOP.IP_TDB3133;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl5002 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		
		IP_Ctrl5002 ip = (IP_Ctrl5002) ipFather;
		OP_Ctrl5002 op = new OP_Ctrl5002(ip);
		
		IP_TDB3133 tip = new IP_TDB3133();
		tip.setAccount(ip.getAccount());
		tip.setLevel(ip.getLevel());
		tip.setTradeDay(ip.getTradeDay());
		
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
