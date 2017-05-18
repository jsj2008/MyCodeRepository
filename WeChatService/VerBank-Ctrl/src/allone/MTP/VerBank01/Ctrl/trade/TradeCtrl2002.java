package allone.MTP.VerBank01.Ctrl.trade;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl2002;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl2002;
import allone.MTP.VerBank01.Ctrl.comm.util.CtrlDigistTool;
import allone.MTP.VerBank01.comm.datastruct.DB.OtherClientConfig;

public class TradeCtrl2002 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl2002 ip = (IP_Ctrl2002) ipFather;
		OP_Ctrl2002 op = new OP_Ctrl2002(ip);
		
		OtherClientConfig[] configs = StaticContext.getDocCaptain()
				.getOtherClientConfig(ip.getKeys(), ip.getLocale());
			
		byte[] digist1 = ip.getDigist();
		byte[] digist2 = CtrlDigistTool.digist(configs);
		if (CtrlDigistTool.isMatch(digist1, digist2)) {
			op.setForceToReNew(false);
		} else {
			op.setForceToReNew(true);
			op.setOtherClientConfigVec(configs);
		}
		op.setSucceed(true);
		return op;
	}

}
