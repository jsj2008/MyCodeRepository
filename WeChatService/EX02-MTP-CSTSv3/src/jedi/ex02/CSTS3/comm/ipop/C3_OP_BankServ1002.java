package jedi.ex02.CSTS3.comm.ipop;

import java.util.Map;

import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfile;
import jedi.ex02.CSTS3.comm.struct.C3_UserBankProfileStream;
import jedi.v7.bankserver.comm.ipop.client.OP_BankServ1002;

public class C3_OP_BankServ1002 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ1002";

	public static final String streamID = "1";
	public static final String bankInfo = "2";

	public C3_OP_BankServ1002(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ1002 data) throws Exception {
		super.parseFromSysData(data);
		setStreamID(data.getStreamID());
		setBankInfo(data.getBankInfo());
	}

	public long getStreamID() {
		try {
			return getEntryLong(C3_OP_BankServ1002.streamID);
		} catch (Exception e) {
			return 0;
		}
	}

	public void setStreamID(long streamID) {
		this.setEntry(C3_OP_BankServ1002.streamID, streamID);
	}

	public Map<String, String> getBankInfo() {
		try {
			Map<String, String> data = getEntryObject(C3_OP_BankServ1002.bankInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankInfo(Map<String, String> bankInfo) {
		setEntry(C3_OP_BankServ1002.bankInfo, bankInfo);
	}

}