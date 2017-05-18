package jedi.ex02.CSTS3.comm.info;

import jedi.v7.trade.comm.infor.Info_TRADESERV1005;


public class C3_Info_TRADESERV1005 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1005";

	public static final int ATTRID_USERLOGIN = 0;
	public static final int ATTRID_ACCOUNTSTRATEGY = 1;
	public static final int ATTRID_INSTRUMENTCFG4GROUP = 2;
	public static final int ATTRID_INSTRUMENTCFG4ACCOUNT = 3;
	public static final int ATTRID_ACCOUNT_DELETE = 4;
	public static final int ATTRID_USER_DELETED = 5;
	public static final int ATTRID_USER_RELOAD = 6;
	public static final String changedAttrID = "9";
	public static final String groupName = "10";
	public static final String accountID = "11";
	public static final String instrumentName = "12";

	public C3_Info_TRADESERV1005(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1005 data) throws Exception {
		super.parseFromSysData(data);
		setChangedAttrID(data.getChangedAttrID());
		setGroupName(data.getGroupName());
		setAccountID(data.getAccountID());
		setInstrumentName(data.getInstrumentName());
	}


	public int getChangedAttrID() {
		try {
			int data=getEntryInt(C3_Info_TRADESERV1005.changedAttrID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setChangedAttrID(int changedAttrID) {
		setEntry(C3_Info_TRADESERV1005.changedAttrID, changedAttrID);
	}

	public String getGroupName() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1005.groupName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupName(String groupName) {
		setEntry(C3_Info_TRADESERV1005.groupName, groupName);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1005.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1005.accountID, accountID);
	}

	public String getInstrumentName() {
		try {
			String data=getEntryString(C3_Info_TRADESERV1005.instrumentName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentName(String instrumentName) {
		setEntry(C3_Info_TRADESERV1005.instrumentName, instrumentName);
	}


}