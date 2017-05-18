package jedi.ex01.CSTS3.comm.info;


public class Info_TRADESERV1008 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1008";

	public static final int ATTR_TRANSFER_WITH_FUND = 0;
	public static final String account = "3";
	public static final String attrID = "4";

	public Info_TRADESERV1008(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(Info_TRADESERV1008.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(Info_TRADESERV1008.account, account);
	}

	public int getAttrID() {
		try {
			int data=getEntryInt(Info_TRADESERV1008.attrID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAttrID(int attrID) {
		setEntry(Info_TRADESERV1008.attrID, attrID);
	}


}