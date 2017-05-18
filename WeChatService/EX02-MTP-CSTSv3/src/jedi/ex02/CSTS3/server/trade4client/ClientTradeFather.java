package jedi.ex02.CSTS3.server.trade4client;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import allone.CADTS.comm.ErrCodeTable;

public abstract class ClientTradeFather {
	
	public C3_OPFather call_trade(C3_IPFather ip,String aeid, String ipaddress) {
		try {
			return doTrade(ip,aeid,ipaddress);
		} catch (Exception e) {
			C3_OPFather op = new C3_OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(ErrCodeTable.ERR_OTHER);
			op.setErrMessage("Unknow Err." + e.getMessage());
			e.printStackTrace();
			return op;
		}
	}

	protected abstract C3_OPFather doTrade(C3_IPFather _ip,String aeid, String ipaddress);

}
