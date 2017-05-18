package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.OP_BankServ2012;

/**
 * 出入金相关,2016年8月9日16:48:07
 * 
 * @author ALLONE
 * 
 */
public class C3_OP_BankServ2012 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ2012";

	public C3_OP_BankServ2012(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ2012 data) throws Exception {
		super.parseFromSysData(data);

	}

}