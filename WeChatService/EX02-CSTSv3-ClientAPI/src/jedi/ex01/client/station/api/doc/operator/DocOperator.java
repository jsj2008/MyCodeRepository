package jedi.ex01.client.station.api.doc.operator;

import java.util.Locale;
import java.util.TimeZone;

import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5040;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5041;
import jedi.ex01.CSTS3.comm.ipop.IP_Web1001;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5040;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5041;
import jedi.ex01.CSTS3.comm.ipop.OP_Web1001;
import jedi.ex01.CSTS3.comm.struct.AccountStrategy;
import jedi.ex01.CSTS3.proxy.comm.AccountStore;
import jedi.ex01.CSTS3.proxy.debug.RunningTimeDebugTools;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.debug.APIDebugLog;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.DocCaptain;
import jedi.ex01.client.station.api.doc.util.AccountScanUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;
import jedi.ex01.client.station.api.util.PriceUtil;

public class DocOperator {
	private static DocOperator instance = new DocOperator();

	private DocOperator() {
	}

	public static DocOperator getInstance() {
		return instance;
	}

	public boolean initDoc(Locale locale, String[] otherCfgKeyVec) {
		// long t1 = System.currentTimeMillis();
		if (!loadAllData(ClientAPI.getInstance().accounts[0], locale,
				otherCfgKeyVec)) {
			return false;
		}
		// long t2 = System.currentTimeMillis();

		// APIDebugLog.getInstance().logout("init doc used time[t2-t1]"+(t2-t1),
		// APIDebugLog.level_info);

		// if
		// (!FundDocOperator.getFundDocOperator().loadFundAccount(DataDoc.getInstance().getAccountStore().getAccountID()))
		// {
		// return false;
		// }
		// long t3 = System.currentTimeMillis();
		// if (!loadSystemBasicData()) {
		// return false;
		// }
		// long t4 = System.currentTimeMillis();
		// if (!loadUserData(ClientAPI.getUserName())) {
		// return false;
		// }
		// long t5 = System.currentTimeMillis();
		// AccountStore accoutStore = DataDoc.getInstance().getAccountStore();
		// // for (int i = 0; i < accoutStores.length; i++) {
		// if (!loadAccountData(accoutStore.getAccountID())) {
		// return false;
		// }
		// if
		// (!FundDocOperator.getFundDocOperator().loadFundAccount(accoutStore.getAccountID()))
		// {
		// return false;
		// }
		// // }
		// long t6 = System.currentTimeMillis();
		// DocCaptain.setInited(true);
		// new Thread() {
		// public void run() {
		// Instrument instVec[] =
		// DataDoc.getInstance().getInstrumentList().toArray(new Instrument[0]);
		// String instNameVec[] = new String[instVec.length];
		// for (int i = 0; i < instVec.length; i++) {
		// instNameVec[i] = instVec[i].getInstrument();
		// }
		// InstrumentDocOperator.getInstrumentDocOperator().loadQuoteTable(instNameVec);
		// // ListenerCaptain.getApiOtherListener().onQuoteListInited();
		// API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_QUOTELIST_INITED);
		// }
		// }.start();
		// try {
		// Thread.sleep(500);
		// } catch (Exception e) {
		// }
		// long t7 = System.currentTimeMillis();
		// System.out.println((new StringBuilder("CSTS initDoc ")).append(t2 -
		// t1).append(",").append(t3 - t2)
		// .append(",").append(t4 - t3).append(",").append(t5 -
		// t4).append(",").append(t6 - t5).append(
		// ",").append(t7 - t6).toString());
		// API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_DOC_INITED);
		return true;
	}

	public boolean resetUserDoc() {
		if (!loadUserData(ClientAPI.getUserName())) {
			return false;
		}
		if (!loadAccountData(DataDoc.getInstance().getAccountStore()
				.getAccountID())) {
			return false;
		}
		// AccountStore accoutStores[] =
		// UserDoc.getUserDoc().getAccountStoreArray();
		// for (int i = 0; i < accoutStores.length; i++) {
		// if (!loadAccountData(accoutStores[i].getAccountID())) {
		// return false;
		// }
		// }
		return true;
	}

