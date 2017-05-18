package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MarginCall;
import jedi.v7.trade.comm.infor.Info_TRADESERV1013;


public class C3_Info_TRADESERV1013 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1013";

	public static final String accountID = "1";
	public static final String marginCall = "2";

	public C3_Info_TRADESERV1013(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1013 data) throws Exception {
		super.parseFromSysData(data);
		setAccountID(data.getAccountID());
		C3_MarginCall marginCall = new C3_MarginCall();
		marginCall.parseFromSysData(data.getMarginCall());
		setMarginCall(marginCall);
	}


	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1013.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1013.accountID, accountID);
	}

	public C3_MarginCall getMarginCall() {
		try {
			C3_MarginCall data=getEntryObject(C3_Info_TRADESERV1013.marginCall);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMarginCall(C3_MarginCall marginCall) {
		setEntry(C3_Info_TRADESERV1013.marginCall, marginCall);
	}


}