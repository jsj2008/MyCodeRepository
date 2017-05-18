package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TikValue;


public class OP_QDB1004 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_QDB1004";

	public static final String list = "1";

	public OP_QDB1004(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TikValue[] getList() {
		try {
			TikValue[] data=getEntryObjectVec(OP_QDB1004.list,new TikValue[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setList(TikValue[] list) {
		setEntry(OP_QDB1004.list, list);
	}


}