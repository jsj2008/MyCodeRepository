package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_InstrumentType;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5012;


public class C3_OP_TRADESERV5012 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5012";

	public static final String instrumentTypeVec = "1";

	public C3_OP_TRADESERV5012(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5012 data) throws Exception {
		super.parseFromSysData(data);
		C3_InstrumentType[] instrumentTypeVec = new C3_InstrumentType[data.getInstrumentTypeVec().length];
		for (int i = 0; i < data.getInstrumentTypeVec().length; i++) {
			instrumentTypeVec[i]=new C3_InstrumentType();
			instrumentTypeVec[i].parseFromSysData(data.getInstrumentTypeVec()[i]);
		}
		setInstrumentTypeVec(instrumentTypeVec);
	}


	public C3_InstrumentType[] getInstrumentTypeVec() {
		try {
			C3_InstrumentType[] data=getEntryObjectVec(C3_OP_TRADESERV5012.instrumentTypeVec,new C3_InstrumentType[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentTypeVec(C3_InstrumentType[] instrumentTypeVec) {
		setEntry(C3_OP_TRADESERV5012.instrumentTypeVec, instrumentTypeVec);
	}


}