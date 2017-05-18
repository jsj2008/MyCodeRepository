package jedi.ex01.CSTS3.comm.struct;


public class AccountFundDeposit extends allone.json.AbstractJsonData {

	public static final String jsonId = "28";

	public static final String account = "1";
	public static final String fundid = "2";
	public static final String amount = "3";

	public AccountFundDeposit(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(AccountFundDeposit.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(AccountFundDeposit.account, account);
	}

	public long getFundid() {
		try {
			long data=getEntryLong(AccountFundDeposit.fundid);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFundid(long fundid) {
		setEntry(AccountFundDeposit.fundid, fundid);
	}

	public double getAmount() {
		try {
			double data=getEntryDouble(AccountFundDeposit.amount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAmount(double amount) {
		setEntry(AccountFundDeposit.amount, amount);
	}


}