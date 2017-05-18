package jedi.ex02.CSTS3.server.trade4client;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_TRADESERV5001;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_TRADESERV5001;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.DB.AccountStrategy;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5028;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5001;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5028;

public class ClientTradeTRADESERV5001 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid,
			String ipaddress) {
		C3_IP_TRADESERV5001 ip = (C3_IP_TRADESERV5001) _ip;
		C3_OP_TRADESERV5001 op = new C3_OP_TRADESERV5001(ip);
		IPFather fip = ip.formatIP();
		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
				aeid, ipaddress);
		try {
			if (fop.isSucceed()) {
				op.parseFromSysData((OP_TRADESERV5001) fop);
			} else {
				op.parseFromSysData(fop);
			}
			if (fop.isSucceed()) {
				OP_TRADESERV5001 op5001 = (OP_TRADESERV5001) fop;
				if (op5001.getResult() == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
					IP_TRADESERV5028 ip5028=new IP_TRADESERV5028();
					ip5028.setAeid(ip.getUserName());
					fop = StaticContext.getClientTradeCaptain().doSysTrade(ip5028,aeid, ipaddress);
					if(fop.isSucceed()){
						OP_TRADESERV5028 op5028=(OP_TRADESERV5028) fop;
						AccountStrategy[] accs=op5028.getAccountStrategyVec();
						Long[] accounts=new Long[accs.length];
						for (int i = 0; i < accs.length; i++) {
							accounts[i]=accs[i].getAccount();
						}
						op.setAccounts(accounts);
					}
				}
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
