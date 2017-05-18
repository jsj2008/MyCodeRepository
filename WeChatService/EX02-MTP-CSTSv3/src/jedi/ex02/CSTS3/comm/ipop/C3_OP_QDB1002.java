package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_HistoricData;
import jedi.v7.quote.common.HistoricData;
import jedi.v7.quoteDB.comm.IPOP.OP_QDB1002;


public class C3_OP_QDB1002 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_QDB1002";

	public static final String list = "1";

	public C3_OP_QDB1002(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_QDB1002 data) throws Exception {
		super.parseFromSysData(data);
		C3_HistoricData[] list = new C3_HistoricData[data.getList().size()];
		for (int i = 0; i < data.getList().size(); i++) {
			list[i]=new C3_HistoricData();
			list[i].parseFromSysData((HistoricData) data.getList().get(i));
		}
		setList(list);
	}


	public C3_HistoricData[] getList() {
		try {
			C3_HistoricData[] data=getEntryObjectVec(C3_OP_QDB1002.list,new C3_HistoricData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setList(C3_HistoricData[] list) {
		setEntry(C3_OP_QDB1002.list, list);
	}


}