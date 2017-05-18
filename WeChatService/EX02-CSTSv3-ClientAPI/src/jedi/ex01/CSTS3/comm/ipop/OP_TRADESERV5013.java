package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.Instrument;


public class OP_TRADESERV5013 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5013";

	public static final String instrumentVec = "1";

	public OP_TRADESERV5013(){
		super();
		setEntry("jsonId", jsonId);
	}

	public Instrument[] getInstrumentVec() {
		try {
			Instrument[] data=getEntryObjectVec(OP_TRADESERV5013.instrumentVec,new Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentVec(Instrument[] instrumentVec) {
		setEntry(OP_TRADESERV5013.instrumentVec, instrumentVec);
	}


}