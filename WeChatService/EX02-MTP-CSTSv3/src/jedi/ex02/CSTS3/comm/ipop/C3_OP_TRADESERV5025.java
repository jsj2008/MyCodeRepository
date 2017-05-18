package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5025;


public class C3_OP_TRADESERV5025 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5025";

	public static final String orders4CFDVec = "1";

	public C3_OP_TRADESERV5025(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5025 data) throws Exception {
		super.parseFromSysData(data);
		C3_TOrders4CFD[] orders4CFDVec = new C3_TOrders4CFD[data.getOrders4CFDVec().length];
		for (int i = 0; i < data.getOrders4CFDVec().length; i++) {
			orders4CFDVec[i]=new C3_TOrders4CFD();
			orders4CFDVec[i].parseFromSysData(data.getOrders4CFDVec()[i]);
		}
		setOrders4CFDVec(orders4CFDVec);
	}


	public C3_TOrders4CFD[] getOrders4CFDVec() {
		try {
			C3_TOrders4CFD[] data=getEntryObjectVec(C3_OP_TRADESERV5025.orders4CFDVec,new C3_TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrders4CFDVec(C3_TOrders4CFD[] orders4CFDVec) {
		setEntry(C3_OP_TRADESERV5025.orders4CFDVec, orders4CFDVec);
	}


}