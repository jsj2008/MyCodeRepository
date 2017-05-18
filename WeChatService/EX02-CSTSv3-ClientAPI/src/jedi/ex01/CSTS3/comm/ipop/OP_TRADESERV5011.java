package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.SystemConfig;


public class OP_TRADESERV5011 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5011";

	public static final String systemConfig = "1";

	public OP_TRADESERV5011(){
		super();
		setEntry("jsonId", jsonId);
	}

	public SystemConfig getSystemConfig() {
		try {
			SystemConfig data=getEntryObject(OP_TRADESERV5011.systemConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSystemConfig(SystemConfig systemConfig) {
		setEntry(OP_TRADESERV5011.systemConfig, systemConfig);
	}


}