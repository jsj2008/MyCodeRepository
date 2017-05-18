package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;


public class OP_TRADESERV5025 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5025";

	public static final String orders4CFDVec = "1";

	public OP_TRADESERV5025(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TOrders4CFD[] getOrders4CFDVec() {
		try {
			TOrders4CFD[] data=getEntryObjectVec(OP_TRADESERV5025.orders4CFDVec,new TOrders4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrders4CFDVec(TOrders4CFD[] orders4CFDVec) {
		setEntry(OP_TRADESERV5025.orders4CFDVec, orders4CFDVec);
	}


}