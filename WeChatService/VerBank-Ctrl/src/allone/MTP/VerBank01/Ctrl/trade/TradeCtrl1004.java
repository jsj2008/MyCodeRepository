package allone.MTP.VerBank01.Ctrl.trade;

import java.util.ArrayList;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl1004;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl1004;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.IP_CtrlCSTS1001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.OP_CtrlCSTS1001;
import allone.MTP.VerBank01.Ctrl.util.ListUtil;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl1004 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl1004 ip = (IP_Ctrl1004) ipFather;
		OP_Ctrl1004 op = new OP_Ctrl1004(ip);
		
		String aeid = ip.getAeid();
		long forbiddenGapInMs = ip.getForbiddenGapInMs();
		IP_CtrlCSTS1001 cip = new IP_CtrlCSTS1001();
		cip.setAeid(aeid);
		cip.setForbiddenGapInMs(forbiddenGapInMs);
		
		String[] cstsNames = StaticContext.getConfigCaptain().getCstsNames();
		OPFather opf = null;
		OP_CtrlCSTS1001 cop = null;
		ArrayList<String> ipList = new ArrayList<String>();
		for (String serv : cstsNames) {
			opf = StaticContext.getTradeCaptain().callTrade(serv, cip);
			if (opf.isSucceed()) {
				cop = (OP_CtrlCSTS1001) opf;

				ListUtil.setupList(ipList, cop.getIpList());
			}
		}
		
		op.setSucceed(true);
		op.setIpList(ipList.toArray(new String[0]));
		
		return op;
	}

}
