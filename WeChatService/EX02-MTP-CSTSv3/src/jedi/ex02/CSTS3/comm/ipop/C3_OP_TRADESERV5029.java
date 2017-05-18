package jedi.ex02.CSTS3.comm.ipop;

import jedi.ex02.CSTS3.comm.struct.C3_AccountFundDeposit;
import jedi.ex02.CSTS3.comm.struct.C3_FundAccountShares;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5029;


public class C3_OP_TRADESERV5029 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5029";

	public static final String accountFundDepositVec = "1";
	public static final String fundAccountSharesVec = "2";

	public C3_OP_TRADESERV5029(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5029 data) throws Exception {
		super.parseFromSysData(data);
		C3_AccountFundDeposit[] accountFundDepositVec = new C3_AccountFundDeposit[data.getAccountFundDepositVec().length];
		for (int i = 0; i < data.getAccountFundDepositVec().length; i++) {
			accountFundDepositVec[i]=new C3_AccountFundDeposit();
			accountFundDepositVec[i].parseFromSysData(data.getAccountFundDepositVec()[i]);
		}
		setAccountFundDepositVec(accountFundDepositVec);
		C3_FundAccountShares[] fundAccountSharesVec = new C3_FundAccountShares[data.getFundAccountSharesVec().length];
		for (int i = 0; i < data.getFundAccountSharesVec().length; i++) {
			fundAccountSharesVec[i]=new C3_FundAccountShares();
			fundAccountSharesVec[i].parseFromSysData(data.getFundAccountSharesVec()[i]);
		}
		setFundAccountSharesVec(fundAccountSharesVec);
	}


	public C3_AccountFundDeposit[] getAccountFundDepositVec() {
		try {
			C3_AccountFundDeposit[] data=getEntryObjectVec(C3_OP_TRADESERV5029.accountFundDepositVec,new C3_AccountFundDeposit[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountFundDepositVec(C3_AccountFundDeposit[] accountFundDepositVec) {
		setEntry(C3_OP_TRADESERV5029.accountFundDepositVec, accountFundDepositVec);
	}

	public C3_FundAccountShares[] getFundAccountSharesVec() {
		try {
			C3_FundAccountShares[] data=getEntryObjectVec(C3_OP_TRADESERV5029.fundAccountSharesVec,new C3_FundAccountShares[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFundAccountSharesVec(C3_FundAccountShares[] fundAccountSharesVec) {
		setEntry(C3_OP_TRADESERV5029.fundAccountSharesVec, fundAccountSharesVec);
	}


}