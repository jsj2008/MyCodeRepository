package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_TOrders4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5103;


public class C3_OP_TRADESERV5103 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5103";

	public static final String order = "1";
//	public static final String info1010 = "2";

	public C3_OP_TRADESERV5103(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5103 data) throws Exception {
		super.parseFromSysData(data);
		C3_TOrders4CFD order = new C3_TOrders4CFD();
		order.parseFromSysData(data.getOrder());
		setOrder(order);
//		C3_Info_TRADESERV1010 info1010 = new C3_Info_TRADESERV1010(data.getInfo1010());
//		info1010.parseFromSysData(data.getInfo1010());
//		setInfo1010(info1010);
	}


	public C3_TOrders4CFD getOrder() {
		try {
			C3_TOrders4CFD data=getEntryObject(C3_OP_TRADESERV5103.order);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrder(C3_TOrders4CFD order) {
		setEntry(C3_OP_TRADESERV5103.order, order);
	}

//	public C3_Info_TRADESERV1010 getInfo1010() {
//		try {
//			C3_Info_TRADESERV1010 data=getEntryObject(C3_OP_TRADESERV5103.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(C3_Info_TRADESERV1010 info1010) {
//		setEntry(C3_OP_TRADESERV5103.info1010, info1010);
//	}


}