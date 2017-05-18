package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.InstrumentType;


public class OP_TRADESERV5012 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5012";

	public static final String instrumentTypeVec = "1";

	public OP_TRADESERV5012(){
		super();
		setEntry("jsonId", jsonId);
	}

	public InstrumentType[] getInstrumentTypeVec() {
		try {
			InstrumentType[] data=getEntryObjectVec(OP_TRADESERV5012.instrumentTypeVec,new InstrumentType[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypeVec(InstrumentType[] instrumentTypeVec) {
		setEntry(OP_TRADESERV5012.instrumentTypeVec, instrumentTypeVec);
	}


}