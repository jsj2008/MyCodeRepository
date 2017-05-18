package jedi.ex02.CSTS3.comm.ipop;

//import jedi.ex01.CSTS3.comm.info.C3_Info_TRADESERV1010;
import jedi.ex02.CSTS3.comm.struct.C3_TOrderHis4CFD;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5101;


public class C3_OP_TRADESERV5101 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5101";

	public static final String strategyIDs = "1";
	public static final String mktPriceChanged = "2";
	public static final String newMKTPrice = "3";
	public static final String orderHis = "4";
//	public static final String info1010 = "5";

	public C3_OP_TRADESERV5101(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5101 data) throws Exception {
		super.parseFromSysData(data);
		setStrategyIDs(data.getStrategyIDs());
		setMktPriceChanged(data.isMktPriceChanged());
		setNewMKTPrice(data.getNewMKTPrice());
		C3_TOrderHis4CFD orderHis = new C3_TOrderHis4CFD();
		orderHis.parseFromSysData(data.getOrderHis());
		setOrderHis(orderHis);
//		C3_Info_TRADESERV1010 info1010 = new C3_Info_TRADESERV1010(data.getInfo1010());
//		info1010.parseFromSysData(data.getInfo1010());
//		setInfo1010(info1010);
	}


	public String[] getStrategyIDs() {
		try {
			String[] data=getEntryObjectVec(C3_OP_TRADESERV5101.strategyIDs,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStrategyIDs(String[] strategyIDs) {
		setEntry(C3_OP_TRADESERV5101.strategyIDs, strategyIDs);
	}

	public boolean isMktPriceChanged() {
		try {
			boolean data=getEntryBoolean(C3_OP_TRADESERV5101.mktPriceChanged);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setMktPriceChanged(boolean mktPriceChanged) {
		setEntry(C3_OP_TRADESERV5101.mktPriceChanged, mktPriceChanged);
	}

	public double getNewMKTPrice() {
		try {
			double data=getEntryDouble(C3_OP_TRADESERV5101.newMKTPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNewMKTPrice(double newMKTPrice) {
		setEntry(C3_OP_TRADESERV5101.newMKTPrice, newMKTPrice);
	}

	public C3_TOrderHis4CFD getOrderHis() {
		try {
			C3_TOrderHis4CFD data=getEntryObject(C3_OP_TRADESERV5101.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(C3_TOrderHis4CFD orderHis) {
		setEntry(C3_OP_TRADESERV5101.orderHis, orderHis);
	}

//	public C3_Info_TRADESERV1010 getInfo1010() {
//		try {
//			C3_Info_TRADESERV1010 data=getEntryObject(C3_OP_TRADESERV5101.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(C3_Info_TRADESERV1010 info1010) {
//		setEntry(C3_OP_TRADESERV5101.info1010, info1010);
//	}


}