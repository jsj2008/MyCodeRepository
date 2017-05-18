package jedi.ex02.CSTS3.comm.ipop;

import java.util.Map;

import jedi.v7.bankserver.comm.ipop.client.OP_BankServ2011;

//出入金相关
public class C3_OP_BankServ2011 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_BankServ2011";
	
	public static final String otherInfo = "1";

	public C3_OP_BankServ2011(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_BankServ2011 data) throws Exception {
		super.parseFromSysData(data);
		this.setOtherInfo(data.getOtherInfo());
	}
	
	public Map<String, String> getOtherInfo() {
		try {
			Map<String, String> data = getEntryObject(C3_OP_BankServ2011.otherInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOtherInfo(Map<String, String> otherInfo) {
		setEntry(C3_OP_BankServ2011.otherInfo, otherInfo);
	}

}