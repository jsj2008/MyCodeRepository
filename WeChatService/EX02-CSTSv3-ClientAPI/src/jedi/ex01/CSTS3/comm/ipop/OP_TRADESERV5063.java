package jedi.ex01.CSTS3.comm.ipop;

import java.util.HashMap;

public class OP_TRADESERV5063 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5063";

	public static final String map = "1";

	public OP_TRADESERV5063(){
		super();
		setEntry("jsonId", jsonId);
	}

	@SuppressWarnings("unchecked")
	public HashMap getMap() {
		try {
			HashMap data=getEntryObject(OP_TRADESERV5063.map);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setMap(HashMap map) {
		setEntry(OP_TRADESERV5063.map, map);
	}


}