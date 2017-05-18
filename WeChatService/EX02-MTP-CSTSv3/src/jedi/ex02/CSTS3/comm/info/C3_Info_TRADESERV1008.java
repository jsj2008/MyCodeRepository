package jedi.ex02.CSTS3.comm.info;

import jedi.v7.trade.comm.infor.Info_TRADESERV1008;


public class C3_Info_TRADESERV1008 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1008";

	public static final int ATTR_TRANSFER_WITH_FUND = 0;
	public static final String account = "3";
	public static final String attrID = "4";

	public C3_Info_TRADESERV1008(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1008 data) throws Exception {
		super.parseFromSysData(data);
		setAccount(data.getAccount());
		setAttrID(data.getAttrID());
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1008.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_Info_TRADESERV1008.account, account);
	}

	public int getAttrID() {
		try {
			int data=getEntryInt(C3_Info_TRADESERV1008.attrID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAttrID(int attrID) {
		setEntry(C3_Info_TRADESERV1008.attrID, attrID);
	}


}