package jedi.ex02.CSTS3.comm.ipop;

//import jedi.ex01.CSTS3.comm.info.C3_Info_TRADESERV1010;
import jedi.ex02.CSTS3.comm.struct.C3_TOrderHis4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5102;


public class C3_OP_TRADESERV5102 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5102";

	public static final String orderHis = "1";
//	public static final String info1010 = "2";

	public C3_OP_TRADESERV5102(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5102 data) throws Exception {
		super.parseFromSysData(data);
		C3_TOrderHis4CFD orderHis = new C3_TOrderHis4CFD();
		orderHis.parseFromSysData(data.getOrderHis());
		setOrderHis(orderHis);
//		C3_Info_TRADESERV1010 info1010 = new C3_Info_TRADESERV1010(data.getInfo1010());
//		info1010.parseFromSysData(data.getInfo1010());
//		setInfo1010(info1010);
	}


	public C3_TOrderHis4CFD getOrderHis() {
		try {
			C3_TOrderHis4CFD data=getEntryObject(C3_OP_TRADESERV5102.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(C3_TOrderHis4CFD orderHis) {
		setEntry(C3_OP_TRADESERV5102.orderHis, orderHis);
	}

//	public C3_Info_TRADESERV1010 getInfo1010() {
//		try {
//			C3_Info_TRADESERV1010 data=getEntryObject(C3_OP_TRADESERV5102.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(C3_Info_TRADESERV1010 info1010) {
//		setEntry(C3_OP_TRADESERV5102.info1010, info1010);
//	}


}