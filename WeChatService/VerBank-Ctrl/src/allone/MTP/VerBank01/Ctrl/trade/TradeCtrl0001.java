package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl0001;

public class TradeCtrl0001 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		OP_Ctrl0001 op = new OP_Ctrl0001(ipFather);
		op.setSucceed(true);
		return op;
	}

}
