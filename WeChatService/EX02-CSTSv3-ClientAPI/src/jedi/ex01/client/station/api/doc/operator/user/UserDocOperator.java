package jedi.ex01.client.station.api.doc.operator.user;

import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5017;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5018;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5019;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5022;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5024;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5025;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5017;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5018;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5019;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5022;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5024;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5025;
import jedi.ex01.CSTS3.comm.struct.AccountStrategy;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.util.AccountScanUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

public class UserDocOperator {
	private static UserDocOperator userDocOperator = new UserDocOperator();

	private UserDocOperator() {
	}

	public boolean loadUserLogin(String aeid) {
		IP_TRADESERV5018 ip = new IP_TRADESERV5018();
		ip.setUserName(aeid);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5018 op = (OP_TRADESERV5018) opfather;
		DataDoc.getInstance().setUserLogin(op.getUserLogin());
		return true;
	}

	public boolean loadGroupConfig(String groupName) {
		IP_TRADESERV5017 ip = new IP_TRADESERV5017();
		ip.setGroupName(groupName);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5017 op = (OP_TRADESERV5017) opfather;
		DataDoc.getInstance().setGroup(op.getGroupConfigVec()[0]);
		return true;
	}

	public boolean loadAccountStrategy(long accountID) {
		return loadAccountStrategy(accountID, null);
	}

	public boolean loadAccountStrategy(long accountID, String aeid) {
		IP_TRADESERV5019 ip = new IP_TRADESERV5019();
		ip.setAccountID(accountID);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5019 op = (OP_TRADESERV5019) opfather;
		AccountStrategy accountStrategy = op.getAccountStrategy();
		if (aeid != null && (!accountStrategy.getAeid().equals(aeid))) {
			return false;
		}
		DataDoc.getInstance().getAccountStore().setStrategy(op.getAccountStrategy());
		return true;
	}

	public boolean loadMoneyAccount(long accountID) {
		IP_TRADESERV5022 ip = new IP_TRADESERV5022();
		ip.setAccountID(accountID);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5022 op = (OP_TRADESERV5022) opfather;
		DataDoc.getInstance().getAccountStore().resetMoneyAccounts(op.getMoneyAccountVec());
		if (DocCaptain.isInited()) {
			try {
				AccountScanUtil.fixAccount(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MoneyAccount_Changed);
		return true;
	}

	public boolean loadTrade4CFD(long accountID) {
		IP_TRADESERV5024 ip = new IP_TRADESERV5024();
		ip.setAccountID(accountID);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5024 op = (OP_TRADESERV5024) opfather;
		DataDoc.getInstance().resetTrades(op.getTrade4CFDVec());

		if (DocCaptain.isInited()) {
			try {
				AccountScanUtil.fixAccount(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
		return true;
	}

	public boolean loadOrder4CFD(long accountID) {
		IP_TRADESERV5025 ip = new IP_TRADESERV5025();
		ip.setAccountID(accountID);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5025 op = (OP_TRADESERV5025) opfather;
		DataDoc.getInstance().resetOrders(op.getOrders4CFDVec());
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Changed);
		return true;
	}

	public static UserDocOperator getUserDocOperator() {
		return userDocOperator;
	}
}
