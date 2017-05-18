package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.AccountFundDeposit;


public class C3_AccountFundDeposit extends allone.json.AbstractJsonData {

	public static final String jsonId = "28";

	public static final String account = "1";
	public static final String fundid = "2";
	public static final String amount = "3";

	public C3_AccountFundDeposit(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(AccountFundDeposit data) throws Exception {
		setAccount(data.getAccount());
		setFundid(data.getFundid());
		setAmount(data.getAmount());
	}

	public AccountFundDeposit format(){
		AccountFundDeposit data=new AccountFundDeposit();
		data.setAccount(getAccount());
		data.setFundid(getFundid());
		data.setAmount(getAmount());
		return data;
	}


	public long getAccount() {
		try {
			long data=getEntryLong(C3_AccountFundDeposit.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_AccountFundDeposit.account, account);
	}

	public long getFundid() {
		try {
			long data=getEntryLong(C3_AccountFundDeposit.fundid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundid(long fundid) {
		setEntry(C3_AccountFundDeposit.fundid, fundid);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(C3_AccountFundDeposit.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(C3_AccountFundDeposit.amount, amount);
	}


}