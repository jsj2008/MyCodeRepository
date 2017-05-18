package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.HistoricData;


public class OP_QDB1003 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_QDB1003";

	public static final String list = "1";

	public OP_QDB1003(){
		super();
		setEntry("jsonId", jsonId);
	}

	public HistoricData[] getList() {
		try {
			HistoricData[] data=getEntryObjectVec(OP_QDB1003.list,new HistoricData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setList(HistoricData[] list) {
		setEntry(OP_QDB1003.list, list);
	}


}