package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.PriceWarning;


public class IP_TRADESERV5106 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_TRADESERV5106";

	public static final int OPERATETYPE_DELETE = 0;
	public static final int OPERATETYPE_ADD = 1;
	public static final String operateType = "3";
	public static final String toDeletePWGUID = "4";
	public static final String toAddPW = "5";

	public IP_TRADESERV5106(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getOperateType() {
		try {
			int data=getEntryInt(IP_TRADESERV5106.operateType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOperateType(int operateType) {
		setEntry(IP_TRADESERV5106.operateType, operateType);
	}

	public String getToDeletePWGUID() {
		try {
			String data=getEntryString(IP_TRADESERV5106.toDeletePWGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToDeletePWGUID(String toDeletePWGUID) {
		setEntry(IP_TRADESERV5106.toDeletePWGUID, toDeletePWGUID);
	}

	public PriceWarning getToAddPW() {
		try {
			PriceWarning data=getEntryObject(IP_TRADESERV5106.toAddPW);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToAddPW(PriceWarning toAddPW) {
		setEntry(IP_TRADESERV5106.toAddPW, toAddPW);
	}


}