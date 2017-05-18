package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TTrade4CFD;


public class OP_TRADESERV5024 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5024";

	public static final String trade4CFDVec = "1";

	public OP_TRADESERV5024(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TTrade4CFD[] getTrade4CFDVec() {
		try {
			TTrade4CFD[] data=getEntryObjectVec(OP_TRADESERV5024.trade4CFDVec,new TTrade4CFD[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTrade4CFDVec(TTrade4CFD[] trade4CFDVec) {
		setEntry(OP_TRADESERV5024.trade4CFDVec, trade4CFDVec);
	}


}