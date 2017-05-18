package jedi.ex02.CSTS3.comm.ipop;

import java.util.HashMap;

import jedi.v7.trade.comm.IPOP.OP_TRADESERV5063;

public class C3_OP_TRADESERV5063 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5063";

	public static final String map = "1";

	public C3_OP_TRADESERV5063(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5063 data) throws Exception {
		super.parseFromSysData(data);
		setMap(data.getMap());
	}


	@SuppressWarnings("unchecked")
	public HashMap getMap() {
		try {
			HashMap data=getEntryObject(C3_OP_TRADESERV5063.map);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setMap(HashMap map) {
		setEntry(C3_OP_TRADESERV5063.map, map);
	}


}