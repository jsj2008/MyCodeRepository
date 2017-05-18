package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_SystemConfig;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5011;


public class C3_OP_TRADESERV5011 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5011";

	public static final String systemConfig = "1";

	public C3_OP_TRADESERV5011(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5011 data) throws Exception {
		super.parseFromSysData(data);
		C3_SystemConfig systemConfig = new C3_SystemConfig();
		systemConfig.parseFromSysData(data.getSystemConfig());
		setSystemConfig(systemConfig);
	}


	public C3_SystemConfig getSystemConfig() {
		try {
			C3_SystemConfig data=getEntryObject(C3_OP_TRADESERV5011.systemConfig);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSystemConfig(C3_SystemConfig systemConfig) {
		setEntry(C3_OP_TRADESERV5011.systemConfig, systemConfig);
	}


}