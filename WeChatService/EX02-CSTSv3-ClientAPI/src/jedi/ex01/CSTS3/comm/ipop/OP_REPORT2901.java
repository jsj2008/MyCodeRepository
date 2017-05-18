package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.ClosedPositionsDetails;


public class OP_REPORT2901 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_REPORT2901";

	public static final String closedPositionVec = "1";

	public OP_REPORT2901(){
		super();
		setEntry("jsonId", jsonId);
	}

	public ClosedPositionsDetails[] getClosedPositionVec() {
		try {
			ClosedPositionsDetails[] data=getEntryObjectVec(OP_REPORT2901.closedPositionVec,new ClosedPositionsDetails[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedPositionVec(ClosedPositionsDetails[] closedPositionVec) {
		setEntry(OP_REPORT2901.closedPositionVec, closedPositionVec);
	}


}