	public boolean loadAllData(long accountId, Locale locale,
			String[] otherCfgKeyVec) {
		IP_Web1001 ip = new IP_Web1001();
		ip.setAccountId(accountId);
		ip.setLocale(locale.toString());
		ip.setKeySet(otherCfgKeyVec);
		RunningTimeDebugTools debug = RunningTimeDebugTools
				.newInstance("init doc");
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		debug.stepTo("init end");
		// System.out.println(debug.format());
		APIDebugLog.getInstance()
				.logout(debug.format(), APIDebugLog.level_info);
		if (!opfather.isSucceed()) {
			APIDebugLog
					.getInstance()
					.logout("init doc error:" + opfather.getErrCode() + " | "
							+ opfather.getErrMessage(), APIDebugLog.level_error);
			return false;
		}
		OP_Web1001 op = (OP_Web1001) opfather;
		DataDoc.getInstance().setInstTreeNodeVec(op.getInstTypeTrees());
		DataDoc.getInstance().setLangPack(op.getLangPack());
		DataDoc.getInstance().setTimeZone(
				TimeZone.getTimeZone(op.getTimeZone()));
		DataDoc.getInstance()
				.addOtherClientConfig(op.getOtherClientConfigVec());
		DataDoc.getInstance().resetBasicCurrencys(op.getCurrencys());
		DataDoc.getInstance().setSystemConfig(op.getSystemConfig());
		// InstrumentDoc.getInstrumentDoc().updateInstrumentTypes(op.getInstrumentTypeVec());
		DataDoc.getInstance().resetInstruments(op.getInstruments());
		DataDoc.getInstance().resetBatchRateGap(op.getBatchRateGaps());
		// DataDoc.getInstance().setCfdTradeTypeConfig(op.getTradeTypeConfigs()[0]);
		DataDoc.getInstance().setGroup(op.getGroup());
		DataDoc.getInstance().setUserLogin(op.getUserLogin());
		AccountStore as = new AccountStore(op.getAccount());
		as.resetMoneyAccounts(op.getMoneyaccounts());
		DataDoc.getInstance().setAccountStore(as);
		DataDoc.getInstance().resetTrades(op.getTrades());
		DataDoc.getInstance().resetOrders(op.getOrders());
		DataDoc.getInstance().resetQuoteTable(op.getQuoteList());

		DocCaptain.setInited(true);
		API_IDEventCaptain
				.fireEventChanged(API_IDEvent_NameInterface.NAME_ON_DOC_INITED);
		return true;
	}

	public boolean loadUserData(String userName) {
		PriceUtil.clearShift();
		IP_TRADESERV5040 ip = new IP_TRADESERV5040();
		ip.setUserName(userName);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5040 op = (OP_TRADESERV5040) opfather;
		DataDoc.getInstance().setGroup(op.getGroupConfig());
		DataDoc.getInstance().setUserLogin(op.getUserLogin());
		DataDoc.getInstance().getAccountStore()
				.setStrategy(op.getAccountStrategy());

		// AccountStrategy[] asVector = op.geta();
		// if (asVector != null && asVector.length > 0) {
		// ClientAPI.setMarketId(op.getAccountStrategy().get);
		// return true;
		// } else {
		// Exception ex = new Exception(
		// "DoLogin: invalid market id for load user data.");
		// ex.printStackTrace();
		// return false;
		// }

		System.out.println("初始化拿到的市场id为----------"
				+ op.getAccountStrategy().getMarketId());
		// 2016年8月15日18:06:42:设置银行出入金的MarketId
		ClientAPI.setMarketId(op.getAccountStrategy().getMarketId());

		DataDoc.getInstance().resetInstruments(op.getInstrumentVec());
		return true;
	}

	public boolean loadAccountData(long accountID) {
		IP_TRADESERV5041 ip = new IP_TRADESERV5041();
		ip.setAccountID(accountID);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5041 op = (OP_TRADESERV5041) opfather;
		DataDoc.getInstance().getAccountStore()
				.resetMoneyAccounts(op.getMoneyAccountVec());
		DataDoc.getInstance().resetTrades(op.getTrade4CFDVec());
		DataDoc.getInstance().resetOrders(op.getOrder4CFDVec());
		if (DocCaptain.isInited()) {
			try {
				AccountScanUtil.fixAccount(true);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		API_IDEventCaptain
				.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_MoneyAccount_Changed);
		API_IDEventCaptain
				.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Trade_Changed);
		API_IDEventCaptain
				.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Order_Changed);
		return true;
	}
}
