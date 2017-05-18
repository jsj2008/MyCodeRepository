package jedi.ex02.CSTS3.comm.info;

import jedi.v7.trade.comm.infor.Info_TRADESERV1016;


public class C3_Info_TRADESERV1016 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1016";

	public static final String timedoutInstruments = "1";
	public static final String closedInstruments = "2";

	public C3_Info_TRADESERV1016(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1016 data) throws Exception {
		super.parseFromSysData(data);
		setTimedoutInstruments(data.getTimedoutInstruments());
		setClosedInstruments(data.getClosedInstruments());
	}


	public String[] getTimedoutInstruments() {
		try {
			String[] data=getEntryObjectVec(C3_Info_TRADESERV1016.timedoutInstruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTimedoutInstruments(String[] timedoutInstruments) {
		setEntry(C3_Info_TRADESERV1016.timedoutInstruments, timedoutInstruments);
	}

	public String[] getClosedInstruments() {
		try {
			String[] data=getEntryObjectVec(C3_Info_TRADESERV1016.closedInstruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedInstruments(String[] closedInstruments) {
		setEntry(C3_Info_TRADESERV1016.closedInstruments, closedInstruments);
	}


}