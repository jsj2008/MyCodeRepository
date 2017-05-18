package jedi.ex01.client.station.api.doc.operator.instrument;

import jedi.ex01.CSTS3.comm.ipop.IP_QG1001;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5012;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5013;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5015;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_QG1001;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5013;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5015;
import jedi.ex01.CSTS3.comm.struct.QuoteData;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent_NameInterface;

/**
 * InstrumentDocOperator Description： InstrumentDoc的操作类
 * 所有通过交易来取数据，植入doc的操作都在这里进行
 * 
 * @author guosheng
 * 
 */
public class InstrumentDocOperator {
	private static InstrumentDocOperator instrumentDocOperator = new InstrumentDocOperator();

	private InstrumentDocOperator() {
	}

	/**
	 * 装载InstrumentType 如
	 * 
	 * @return
	 */
	public boolean loadInstrumentTypes() {
		IP_TRADESERV5012 ip = new IP_TRADESERV5012();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
//		OP_TRADESERV5012 op = (OP_TRADESERV5012) opfather;
//		InstrumentDoc.getInstrumentDoc().updateInstrumentTypes(
//				op.getInstrumentTypeVec());
//		ListenerCaptain.getApiDataChangeListener()
//				.onInstrumentTypeChanged(null);
		return true;
	}

	/**
	 * 装载Instrument
	 * 
	 * @return
	 */
	public boolean loadInstruments() {
		IP_TRADESERV5013 ip = new IP_TRADESERV5013();
		ip.setAccountId(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setGroupName(DataDoc.getInstance().getGroup().getGroupName());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5013 op = (OP_TRADESERV5013) opfather;
		DataDoc.getInstance().resetInstruments(op.getInstrumentVec());
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Instrument_Changed);
		return true;
	}

