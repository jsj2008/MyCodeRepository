package jedi.ex02.CSTS3.server.trade4client;

import jedi.ex02.CSTS3.comm.ipop.C3_Banker_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_Banker_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import allone.CADTS.comm.ErrCodeTable;

/**
 * 新建,银行出入金相关,2016年8月10日15:28:11
 * 
 * @author ALLONE
 * 
 */
public abstract class ClientBankTradeFather {

	public C3_Banker_OPFather call_trade(C3_Banker_IPFather ip, String aeid,
			String ipaddress) {
		try {
			return doTrade(ip, aeid, ipaddress);
		} catch (Exception e) {
			C3_Banker_OPFather op = new C3_Banker_OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(ErrCodeTable.ERR_OTHER);
			op.setErrMessage("Unknow Err." + e.getMessage());
			e.printStackTrace();
			return op;
		}
	}

	protected abstract C3_Banker_OPFather doTrade(C3_Banker_IPFather _ip,
			String aeid, String ipaddress);

}
