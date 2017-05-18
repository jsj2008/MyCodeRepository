package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TOrders4CFD;


public class OP_TRADESERV5104 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5104";

	public static final String order = "1";
//	public static final String info1010 = "2";

	public OP_TRADESERV5104(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TOrders4CFD getOrder() {
		try {
			TOrders4CFD data=getEntryObject(OP_TRADESERV5104.order);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder(TOrders4CFD order) {
		setEntry(OP_TRADESERV5104.order, order);
	}

//	public Info_TRADESERV1010 getInfo1010() {
//		try {
//			Info_TRADESERV1010 data=getEntryObject(OP_TRADESERV5104.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(Info_TRADESERV1010 info1010) {
//		setEntry(OP_TRADESERV5104.info1010, info1010);
//	}


}