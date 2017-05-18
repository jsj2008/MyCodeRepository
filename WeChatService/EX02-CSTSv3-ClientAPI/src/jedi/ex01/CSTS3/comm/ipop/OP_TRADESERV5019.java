package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.AccountStrategy;


public class OP_TRADESERV5019 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5019";

	public static final String accountStrategy = "1";

	public OP_TRADESERV5019(){
		super();
		setEntry("jsonId", jsonId);
	}

	public AccountStrategy getAccountStrategy() {
		try {
			AccountStrategy data=getEntryObject(OP_TRADESERV5019.accountStrategy);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStrategy(AccountStrategy accountStrategy) {
		setEntry(OP_TRADESERV5019.accountStrategy, accountStrategy);
	}


}