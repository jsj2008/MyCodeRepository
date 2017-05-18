package allone.MTP.VerBank01.Ctrl.trade;

import java.util.ArrayList;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl2004;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl2004;
import allone.MTP.VerBank01.Ctrl.comm.ipop.dsts.IP_CtrlDSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.dsts.OP_CtrlDSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.structure.DealerMsgNode;
import allone.MTP.VerBank01.Ctrl.util.ListUtil;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl2004 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl2004 ip = (IP_Ctrl2004) ipFather;
		OP_Ctrl2004 op = new OP_Ctrl2004(ip);
		
		
		IP_CtrlDSTS2001 cip = new IP_CtrlDSTS2001();
		cip.setType(IP_CtrlDSTS2001.TYPE_ALL);
		
		ArrayList<DealerMsgNode> dealerList = new ArrayList<DealerMsgNode>();
		
		String[] dstsNames = StaticContext.getConfigCaptain().getDstsNames();
		OPFather opf = null;
		OP_CtrlDSTS2001 cop = null;
		for (String serv : dstsNames) {
			opf = StaticContext.getTradeCaptain().callTrade(serv, cip);
			if (opf.isSucceed()) {
				cop = (OP_CtrlDSTS2001) opf;
				
				ListUtil.setupList(dealerList, cop.getDealer());
			}
		}
		
		op.setSucceed(true);
		op.setDealerList(dealerList);
		
		return op;
	}

}
