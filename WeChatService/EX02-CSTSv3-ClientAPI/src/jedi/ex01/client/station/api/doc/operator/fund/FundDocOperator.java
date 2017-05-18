package jedi.ex01.client.station.api.doc.operator.fund;

import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5029;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;


public class FundDocOperator {

	private static FundDocOperator fundDocOperator = new FundDocOperator();

	private FundDocOperator() {
	}
	
	public static FundDocOperator getFundDocOperator() {
		return fundDocOperator;
	}
	
	public boolean loadFundAccount(long account){
		IP_TRADESERV5029 ip = new IP_TRADESERV5029();
		ip.setAccountID(account);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
//		OP_TRADESERV5029 op = (OP_TRADESERV5029) opfather;
//		APIDocCaptain.resetAccountFundDeposit(account, op.getAccountFundDepositVec());
//		APIDocCaptain.resetFundAccountShares(account, op.getFundAccountSharesVec());
//		ListenerCaptain.getApiDataChangeListener().onAccountFundDepositChanged(account);
		return true;
	}
	
}
