package jedi.ex02.CSTS3.server.trade4client;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_BankServ1002;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_BankServ1002;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.bankserver.comm.ipop.client.OP_BankServ1002;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;

public class ClientTradeBankServ1002 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid, String ipaddress) {

		C3_IP_BankServ1002 ip = (C3_IP_BankServ1002) _ip;
		C3_OP_BankServ1002 op = new C3_OP_BankServ1002(ip);
		IPFather fip = ip.formatIP();
		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
				aeid, ipaddress);
		try {
			if (fop.isSucceed()) {
				op.parseFromSysData((OP_BankServ1002) fop);
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
