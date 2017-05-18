package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_GroupConfig;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5017;


public class C3_OP_TRADESERV5017 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5017";

	public static final String groupConfigVec = "1";

	public C3_OP_TRADESERV5017(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5017 data) throws Exception {
		super.parseFromSysData(data);
		C3_GroupConfig[] groupConfigVec = new C3_GroupConfig[data.getGroupConfigVec().length];
		for (int i = 0; i < data.getGroupConfigVec().length; i++) {
			groupConfigVec[i]=new C3_GroupConfig();
			groupConfigVec[i].parseFromSysData(data.getGroupConfigVec()[i]);
		}
		setGroupConfigVec(groupConfigVec);
	}


	public C3_GroupConfig[] getGroupConfigVec() {
		try {
			C3_GroupConfig[] data=getEntryObjectVec(C3_OP_TRADESERV5017.groupConfigVec,new C3_GroupConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupConfigVec(C3_GroupConfig[] groupConfigVec) {
		setEntry(C3_OP_TRADESERV5017.groupConfigVec, groupConfigVec);
	}


}