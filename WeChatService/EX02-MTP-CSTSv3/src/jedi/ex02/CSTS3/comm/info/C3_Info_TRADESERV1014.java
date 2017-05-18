package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MessageToAccount;
import jedi.v7.trade.comm.infor.Info_TRADESERV1014;


public class C3_Info_TRADESERV1014 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1014";

	public static final String message = "1";

	public C3_Info_TRADESERV1014(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1014 data) throws Exception {
		super.parseFromSysData(data);
		C3_MessageToAccount message = new C3_MessageToAccount();
		message.parseFromSysData(data.getMessage());
		setMessage(message);
	}


	public C3_MessageToAccount getMessage() {
		try {
			C3_MessageToAccount data=getEntryObject(C3_Info_TRADESERV1014.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(C3_MessageToAccount message) {
		setEntry(C3_Info_TRADESERV1014.message, message);
	}


}