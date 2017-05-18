package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_BatchRateGap;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5015;


public class C3_OP_TRADESERV5015 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5015";

	public static final String batchRateGapVec = "1";

	public C3_OP_TRADESERV5015(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5015 data) throws Exception {
		super.parseFromSysData(data);
		C3_BatchRateGap[] batchRateGapVec = new C3_BatchRateGap[data.getBatchRateGapVec().length];
		for (int i = 0; i < data.getBatchRateGapVec().length; i++) {
			batchRateGapVec[i]=new C3_BatchRateGap();
			batchRateGapVec[i].parseFromSysData(data.getBatchRateGapVec()[i]);
		}
		setBatchRateGapVec(batchRateGapVec);
	}


	public C3_BatchRateGap[] getBatchRateGapVec() {
		try {
			C3_BatchRateGap[] data=getEntryObjectVec(C3_OP_TRADESERV5015.batchRateGapVec,new C3_BatchRateGap[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchRateGapVec(C3_BatchRateGap[] batchRateGapVec) {
		setEntry(C3_OP_TRADESERV5015.batchRateGapVec, batchRateGapVec);
	}


}