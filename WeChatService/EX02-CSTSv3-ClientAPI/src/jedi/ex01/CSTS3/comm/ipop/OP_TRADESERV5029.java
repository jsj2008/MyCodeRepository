package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.AccountFundDeposit;
import jedi.ex01.CSTS3.comm.struct.FundAccountShares;


public class OP_TRADESERV5029 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5029";

	public static final String accountFundDepositVec = "1";
	public static final String fundAccountSharesVec = "2";

	public OP_TRADESERV5029(){
		super();
		setEntry("jsonId", jsonId);
	}

	public AccountFundDeposit[] getAccountFundDepositVec() {
		try {
			AccountFundDeposit[] data=getEntryObjectVec(OP_TRADESERV5029.accountFundDepositVec,new AccountFundDeposit[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountFundDepositVec(AccountFundDeposit[] accountFundDepositVec) {
		setEntry(OP_TRADESERV5029.accountFundDepositVec, accountFundDepositVec);
	}

	public FundAccountShares[] getFundAccountSharesVec() {
		try {
			FundAccountShares[] data=getEntryObjectVec(OP_TRADESERV5029.fundAccountSharesVec,new FundAccountShares[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFundAccountSharesVec(FundAccountShares[] fundAccountSharesVec) {
		setEntry(OP_TRADESERV5029.fundAccountSharesVec, fundAccountSharesVec);
	}


}