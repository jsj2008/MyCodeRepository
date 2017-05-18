package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.client.station.api.bankserver.BankServClientOPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;

/**
 * 银行出入金相关
 * 
 * @author ALLONE
 * 
 */
public class OP_BankServ2012 extends BankServClientOPFather {
	public static final String jsonId = "OP_BankServ2012";

	public OP_BankServ2012() {
		super();
		setEntry("jsonId", jsonId);
	}

}