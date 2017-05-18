package jedi.ex02.CSTS3.server.trade;

import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import allone.CADTS.comm.ErrCodeTable;

public abstract class CADTSTradeFather {
	public OPFather call_trade(IPFather ip,String fromServ) {
		try {
			return doTrade(ip,fromServ);
		} catch (Exception e) {
			OPFather op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(ErrCodeTable.ERR_OTHER);
			op.setErrMessage("Unknow Err." + e.getMessage());
			e.printStackTrace();
			return op;
		}
	}

	protected abstract OPFather doTrade(IPFather _ip,String fromServ);

}
