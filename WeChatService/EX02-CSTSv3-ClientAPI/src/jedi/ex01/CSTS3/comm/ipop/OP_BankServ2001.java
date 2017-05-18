package jedi.ex01.CSTS3.comm.ipop;

import java.util.Map;

import jedi.ex01.client.station.api.bankserver.BankServClientOPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;

//银行出入金相关,2016年8月16日14:10:33
public class OP_BankServ2001 extends BankServClientOPFather {

	public static final String jsonId = "OP_BankServ2001";

	public static final String streamID = "1";
	public static final String bankInfo = "2";

	// private long streamID;
	// private Map<String, String> bankInfo;

	public OP_BankServ2001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public long getStreamID() {
		try {
			long data = getEntryLong(OP_BankServ2001.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(OP_BankServ2001.streamID, streamID);
	}

	public Map<String, String> getBankInfo() {
		try {
			Map<String, String> data = getEntryObject(OP_BankServ2001.bankInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankInfo(Map<String, String> bankInfo) {
		setEntry(OP_BankServ2001.bankInfo, bankInfo);
	}

}