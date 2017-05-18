package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.AccountStrategy;
import jedi.ex01.CSTS3.comm.struct.GroupConfig;
import jedi.ex01.CSTS3.comm.struct.Instrument;
import jedi.ex01.CSTS3.comm.struct.UserLogin;


public class OP_TRADESERV5040 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5040";

	public static final String groupConfig = "1";
	public static final String userLogin = "2";
	public static final String accountStrategy = "3";
	public static final String instrumentVec = "4";
	
//	public static final String instrumentGroupCfgVec = "5";
//	public static final String instrumentAccountCfgVec = "6";

	public OP_TRADESERV5040(){
		super();
		setEntry("jsonId", jsonId);
	}

	public GroupConfig getGroupConfig() {
		try {
			GroupConfig data=getEntryObject(OP_TRADESERV5040.groupConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupConfig(GroupConfig groupConfig) {
		setEntry(OP_TRADESERV5040.groupConfig, groupConfig);
	}

	public UserLogin getUserLogin() {
		try {
			UserLogin data=getEntryObject(OP_TRADESERV5040.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(UserLogin userLogin) {
		setEntry(OP_TRADESERV5040.userLogin, userLogin);
	}

	public AccountStrategy getAccountStrategy() {
		try {
			AccountStrategy data=getEntryObject(OP_TRADESERV5040.accountStrategy);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStrategy(AccountStrategy accountStrategy) {
		setEntry(OP_TRADESERV5040.accountStrategy, accountStrategy);
	}

	public Instrument[] getInstrumentVec() {
		try {
			Instrument[] data=getEntryObjectVec(OP_TRADESERV5040.instrumentVec,new Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentVec(Instrument[] instrumentVec) {
		setEntry(OP_TRADESERV5040.instrumentVec, instrumentVec);
	}
}