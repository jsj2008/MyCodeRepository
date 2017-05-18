package jedi.ex01.client.station.api.info;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.info.Info_TRADESERV1008;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.operator.fund.FundDocOperator;
import jedi.ex01.client.station.api.doc.operator.user.UserDocOperator;

public class InfoOperator_TRADESERV1008 extends InfoOperator {

	@Override
	public void onInfo(InfoFather _info) {
		Info_TRADESERV1008 info = (Info_TRADESERV1008) _info;

		if (info.getAttrID() == Info_TRADESERV1008.ATTR_TRANSFER_WITH_FUND) {
			infoWithFund(info.getAccount());
		}
	}

	private void infoWithFund(long account) {
		if (DataDoc.getInstance().getAccountStore().getAccountID() != account) {
			return;
		}
		UserDocOperator.getUserDocOperator().loadMoneyAccount(account);
		FundDocOperator.getFundDocOperator().loadFundAccount(account);
	}

}
