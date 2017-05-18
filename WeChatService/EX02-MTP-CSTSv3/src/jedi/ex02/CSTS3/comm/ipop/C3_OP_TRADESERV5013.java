package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5013;


public class C3_OP_TRADESERV5013 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5013";

	public static final String instrumentVec = "1";

	public C3_OP_TRADESERV5013(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5013 data) throws Exception {
		super.parseFromSysData(data);
		C3_Instrument[] instrumentVec = new C3_Instrument[data.getInstrumentVec().length];
		for (int i = 0; i < data.getInstrumentVec().length; i++) {
			instrumentVec[i]=new C3_Instrument();
			instrumentVec[i].parseFromSysData(data.getInstrumentVec()[i]);
		}
		setInstrumentVec(instrumentVec);
	}


	public C3_Instrument[] getInstrumentVec() {
		try {
			C3_Instrument[] data=getEntryObjectVec(C3_OP_TRADESERV5013.instrumentVec,new C3_Instrument[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentVec(C3_Instrument[] instrumentVec) {
		setEntry(C3_OP_TRADESERV5013.instrumentVec, instrumentVec);
	}


}