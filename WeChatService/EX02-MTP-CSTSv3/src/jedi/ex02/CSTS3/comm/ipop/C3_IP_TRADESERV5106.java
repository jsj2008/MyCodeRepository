package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_PriceWarning;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5106;


public class C3_IP_TRADESERV5106 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5106";

	public static final int OPERATETYPE_DELETE = 0;
	public static final int OPERATETYPE_ADD = 1;
	public static final String operateType = "3";
	public static final String toDeletePWGUID = "4";
	public static final String toAddPW = "5";

	public C3_IP_TRADESERV5106(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5106 formatIP() {
		IP_TRADESERV5106 ip=new IP_TRADESERV5106();
		ip.setOperateType(getOperateType());
		ip.setToDeletePWGUID(getToDeletePWGUID());
		ip.setToAddPW(getToAddPW().format());
		return ip;
	}

	public int getOperateType() {
		try {
			int data=getEntryInt(C3_IP_TRADESERV5106.operateType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOperateType(int operateType) {
		setEntry(C3_IP_TRADESERV5106.operateType, operateType);
	}

	public String getToDeletePWGUID() {
		try {
			String data=getEntryString(C3_IP_TRADESERV5106.toDeletePWGUID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToDeletePWGUID(String toDeletePWGUID) {
		setEntry(C3_IP_TRADESERV5106.toDeletePWGUID, toDeletePWGUID);
	}

	public C3_PriceWarning getToAddPW() {
		try {
			C3_PriceWarning data=getEntryObject(C3_IP_TRADESERV5106.toAddPW);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setToAddPW(C3_PriceWarning toAddPW) {
		setEntry(C3_IP_TRADESERV5106.toAddPW, toAddPW);
	}


}