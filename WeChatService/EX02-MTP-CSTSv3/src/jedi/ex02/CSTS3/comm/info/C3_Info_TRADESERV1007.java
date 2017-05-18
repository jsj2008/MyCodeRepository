package jedi.ex02.CSTS3.comm.info;

import jedi.v7.trade.comm.infor.Info_TRADESERV1007;


public class C3_Info_TRADESERV1007 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1007";

	public static final String userOperatorID = "1";
	public static final String uptradeOperatorID = "2";

	public C3_Info_TRADESERV1007(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1007 data) throws Exception {
		super.parseFromSysData(data);
		setUserOperatorID(data.getUserOperatorID());
		setUptradeOperatorID(data.getUptradeOperatorID());
	}


	public String getUserOperatorID() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1007.userOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserOperatorID(String userOperatorID) {
		setEntry(C3_Info_TRADESERV1007.userOperatorID, userOperatorID);
	}

	public String getUptradeOperatorID() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1007.uptradeOperatorID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUptradeOperatorID(String uptradeOperatorID) {
		setEntry(C3_Info_TRADESERV1007.uptradeOperatorID, uptradeOperatorID);
	}


}