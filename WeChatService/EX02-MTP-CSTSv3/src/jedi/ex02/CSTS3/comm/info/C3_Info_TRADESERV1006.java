package jedi.ex02.CSTS3.comm.info;

import jedi.v7.trade.comm.infor.Info_TRADESERV1006;


public class C3_Info_TRADESERV1006 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1006";

	public static final String closeState = "1";
	public static final String tradeDay = "2";

	public C3_Info_TRADESERV1006(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1006 data) throws Exception {
		super.parseFromSysData(data);
		setCloseState(data.getCloseState());
		setTradeDay(data.getTradeDay());
	}


	public int getCloseState() {
		try {
			int data=getEntryInt(C3_Info_TRADESERV1006.closeState);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseState(int closeState) {
		setEntry(C3_Info_TRADESERV1006.closeState, closeState);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1006.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_Info_TRADESERV1006.tradeDay, tradeDay);
	}


}