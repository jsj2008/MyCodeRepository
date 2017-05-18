package jedi.ex01.CSTS3.comm.info;

import jedi.ex01.CSTS3.comm.struct.MoneyAccount;


public class Info_TRADESERV1003 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1003";

	public static final String accountID = "1";
	public static final String moneyAccountVec = "2";

	public Info_TRADESERV1003(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccountID() {
		try {
			long data=getEntryLong(Info_TRADESERV1003.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(Info_TRADESERV1003.accountID, accountID);
	}

	public MoneyAccount[] getMoneyAccountVec() {
		try {
			MoneyAccount[] data=getEntryObjectVec(Info_TRADESERV1003.moneyAccountVec,new MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(MoneyAccount[] moneyAccountVec) {
		setEntry(Info_TRADESERV1003.moneyAccountVec, moneyAccountVec);
	}


}