package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_TikValue;
import jedi.v7.quoteDB.comm.IPOP.OP_QDB1004;


public class C3_OP_QDB1004 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_QDB1004";

	public static final String list = "1";

	public C3_OP_QDB1004(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_QDB1004 data) throws Exception {
		super.parseFromSysData(data);
		C3_TikValue[] list = new C3_TikValue[data.getList().size()];
		for (int i = 0; i < data.getList().size(); i++) {
			list[i]=new C3_TikValue();
			list[i].parseFromSysData(data.getList().get(i));
		}
		setList(list);
	}


	public C3_TikValue[] getList() {
		try {
			C3_TikValue[] data=getEntryObjectVec(C3_OP_QDB1004.list,new C3_TikValue[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setList(C3_TikValue[] list) {
		setEntry(C3_OP_QDB1004.list, list);
	}


}