package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_AccountStrategy;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5019;


public class C3_OP_TRADESERV5019 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5019";

	public static final String accountStrategy = "1";

	public C3_OP_TRADESERV5019(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5019 data) throws Exception {
		super.parseFromSysData(data);
		C3_AccountStrategy accountStrategy = new C3_AccountStrategy();
		accountStrategy.parseFromSysData(data.getAccountStrategy());
		setAccountStrategy(accountStrategy);
	}


	public C3_AccountStrategy getAccountStrategy() {
		try {
			C3_AccountStrategy data=getEntryObject(C3_OP_TRADESERV5019.accountStrategy);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStrategy(C3_AccountStrategy accountStrategy) {
		setEntry(C3_OP_TRADESERV5019.accountStrategy, accountStrategy);
	}


}