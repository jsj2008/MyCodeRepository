package jedi.ex02.CSTS3.comm.info;

import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccount;
import jedi.v7.trade.comm.infor.Info_TRADESERV1003;


public class C3_Info_TRADESERV1003 extends jedi.ex02.CSTS3.comm.info.C3_InfoFather {

	public static final String jsonId = "Info_TRADESERV1003";

	public static final String accountID = "1";
	public static final String moneyAccountVec = "2";

	public C3_Info_TRADESERV1003(jedi.v7.trade.comm.infor.TradeServInfoFather info){
		super(info);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(Info_TRADESERV1003 data) throws Exception {
		super.parseFromSysData(data);
		setAccountID(data.getAccountID());
		C3_MoneyAccount[] moneyAccountVec = new C3_MoneyAccount[data.getMoneyAccountVec().length];
		for (int i = 0; i < data.getMoneyAccountVec().length; i++) {
			moneyAccountVec[i]=new C3_MoneyAccount();
			moneyAccountVec[i].parseFromSysData(data.getMoneyAccountVec()[i]);
		}
		setMoneyAccountVec(moneyAccountVec);
	}


	public long getAccountID() {
		try {
			long data=getEntryLong(C3_Info_TRADESERV1003.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_Info_TRADESERV1003.accountID, accountID);
	}

	public C3_MoneyAccount[] getMoneyAccountVec() {
		try {
			C3_MoneyAccount[] data=getEntryObjectVec(C3_Info_TRADESERV1003.moneyAccountVec,new C3_MoneyAccount[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMoneyAccountVec(C3_MoneyAccount[] moneyAccountVec) {
		setEntry(C3_Info_TRADESERV1003.moneyAccountVec, moneyAccountVec);
	}


}