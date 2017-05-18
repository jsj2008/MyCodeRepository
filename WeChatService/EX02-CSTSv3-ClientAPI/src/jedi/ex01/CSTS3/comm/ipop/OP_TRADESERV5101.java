package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.TOrderHis4CFD;


public class OP_TRADESERV5101 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5101";

	public static final String strategyIDs = "1";
	public static final String mktPriceChanged = "2";
	public static final String newMKTPrice = "3";
	public static final String orderHis = "4";
//	public static final String info1010 = "5";

	public OP_TRADESERV5101(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String[] getStrategyIDs() {
		try {
			String[] data=getEntryObjectVec(OP_TRADESERV5101.strategyIDs,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setStrategyIDs(String[] strategyIDs) {
		setEntry(OP_TRADESERV5101.strategyIDs, strategyIDs);
	}

	public boolean isMktPriceChanged() {
		try {
			boolean data=getEntryBoolean(OP_TRADESERV5101.mktPriceChanged);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setMktPriceChanged(boolean mktPriceChanged) {
		setEntry(OP_TRADESERV5101.mktPriceChanged, mktPriceChanged);
	}

	public double getNewMKTPrice() {
		try {
			double data=getEntryDouble(OP_TRADESERV5101.newMKTPrice);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setNewMKTPrice(double newMKTPrice) {
		setEntry(OP_TRADESERV5101.newMKTPrice, newMKTPrice);
	}

	public TOrderHis4CFD getOrderHis() {
		try {
			TOrderHis4CFD data=getEntryObject(OP_TRADESERV5101.orderHis);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrderHis(TOrderHis4CFD orderHis) {
		setEntry(OP_TRADESERV5101.orderHis, orderHis);
	}

//	public Info_TRADESERV1010 getInfo1010() {
//		try {
//			Info_TRADESERV1010 data=getEntryObject(OP_TRADESERV5101.info1010);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInfo1010(Info_TRADESERV1010 info1010) {
//		setEntry(OP_TRADESERV5101.info1010, info1010);
//	}


}