	/**
	 * 装载Instrument
	 * 
	 * @return
	 */
	public boolean loadInstruments(String instrument) {
		IP_TRADESERV5013 ip = new IP_TRADESERV5013();
		ip.setInstrumentName(instrument);
		ip.setAccountId(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setGroupName(DataDoc.getInstance().getGroup().getGroupName());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5013 op = (OP_TRADESERV5013) opfather;
		DataDoc.getInstance().addInstrument(op.getInstrumentVec()[0]);
		API_IDEventCaptain.fireEventChanged(API_IDEvent_NameInterface.DATA_ON_Instrument_Changed);
		return true;
	}

	/**
	 * 装载InstrumentsGroupCfg
	 * 
	 * @return
	 */
//	public boolean loadInstrumentsGroupCfg(String groupName) {
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(
//				APIDataEventListener.STATE_START);
//		IP_TRADESERV5020 ip = new IP_TRADESERV5020();
//		ip.setGroupName(groupName);
//		ip.setToQueryAll(true);
//		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
//		if (!opfather.isSucceed()) {
//			ListenerCaptain.getApiDataEventListener()
//					.onLoadInstrumentsGroupCfg(
//							APIDataEventListener.STATE_FAILED);
//			return false;
//		}
//		OP_TRADESERV5020 op = (OP_TRADESERV5020) opfather;
//		InstrumentDoc.getInstrumentDoc().resetInstrumentGroupCfgs(groupName,
//				op.getInstrumentGroupCfgVec());
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(
//				APIDataEventListener.STATE_SUCCEED);
//		ListenerCaptain.getApiDataChangeListener().onInstrumentGroupCfgChanged(
//				groupName, null);
//		PriceUtil.clearShift(null);
//		return true;
//	}

	/**
	 * 装载InstrumentsAccountCfg
	 * 
	 * @return
	 */
//	public boolean loadInstrumentsAccountCfg(long accountID) {
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(
//				APIDataEventListener.STATE_START);
//		IP_TRADESERV5021 ip = new IP_TRADESERV5021();
//		ip.setAccountID(accountID);
//		ip.setToQueryAll(true);
//		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
//		if (!opfather.isSucceed()) {
//			ListenerCaptain.getApiDataEventListener()
//					.onLoadInstrumentsAccountCfg(
//							APIDataEventListener.STATE_FAILED);
//			return false;
//		}
//		OP_TRADESERV5021 op = (OP_TRADESERV5021) opfather;
//		InstrumentDoc.getInstrumentDoc().resetInstrumentAccountCfgs(accountID,
//				op.getInstrumentAccountCfgVec());
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(
//				APIDataEventListener.STATE_SUCCEED);
//		ListenerCaptain.getApiDataChangeListener()
//				.onInstrumentAccountCfgChanged(new Long(accountID), null);
//		PriceUtil.clearShift(accountID, null);
//		return true;
//	}

//	public boolean loadInstrumentsGroupCfg(String groupName, String instrument) {
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(
//				APIDataEventListener.STATE_START);
//		IP_TRADESERV5020 ip = new IP_TRADESERV5020();
//		ip.setGroupName(groupName);
//		ip.setInstrumentName(instrument);
//		ip.setToQueryAll(false);
//		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
//		if (!opfather.isSucceed()) {
//			ListenerCaptain.getApiDataEventListener()
//					.onLoadInstrumentsGroupCfg(
//							APIDataEventListener.STATE_FAILED);
//			return false;
//		}
//		OP_TRADESERV5020 op = (OP_TRADESERV5020) opfather;
//		InstrumentDoc.getInstrumentDoc().updateInstrmentGroupCfgs(
//				new InstrumentsGroupCfg[] { op.getInstrumentGroupCfg() });
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsGroupCfg(
//				APIDataEventListener.STATE_SUCCEED);
//		ListenerCaptain.getApiDataChangeListener().onInstrumentGroupCfgChanged(
//				groupName, instrument);
//		PriceUtil.clearShift(instrument);
//		return true;
//	}

//	public boolean loadInstrumentsAccountCfg(long accountID, String instrument) {
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(
//				APIDataEventListener.STATE_START);
//		IP_TRADESERV5021 ip = new IP_TRADESERV5021();
//		ip.setAccountID(accountID);
//		ip.setInstrumentName(instrument);
//		ip.setToQueryAll(false);
//		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
//		if (!opfather.isSucceed()) {
//			ListenerCaptain.getApiDataEventListener()
//					.onLoadInstrumentsAccountCfg(
//							APIDataEventListener.STATE_FAILED);
//			return false;
//		}
//		OP_TRADESERV5021 op = (OP_TRADESERV5021) opfather;
//		InstrumentDoc.getInstrumentDoc().updateInstrumentAccountCfgs(
//				new InstrumentsAccountCfg[] { op.getInstrumentAccountCfg() });
//		ListenerCaptain.getApiDataEventListener().onLoadInstrumentsAccountCfg(
//				APIDataEventListener.STATE_SUCCEED);
//		ListenerCaptain.getApiDataChangeListener()
//				.onInstrumentAccountCfgChanged(new Long(accountID), instrument);
//		PriceUtil.clearShift(accountID, instrument);
//		return true;
//	}

	/**
	 * 装载BatchRateGap
	 * 
	 * @return
	 */
	public boolean loadBatchRateGap() {
		IP_TRADESERV5015 ip = new IP_TRADESERV5015();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5015 op = (OP_TRADESERV5015) opfather;
		DataDoc.getInstance().resetBatchRateGap(op.getBatchRateGapVec());
		return true;
	}

	/**
	 * 装载BatchRateGap
	 * 
	 * @return
	 */
	public boolean loadBatchRateGap(String instrument) {
		IP_TRADESERV5015 ip = new IP_TRADESERV5015();
		ip.setInstrumentName(instrument);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_TRADESERV5015 op = (OP_TRADESERV5015) opfather;
		DataDoc.getInstance().addBatchRateGap(op.getBatchRateGapVec()[0]);
		return true;
	}

	public boolean loadQuoteTable(String instruments[]) {
		IP_QG1001 ip = new IP_QG1001();
		if (instruments != null) {
			ip.setSearchType(IP_QG1001.SEARCH_TYPE_INSTRUMENTVECTOR);
			ip.setInstruments(instruments);
		} else {
			ip.setSearchType(IP_QG1001.SEARCH_TYPE_ALL);
		}
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		}
		OP_QG1001 top = (OP_QG1001) opfather;
		if (top.getQuoteList() != null) {
			QuoteData quoteVec[] = top.getQuoteList();
			DataDoc.getInstance().resetQuoteTable(quoteVec);
			// for (int i = 0; i < top.getQuoteList().size(); i++) {
			// InstrumentDoc.getInstrumentDoc().setQuote(
			// (QuoteData) top.getQuoteList().get(i));
			// }
		}
		return true;
	}

	public static InstrumentDocOperator getInstrumentDocOperator() {
		return instrumentDocOperator;
	}
}
