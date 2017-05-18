package jedi.ex02.CSTS3.server.trade4client;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5110;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5110;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5110;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5110;

public class ClientTradeTRADESERV5110 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid,
			String ipaddress) {
		C3_IP_TRADESERV5110 ip = (C3_IP_TRADESERV5110) _ip;
		C3_OP_TRADESERV5110 op = new C3_OP_TRADESERV5110(ip);
		IPFather fip = ip.formatIP();
		IP_TRADESERV5110 tip=(IP_TRADESERV5110) fip;
		tip.setAeid(aeid);
		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
				aeid, ipaddress);
		try {
			if (fop.isSucceed()) {
				op.parseFromSysData((OP_TRADESERV5110) fop);
			} else {
				op.parseFromSysData(fop);
			}
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		op.setSucceed(fop.isSucceed());
		op.setErrCode(fop.getErrCode());
		op.setErrMessage(fop.getErrMessage());
		return op;
	}

}
