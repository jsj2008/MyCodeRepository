package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_TTrade4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5024;


public class C3_OP_TRADESERV5024 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5024";

	public static final String trade4CFDVec = "1";

	public C3_OP_TRADESERV5024(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5024 data) throws Exception {
		super.parseFromSysData(data);
		C3_TTrade4CFD[] trade4CFDVec = new C3_TTrade4CFD[data.getTrade4CFDVec().length];
		for (int i = 0; i < data.getTrade4CFDVec().length; i++) {
			trade4CFDVec[i]=new C3_TTrade4CFD();
			trade4CFDVec[i].parseFromSysData(data.getTrade4CFDVec()[i]);
		}
		setTrade4CFDVec(trade4CFDVec);
	}


	public C3_TTrade4CFD[] getTrade4CFDVec() {
		try {
			C3_TTrade4CFD[] data=getEntryObjectVec(C3_OP_TRADESERV5024.trade4CFDVec,new C3_TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(C3_TTrade4CFD[] trade4CFDVec) {
		setEntry(C3_OP_TRADESERV5024.trade4CFDVec, trade4CFDVec);
	}


}