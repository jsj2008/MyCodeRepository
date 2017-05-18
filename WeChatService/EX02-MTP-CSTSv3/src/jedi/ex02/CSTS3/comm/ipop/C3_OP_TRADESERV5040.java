package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_AccountStrategy;
import jedi.ex02.CSTS3.comm.struct.C3_GroupConfig;
import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.ex02.CSTS3.comm.struct.C3_UserLogin;
import jedi.v7.comm.datastruct.DB.InstrumentsAccountCfg;
import jedi.v7.comm.datastruct.DB.InstrumentsGroupCfg;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5040;


public class C3_OP_TRADESERV5040 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5040";

	public static final String groupConfig = "1";
	public static final String userLogin = "2";
	public static final String accountStrategy = "3";
	public static final String instrumentVec = "4";
	
	public static final String instrumentGroupCfgVec = "5";
	public static final String instrumentAccountCfgVec = "6";
	

	public C3_OP_TRADESERV5040(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5040 data) throws Exception {
		super.parseFromSysData(data);
		C3_UserLogin userLogin = new C3_UserLogin();
		userLogin.parseFromSysData(data.getUserLogin());
		setUserLogin(userLogin);
	}


	public C3_GroupConfig getGroupConfig() {
		try {
			C3_GroupConfig data=getEntryObject(C3_OP_TRADESERV5040.groupConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupConfig(C3_GroupConfig groupConfig) {
		setEntry(C3_OP_TRADESERV5040.groupConfig, groupConfig);
	}

	public C3_UserLogin getUserLogin() {
		try {
			C3_UserLogin data=getEntryObject(C3_OP_TRADESERV5040.userLogin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserLogin(C3_UserLogin userLogin) {
		setEntry(C3_OP_TRADESERV5040.userLogin, userLogin);
	}

	public C3_AccountStrategy getAccountStrategy() {
		try {
			C3_AccountStrategy data=getEntryObject(C3_OP_TRADESERV5040.accountStrategy);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountStrategy(C3_AccountStrategy accountStrategy) {
		setEntry(C3_OP_TRADESERV5040.accountStrategy, accountStrategy);
	}

	public C3_Instrument[] getInstrumentVec() {
		try {
			C3_Instrument[] data=getEntryObjectVec(C3_OP_TRADESERV5040.instrumentVec,new C3_Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentVec(C3_Instrument[] instrumentVec) {
		setEntry(C3_OP_TRADESERV5040.instrumentVec, instrumentVec);
	}
	
	public InstrumentsGroupCfg[] getInstrumentGroupCfgVec() {
		try {
			InstrumentsGroupCfg[] data=getEntryObjectVec(C3_OP_TRADESERV5040.instrumentGroupCfgVec,new InstrumentsGroupCfg[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentGroupCfgVec(InstrumentsGroupCfg[] instrumentGroupCfgVec) {
		setEntry(C3_OP_TRADESERV5040.instrumentGroupCfgVec, instrumentGroupCfgVec);
	}
	
	public InstrumentsAccountCfg[] getInstrumentAccountCfgVec() {
		try {
			InstrumentsAccountCfg[] data=getEntryObjectVec(C3_OP_TRADESERV5040.instrumentAccountCfgVec,new InstrumentsAccountCfg[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentAccountCfgVec(InstrumentsAccountCfg[] instrumentAccountCfgVec) {
		setEntry(C3_OP_TRADESERV5040.instrumentAccountCfgVec, instrumentAccountCfgVec);
	}


}