package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MessageToAccount;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.comm.datastruct.DB.MessageToAccount;
import jedi.v7.trade.comm.infor.Info_TRADESERV0005;

public class C3_Info_TRADESERV0005 extends
		jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV0005";

	public static final String message = "1";

	public C3_Info_TRADESERV0005(
			jedi.v7.trade.comm.infor.TradeServInfoFather info) {
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV0005 data) throws Exception {
		super.parseFromSysData(data);
		C3_MessageToAccount message = new C3_MessageToAccount();
		MessageToAccount msg = data.getMessage();
		msg.setIsRead(MTP4CommDataInterface.FALSE);
		message.parseFromSysData(msg);
		setMessage(message);
	}

	public C3_MessageToAccount getMessage() {
		try {
			C3_MessageToAccount data = getEntryObject(C3_Info_TRADESERV0005.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(C3_MessageToAccount message) {
		setEntry(C3_Info_TRADESERV0005.message, message);
	}
}