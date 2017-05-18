package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.BatchRateGap;


public class OP_TRADESERV5015 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5015";

	public static final String batchRateGapVec = "1";

	public OP_TRADESERV5015(){
		super();
		setEntry("jsonId", jsonId);
	}

	public BatchRateGap[] getBatchRateGapVec() {
		try {
			BatchRateGap[] data=getEntryObjectVec(OP_TRADESERV5015.batchRateGapVec,new BatchRateGap[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchRateGapVec(BatchRateGap[] batchRateGapVec) {
		setEntry(OP_TRADESERV5015.batchRateGapVec, batchRateGapVec);
	}


}