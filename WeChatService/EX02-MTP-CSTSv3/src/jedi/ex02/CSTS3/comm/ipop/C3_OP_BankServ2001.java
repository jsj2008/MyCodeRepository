package jedi.ex02.CSTS3.comm.ipop;

import java.util.Map;

import jedi.v7.bankserver.comm.ipop.client.OP_BankServ2001;

//出入金相关
public class C3_OP_BankServ2001 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ2001";

	public static final String streamID = "1";
	public static final String bankInfo = "2";

	public C3_OP_BankServ2001(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ2001 data) throws Exception {
		super.parseFromSysData(data);

		setStreamID(data.getStreamID());
		setBankInfo(data.getBankInfo());

	}

	public long getStreamID() {
		try {
			long data = getEntryLong(C3_OP_BankServ2001.streamID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		setEntry(C3_OP_BankServ2001.streamID, streamID);
	}

	public Map<String, String> getBankInfo() {
		try {
			Map<String, String> data = getEntryObject(C3_OP_BankServ2001.bankInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankInfo(Map<String, String> bankInfo) {
		setEntry(C3_OP_BankServ2001.bankInfo, bankInfo);
	}

}