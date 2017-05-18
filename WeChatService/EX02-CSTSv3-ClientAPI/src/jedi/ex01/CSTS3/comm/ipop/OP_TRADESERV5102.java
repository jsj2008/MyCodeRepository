package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD;


public class OP_TRADESERV5102 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5102";

	public static final String orderHis = "1";
//	public static final String info1010 = "2";

	public OP_TRADESERV5102(){
		super();
		setEntry("jsonId", jsonId);
	}

	public TOrderHis4CFD getOrderHis() {
		try {
			TOrderHis4CFD data=getEntryObject(OP_TRADESERV5102.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(TOrderHis4CFD orderHis) {
		setEntry(OP_TRADESERV5102.orderHis, orderHis);
	}

//	public Info_TRADESERV1010 getInfo1010() {
//		try {
//			Info_TRADESERV1010 data=getEntryObject(OP_TRADESERV5102.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(Info_TRADESERV1010 info1010) {
//		setEntry(OP_TRADESERV5102.info1010, info1010);
//	}


}