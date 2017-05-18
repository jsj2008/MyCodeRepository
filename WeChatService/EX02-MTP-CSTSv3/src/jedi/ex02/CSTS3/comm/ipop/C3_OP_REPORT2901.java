package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_ClosedPositionsDetails;


public class C3_OP_REPORT2901 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_REPORT2901";

	public static final String closedPositionVec = "1";

	public C3_OP_REPORT2901(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public C3_ClosedPositionsDetails[] getClosedPositionVec() {
		try {
			C3_ClosedPositionsDetails[] data=getEntryObjectVec(C3_OP_REPORT2901.closedPositionVec,new C3_ClosedPositionsDetails[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedPositionVec(C3_ClosedPositionsDetails[] closedPositionVec) {
		setEntry(C3_OP_REPORT2901.closedPositionVec, closedPositionVec);
	}


}