package jedi.ex02.CSTS3.comm.info;

import jedi.v7.bankserver.comm.infor.client.INFO_BankServ2010;
import jedi.v7.comm.datastruct.information.InforFather;

public class C3_Info_BANKSERV2010 extends C3_InfoFather{
	public static final String jsonId = "Info_BANKSERV2010";

	public static final String message = "1";

	public C3_Info_BANKSERV2010(InforFather info) {
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(INFO_BankServ2010 data) throws Exception {
		super.parseFromSysData(data);
		setMessage(data.getMessage());
	}

	public String getMessage() {
		try {
			String data = getEntryString(C3_Info_BANKSERV2010.message);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessage(String message) {
		setEntry(C3_Info_BANKSERV2010.message, message);
	}
}
