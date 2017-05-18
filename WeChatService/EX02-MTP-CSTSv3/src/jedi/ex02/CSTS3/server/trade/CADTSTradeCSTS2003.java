package jedi.ex02.CSTS3.server.trade;

import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.ctrl.csts.comm.IPOP.IP_CSTS2003;
import jedi.v7.ctrl.csts.comm.IPOP.OP_CSTS2003;

public class CADTSTradeCSTS2003 extends CADTSTradeFather {

	@Override
	protected OPFather doTrade(IPFather _ip, String fromServ) {
		IP_CSTS2003 ip = (IP_CSTS2003) _ip;
		
		StaticContext.getCSTSDoc().kickUserByAnotherLogin(ip.getUserName(), ip.getUserGuid(), ip.getNewUserIP());
		OP_CSTS2003 op = new OP_CSTS2003(ip);
		op.setSucceed(true);
		return op;
	}

}
