package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.client.station.api.bankserver.BankServClientOPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;

public class OP_BankServ2011 extends BankServClientOPFather {

	public static final String jsonId = "OP_BankServ2011";

	public OP_BankServ2011() {
		super();
		setEntry("jsonId", jsonId);
	}

}