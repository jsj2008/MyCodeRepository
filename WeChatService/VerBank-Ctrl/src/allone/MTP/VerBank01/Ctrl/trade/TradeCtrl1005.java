package allone.MTP.VerBank01.Ctrl.trade;

import java.util.ArrayList;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl1005;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl1005;
import allone.MTP.VerBank01.Ctrl.comm.ipop.dsts.IP_CtrlDSTS1001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.dsts.OP_CtrlDSTS1001;
import allone.MTP.VerBank01.Ctrl.util.ListUtil;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl1005 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl1005 ip = (IP_Ctrl1005) ipFather;
		OP_Ctrl1005 op = new OP_Ctrl1005(ip);
		
		String dealerName = ip.getDealerName();
		long forbiddenGapInMs = ip.getForbiddenGapInMs();
		IP_CtrlDSTS1001 cip = new IP_CtrlDSTS1001();
		cip.setDealerName(dealerName);
		cip.setForbiddenGapInMs(forbiddenGapInMs);
		
		String[] dstsNames = StaticContext.getConfigCaptain().getDstsNames();
		OPFather opf = null;
		OP_CtrlDSTS1001 cop = null;
		ArrayList<String> ipList = new ArrayList<String>();
		for (String serv : dstsNames) {
			opf = StaticContext.getTradeCaptain().callTrade(serv, cip);
			if (opf.isSucceed()) {
				cop = (OP_CtrlDSTS1001) opf;

				ListUtil.setupList(ipList, cop.getIpList());
			}
		}
		
		op.setSucceed(true);
		op.setIpList(ipList.toArray(new String[0]));
		
		return op;
	}

}
