package allone.MTP.VerBank01.Ctrl.trade;

import java.util.ArrayList;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerIPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.CtrlServerOPFather;
import allone.MTP.VerBank01.Ctrl.comm.ipop.IP_Ctrl2003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.OP_Ctrl2003;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.IP_CtrlCSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.ipop.csts.OP_CtrlCSTS2001;
import allone.MTP.VerBank01.Ctrl.comm.structure.UserMsgNode;
import allone.MTP.VerBank01.Ctrl.util.ListUtil;
import allone.MTP.VerBank01.comm.IPOP.OPFather;

public class TradeCtrl2003 extends TradeFather {

	@Override
	public CtrlServerOPFather doTrade(CtrlServerIPFather ipFather) {
		IP_Ctrl2003 ip = (IP_Ctrl2003) ipFather;
		OP_Ctrl2003 op = new OP_Ctrl2003(ip);
		
		
		IP_CtrlCSTS2001 cip = new IP_CtrlCSTS2001();
		cip.setType(IP_CtrlCSTS2001.TYPE_ALL);
		
		ArrayList<UserMsgNode> userList = new ArrayList<UserMsgNode>();
		
		String[] cstsNames = StaticContext.getConfigCaptain().getCstsNames();
		OPFather opf = null;
		OP_CtrlCSTS2001 cop = null;
		for (String serv : cstsNames) {
			opf = StaticContext.getTradeCaptain().callTrade(serv, cip);
			if (opf.isSucceed()) {
				cop = (OP_CtrlCSTS2001) opf;
				
				ListUtil.setupList(userList, cop.getUserList());
			}
		}
		
		op.setSucceed(true);
		op.setUserList(userList);
		
		return op;
	}

	
}
