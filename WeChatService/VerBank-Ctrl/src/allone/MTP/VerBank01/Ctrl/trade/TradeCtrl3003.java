package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl3003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl3003;
import allone.MTP.VerBank01.comm.IPOP.IPOPErrCodeTable;

public class TradeCtrl3003 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl3003 ip = (IP_Ctrl3003) ipFather; 
		OP_Ctrl3003 op = new OP_Ctrl3003(ip);
		
		boolean flag = false;
		if (ip.getType() == IP_Ctrl3003.REFRESH_CONFIG) {
			flag = StaticContext.getDocCaptain().refreshOtherClientConfig();
		}
		
		if (flag) {
			op.setSucceed(true);
		} else {
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_TradeFailed);
			op.setErrMessage("unknown type or trade failed!");
		}
		
		return op;
	}

}
