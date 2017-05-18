package jedi.ex02.CSTS3.server.trade;

import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.ctrl.csts.comm.IPOP.IP_CSTS2002;
import jedi.v7.ctrl.csts.comm.IPOP.OP_CSTS2002;

public class CADTSTradeCSTS2002 extends CADTSTradeFather {

	@Override
	protected OPFather doTrade(IPFather _ip, String fromServ) {
		IP_CSTS2002 ip = (IP_CSTS2002) _ip;
		StaticContext.getCSTSDoc().setUserForbidden(ip.getUserName(),
				ip.getForbiddenGapInMs());
		StaticContext.getCSTSDoc().kickUser(ip.getUserName());
		OP_CSTS2002 op = new OP_CSTS2002(ip);
		op.setSucceed(true);
		return op;
	}

}
