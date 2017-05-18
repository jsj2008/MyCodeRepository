package jedi.ex01.client.station.api.trade;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import allone.crypto.Crypt;
import jedi.ex01.CSTS3.comm.ipop.IP_BankServ1001;
import jedi.ex01.CSTS3.comm.ipop.IP_BankServ2001;
import jedi.ex01.CSTS3.comm.ipop.IP_BankServ2011;
import jedi.ex01.CSTS3.comm.ipop.IP_BankServ2012;
import jedi.ex01.CSTS3.comm.ipop.IP_QDB1002;
import jedi.ex01.CSTS3.comm.ipop.IP_QDB1003;
import jedi.ex01.CSTS3.comm.ipop.IP_QDB1004;
import jedi.ex01.CSTS3.comm.ipop.IP_REPORT2901;
import jedi.ex01.CSTS3.comm.ipop.IP_REPORT2902;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV3001;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5026;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5046;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5061;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5062;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5063;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5101;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5102;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5103;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5104;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5105;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5106;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5107;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5108;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5110;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5115;
import jedi.ex01.CSTS3.comm.ipop.IP_TRADESERV5116;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.CSTS3.comm.ipop.OP_BankServ1001;
import jedi.ex01.CSTS3.comm.ipop.OP_BankServ2001;
import jedi.ex01.CSTS3.comm.ipop.OP_BankServ2011;
import jedi.ex01.CSTS3.comm.ipop.OP_QDB1002;
import jedi.ex01.CSTS3.comm.ipop.OP_QDB1003;
import jedi.ex01.CSTS3.comm.ipop.OP_QDB1004;
import jedi.ex01.CSTS3.comm.ipop.OP_REPORT2901;
import jedi.ex01.CSTS3.comm.ipop.OP_REPORT2902;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV3001;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5026;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5046;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5061;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5062;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5063;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5101;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5102;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5103;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5104;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5106;
import jedi.ex01.CSTS3.comm.ipop.OP_TRADESERV5110;
import jedi.ex01.CSTS3.comm.jsondata.QuoteRequest;
import jedi.ex01.CSTS3.comm.jsondata.VolumnRequest;
import jedi.ex01.CSTS3.comm.struct.ClosedPositionsDetails;
import jedi.ex01.CSTS3.comm.struct.HistoricData;
import jedi.ex01.CSTS3.comm.struct.MessageToAccount;
import jedi.ex01.CSTS3.comm.struct.MoneyAccountStreamDetails;
import jedi.ex01.CSTS3.comm.struct.PriceWarning;
import jedi.ex01.CSTS3.comm.struct.TikValue;
import jedi.ex01.CSTS3.comm.struct.WithdrawApplication;
import jedi.ex01.CSTS3.proxy.comm.IPOPErrCodeTable;
import jedi.ex01.CSTS3.proxy.comm.MTP4CommDataInterface;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.bankserver.BCTradeResult;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_CanWithdraw;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_DWCheck;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_Deposit;
import jedi.ex01.client.station.api.bankserver.BCTradeResult_UserBankProfile;
import jedi.ex01.client.station.api.bankserver.BankAPI;
import jedi.ex01.client.station.api.bankserver.BankIDListInterface;
import jedi.ex01.client.station.api.bankserver.BankMetadataBuilder;
import jedi.ex01.client.station.api.bankserver.BankServCommData;
import jedi.ex01.client.station.api.bankserver.IBankMetadata;
import jedi.ex01.client.station.api.doc.DataDoc;
import jedi.ex01.client.station.api.doc.operator.DocOperator;
import jedi.ex01.client.station.api.doc.util.AccountDigestUtil;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;
import jedi.ex01.client.station.api.event.data.API_TradeResultEvent;
import jedi.ex01.client.station.api.exception.APIException;

public class TradeAPI {
	private static TradeAPI instance = new TradeAPI();
	private HashSet quoteNameSet = new HashSet();

	private TradeAPI() {

	}

	public IP_TRADESERV5101 createMktCFDTradeIP(String instrumentName,
			boolean isbuyNotSell, double lots, double price, int mktPriceGap,
			boolean toOpenNew, long[] toCloseTickets, double IFDStopPrice,
			double IFDLimitPrice, boolean IFDIsGuarateed) {
		IP_TRADESERV5101 ip = new IP_TRADESERV5101();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setInstrumentName(instrumentName);
		ip.setBuySell(isbuyNotSell ? MTP4CommDataInterface.BUY
				: MTP4CommDataInterface.SELL);
		ip.setLots(lots);
		ip.setPrice(price);
		ip.setMktPriceGap(mktPriceGap);
		ip.setToOpenNew(toOpenNew);
		StringBuffer toClosetickets = new StringBuffer();
		for (int i = 0; i < toCloseTickets.length; i++) {
			if (i != 0) {
				toClosetickets.append(MTP4CommDataInterface.LIST_SEPERATOR);
			}
			toClosetickets.append(toCloseTickets[i]);
		}
		ip.setToCloseTickets(toClosetickets.toString());
		ip.setOrderType(MTP4CommDataInterface.ORDERTYPE_MKT);
		ip.setIFDStopPrice(IFDStopPrice);
		ip.setIFDLimitPrice(IFDLimitPrice);
		ip.setIFDIsGuaranteed(IFDIsGuarateed);
		ip.setExpireTime(null);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		return ip;
	}

	public IP_TRADESERV5101 createCLOSE_PART_OF_1_TRADE_MKT_CFDTrade(
			String instrumentName, boolean isbuyNotSell, double lots,
			double price, int mktPriceGap, long toCloseTicket) {
		IP_TRADESERV5101 ip = new IP_TRADESERV5101();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setInstrumentName(instrumentName);
		ip.setBuySell(isbuyNotSell ? MTP4CommDataInterface.BUY
				: MTP4CommDataInterface.SELL);
		ip.setLots(lots);
		ip.setPrice(price);
		ip.setMktPriceGap(mktPriceGap);
		ip.setToOpenNew(false);
		ip.setToCloseTickets(String.valueOf(toCloseTicket));
		ip.setOrderType(MTP4CommDataInterface.ORDERTYPE_CLOSE_PART_OF_1_TRADE_MKT);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		return ip;
	}

	public IP_TRADESERV5101 createCLOSE_N_FIXED_TRADES_MKT_CFDTrade(
			String instrumentName, boolean isbuyNotSell, double price,
			int mktPriceGap, long[] toCloseTickets) {
		IP_TRADESERV5101 ip = new IP_TRADESERV5101();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setInstrumentName(instrumentName);
		ip.setBuySell(isbuyNotSell ? MTP4CommDataInterface.BUY
				: MTP4CommDataInterface.SELL);
		ip.setPrice(price);
		ip.setMktPriceGap(mktPriceGap);
		ip.setToOpenNew(false);

		StringBuffer toClosetickets = new StringBuffer();
		for (int i = 0; i < toCloseTickets.length; i++) {
			if (i != 0) {
				toClosetickets.append(MTP4CommDataInterface.LIST_SEPERATOR);
			}
			toClosetickets.append(toCloseTickets[i]);
		}
		ip.setToCloseTickets(toClosetickets.toString());
		ip.setOrderType(MTP4CommDataInterface.ORDERTYPE_CLOSE_N_FIXED_TRADES_MKT);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		return ip;
	}

	public TradeResult_MktCFD doMKTCFDTrade(IP_TRADESERV5101 ip) {
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		TradeResult_MktCFD result = new TradeResult_MktCFD();
		if (opfather.isSucceed()) {
			OP_TRADESERV5101 op = (OP_TRADESERV5101) opfather;
			if (op.isMktPriceChanged()) {
				result.setResult(TradeResult_MktCFD.RESULT_PRICECHANGED);
				result.setNewMktPrice(op.getNewMKTPrice());
			} else {
				result.setOrderHis(op.getOrderHis());
				result.setResult(TradeResult_MktCFD.RESULT_SUCCEED);
				// InfoCaptain.getInstance().onInfo(op.getInfo1010());
			}
		} else {
			if (opfather.getErrCode() == null) {
				result.setErrCodeAndCreateResult(IPOPErrCodeTable.ERR_Unknown);
			} else {
				result.setErrCodeAndCreateResult(opfather.getErrCode());
			}
			result.set_errMessage(opfather.getErrMessage());
		}
		if (result.getResult() == TradeResult_MktCFD.RESULT_MD5DigestDontMatch) {
			DocOperator.getInstance().loadAccountData(ip.getAccountID());
		}
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		return result;
	}

	public void doCancelMktTrade(String uptradeOperatorID) {
		IP_TRADESERV5107 ip = new IP_TRADESERV5107();
		ip.setUserName(ClientAPI.getUserName());
		ip.setUptradeOperatorID(uptradeOperatorID);
		CSTSCaptain.getInstance().trade(ip);
	}

	public TradeResult_HedgeCFD doHedgeCFDTrade(String instrument,
			long stickets[], long antiStickets[]) {
		IP_TRADESERV5102 ip = new IP_TRADESERV5102();
		ip.setUserName(ClientAPI.getUserName());
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setInstrument(instrument);

		StringBuffer toCloseticketsVec1 = new StringBuffer();
		for (int i = 0; i < stickets.length; i++) {
			if (i != 0) {
				toCloseticketsVec1.append(MTP4CommDataInterface.LIST_SEPERATOR);
			}
			toCloseticketsVec1.append(stickets[i]);
		}

		StringBuffer toCloseticketsVec2 = new StringBuffer();
		for (int i = 0; i < antiStickets.length; i++) {
			if (i != 0) {
				toCloseticketsVec2.append(MTP4CommDataInterface.LIST_SEPERATOR);
			}
			toCloseticketsVec2.append(antiStickets[i]);
		}
		ip.setStickets(toCloseticketsVec1.toString());
		ip.setAntiTickets(toCloseticketsVec2.toString());
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		TradeResult_HedgeCFD result = new TradeResult_HedgeCFD();
		if (opfather.isSucceed()) {
			result.setResult(TradeResult_HedgeCFD.RESULT_SUCCEED);
			result.setOrderHis(((OP_TRADESERV5102) opfather).getOrderHis());
			// InfoCaptain.getInstance().onInfo(((OP_TRADESERV5102)
			// opfather).getInfo1010());
		} else {
			if (opfather.getErrCode() == null) {
				result.setErrCodeAndCreateResult(IPOPErrCodeTable.ERR_Unknown);
			} else {
				result.setErrCodeAndCreateResult(opfather.getErrCode());
			}
			result.set_errMessage(opfather.getErrMessage());
		}
		if (result.getResult() == TradeResult_HedgeCFD.RESULT_MD5DigestDontMatch) {
			DocOperator.getInstance().loadAccountData(
					DataDoc.getInstance().getAccountStore().getAccountID());
		}
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		return result;
	}

	public TradeResult_orderCFD doOpenNormalOrderCFDTrade(String instrument,
			boolean isBuyNotSell, double lots, double limitprice,
			double oriStopprice, boolean toOpenNew, long[] toCloseTickets,
			String expireTime, double IFDLimitPrice, double IFDStopPrice,
			boolean IFDStopGuaranteed) {
		IP_TRADESERV5103 ip = new IP_TRADESERV5103();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setInstrumentName(instrument);
		ip.setBuysell(isBuyNotSell ? MTP4CommDataInterface.BUY
				: MTP4CommDataInterface.SELL);
		ip.setLots(lots);
		ip.setType(MTP4CommDataInterface.ORDERTYPE_NORMAL);
		ip.setLimitprice(limitprice);
		ip.setOriStopprice(oriStopprice);
		ip.setStopGuaranteed(false);
		ip.setStopMoveGap(0);
		ip.setToOpenNew(toOpenNew);

		StringBuffer toCloseticketsVec1 = new StringBuffer();
		for (int i = 0; i < toCloseTickets.length; i++) {
			if (i != 0) {
				toCloseticketsVec1.append(MTP4CommDataInterface.LIST_SEPERATOR);
			}
			toCloseticketsVec1.append(toCloseTickets[i]);
		}
		ip.setToCloseTickets(toCloseticketsVec1.toString());
		ip.setExpireTime(expireTime);
		ip.setIFDLimitPrice(IFDLimitPrice);
		ip.setIFDStopPrice(IFDStopPrice);
		ip.setIFDStopGuaranteed(IFDStopGuaranteed);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		TradeResult_orderCFD result = new TradeResult_orderCFD();
		if (opfather.isSucceed()) {
			result.setResult(TradeResult_orderCFD.RESULT_SUCCEED);
			result.setOrder(((OP_TRADESERV5103) opfather).getOrder());
			// InfoCaptain.getInstance().onInfo(((OP_TRADESERV5103)
			// opfather).getInfo1010());
		} else {
			if (opfather.getErrCode() == null) {
				result.setErrCodeAndCreateResult(IPOPErrCodeTable.ERR_Unknown);
			} else {
				result.setErrCodeAndCreateResult(opfather.getErrCode());
			}
			result.set_errMessage(opfather.getErrMessage());
		}
		if (result.getResult() == TradeResult_orderCFD.RESULT_MD5DigestDontMatch) {
			DocOperator.getInstance().loadAccountData(
					DataDoc.getInstance().getAccountStore().getAccountID());
		}
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		return result;
	}

	public TradeResult_orderCFD doOpen_CLOSE_1_FIXED_TRADE_ORDER_CFDTrade(
			String instrument, boolean isBuyNotSell, double limitprice,
			double oriStopprice, int stopMoveGap, boolean stopGuaranteed,
			long toCloseTicket, String expireTime) {
		IP_TRADESERV5103 ip = new IP_TRADESERV5103();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setInstrumentName(instrument);
		ip.setBuysell(isBuyNotSell ? MTP4CommDataInterface.BUY
				: MTP4CommDataInterface.SELL);
		ip.setType(MTP4CommDataInterface.ORDERTYPE_CLOSE_1_FIXED_TRADE_ORDER);
		ip.setLimitprice(limitprice);
		ip.setOriStopprice(oriStopprice);
		ip.setStopMoveGap(stopMoveGap);
		ip.setStopGuaranteed(stopGuaranteed);
		ip.setToOpenNew(false);
		ip.setToCloseTickets(String.valueOf(toCloseTicket));
		ip.setExpireTime(expireTime);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		TradeResult_orderCFD result = new TradeResult_orderCFD();
		if (opfather.isSucceed()) {
			result.setResult(TradeResult_orderCFD.RESULT_SUCCEED);
			result.setOrder(((OP_TRADESERV5103) opfather).getOrder());
			// InfoCaptain.getInstance().onInfo(((OP_TRADESERV5103)
			// opfather).getInfo1010());
		} else {
			if (opfather.getErrCode() == null) {
				result.setErrCodeAndCreateResult(IPOPErrCodeTable.ERR_Unknown);
			} else {
				result.setErrCodeAndCreateResult(opfather.getErrCode());
			}
			result.set_errMessage(opfather.getErrMessage());
		}
		if (result.getResult() == TradeResult_orderCFD.RESULT_MD5DigestDontMatch) {
			DocOperator.getInstance().loadAccountData(
					DataDoc.getInstance().getAccountStore().getAccountID());
		}
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		return result;
	}

	public TradeResult_orderCFD doModifyOrder(long orderId, double lots,
			int stopMoveGap, double limitprice, double oriStopprice,
			String expiryTime, double IFDLimitPrice, double IFDStopPrice,
			boolean IFDGuaranteeStop) {
		IP_TRADESERV5104 ip = new IP_TRADESERV5104();
		ip.setAccountID(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setOrderID(orderId);
		ip.setLots(lots);
		ip.setStopMoveGap(stopMoveGap);
		ip.setLimitprice(limitprice);
		ip.setOriStopprice(oriStopprice);
		ip.setExpiryTime(expiryTime);
		ip.setIFDLimitPrice(IFDLimitPrice);
		ip.setIFDStopPrice(IFDStopPrice);
		ip.setIFDGuaranteeStop(IFDGuaranteeStop);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());

		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		TradeResult_orderCFD result = new TradeResult_orderCFD();
		if (opfather.isSucceed()) {
			result.setResult(TradeResult_orderCFD.RESULT_SUCCEED);
			result.setOrder(((OP_TRADESERV5104) opfather).getOrder());
			// InfoCaptain.getInstance().onInfo(((OP_TRADESERV5104)
			// opfather).getInfo1010());
		} else {
			if (opfather.getErrCode() == null) {
				result.setErrCodeAndCreateResult(IPOPErrCodeTable.ERR_Unknown);
			} else {
				result.setErrCodeAndCreateResult(opfather.getErrCode());
			}
			result.set_errMessage(opfather.getErrMessage());
		}
		if (result.getResult() == TradeResult_orderCFD.RESULT_MD5DigestDontMatch) {
			DocOperator.getInstance().loadAccountData(
					DataDoc.getInstance().getAccountStore().getAccountID());
		}
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		return result;
	}

	public boolean doDeleteOrderTrade(long orderID) {
		IP_TRADESERV5105 ip = new IP_TRADESERV5105();
		ip.setAccount(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setUserName(ClientAPI.getUserName());
		ip.setOrderID(orderID);
		ip.setAccountDigist(AccountDigestUtil.getAccountDigest());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		API_IDEventCaptain.getInstance().fireEventChanged(
				new API_TradeResultEvent(ip, opfather));
		if (opfather.isSucceed()) {
			// InfoCaptain.getInstance().onInfo(((OP_TRADESERV5105)
			// opfather).getInfo1010());
		}
		return opfather.isSucceed();
	}

	public int changePassword(String oldPassword, String newPassword) {
		IP_TRADESERV5110 ip = new IP_TRADESERV5110();
		ip.setUserName(ClientAPI.getUserName());
		ip.setOldPasswordDig(allone.crypto.Crypt.encryptALLONE(oldPassword,
				ClientAPI.getUserName()));
		ip.setNewPassword(allone.crypto.Crypt.encryptALLONE(newPassword,
				ClientAPI.getUserName()));
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return MTP4CommDataInterface.USERIDENTIFY_RESULT_ERR_UNKNOW;
		}
		OP_TRADESERV5110 op = (OP_TRADESERV5110) opfather;
		int result = op.getResult();
		if (result == MTP4CommDataInterface.USERIDENTIFY_RESULT_SUCCEED) {
			ClientAPI.getInstance().resetPassword(ip.getNewPassword());
		}
		return result;
	}

	public boolean changeStopMove(long orderID, int moveGap) {
		IP_TRADESERV5108 ip = new IP_TRADESERV5108();
		ip.setAccount(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setOrderID(orderID);
		ip.setStopMove(moveGap);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		return opfather.isSucceed();
	}

	public boolean sendMessage(String title, String context) {
		IP_TRADESERV5115 ip = new IP_TRADESERV5115();
		ip.setTitle(title);
		ip.setContext(context);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		return opfather.isSucceed();
	}

	public boolean checkAccount() throws Exception {
		IP_TRADESERV5046 ip = new IP_TRADESERV5046();
		ip.setAccount(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setDigist(AccountDigestUtil.getAccountDigest());
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (opfather.isSucceed()) {
			OP_TRADESERV5046 op = (OP_TRADESERV5046) opfather;
			return op.isResult();
		} else {
			throw new Exception(opfather.getErrCode());
		}
	}

	public HistoricData[] queryHisData(String instrument, int cycle, int limit)
			throws APIException {
		IP_QDB1002 ip = new IP_QDB1002();
		ip.setCycle(cycle);
		ip.setLimit(Math.max(400, limit));
		ip.setInstrument(instrument);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_QDB1002 op = (OP_QDB1002) opfather;
		return op.getList();
	}

	public HistoricData[] queryMoreHisData(String instrument, int cycle,
			long endTime) throws APIException {
		IP_QDB1003 ip = new IP_QDB1003();
		ip.setCycle(cycle);
		ip.setLimit(400);
		ip.setInstrument(instrument);
		ip.setEndTime(endTime);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_QDB1003 op = (OP_QDB1003) opfather;
		return op.getList();
	}

	public TikValue[] queryShortTikHisData(String instrument)
			throws APIException {
		return queryTikHisData(instrument, 100);
	}

	public TikValue[] queryTikHisData(String instrument) throws APIException {
		return queryTikHisData(instrument, 400);
	}

	public TikValue[] queryTikHisData(String instrument, int number)
			throws APIException {
		IP_QDB1004 ip = new IP_QDB1004();
		ip.setLimit(number);
		ip.setInstrument(instrument);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_QDB1004 op = (OP_QDB1004) opfather;
		return op.getList();
	}

	public ClosedPositionsDetails[] report_ClosedPositions(String fromTradeDay,
			String endTradeDay) throws Exception {
		IP_REPORT2901 ip = new IP_REPORT2901();
		ip.setAccount(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setFromTradeDay(fromTradeDay);
		ip.setEndTradeDay(endTradeDay);
		OPFather oop = CSTSCaptain.getInstance().trade(ip);
		TradeResult_SummaryReport result = new TradeResult_SummaryReport();
		result.setSucceed(oop.isSucceed());
		result.set_errCode(oop.getErrCode());
		result.set_errMessage(oop.getErrMessage());
		if (oop.isSucceed()) {
			OP_REPORT2901 op = (OP_REPORT2901) oop;
			return op.getClosedPositionVec();
		} else {
			throw new Exception(oop.getErrCode() + " : " + oop.getErrMessage());
		}
	}

	public MoneyAccountStreamDetails[] report_MoneyAccountStream(
			String fromTradeDay, String endTradeDay, Integer[] typeVec)
			throws Exception {
		IP_REPORT2902 ip = new IP_REPORT2902();
		ip.setAccount(DataDoc.getInstance().getAccountStore().getAccountID());
		ip.setFromTradeDay(fromTradeDay);
		ip.setEndTradeDay(endTradeDay);
		ip.setTypeVec(typeVec);
		OPFather oop = CSTSCaptain.getInstance().trade(ip);
		TradeResult_SummaryReport result = new TradeResult_SummaryReport();
		result.setSucceed(oop.isSucceed());
		result.set_errCode(oop.getErrCode());
		result.set_errMessage(oop.getErrMessage());
		if (oop.isSucceed()) {
			OP_REPORT2902 op = (OP_REPORT2902) oop;
			return op.getAccountStreamVec();
		} else {
			throw new Exception(oop.getErrCode() + " : " + oop.getErrMessage());
		}
	}

	public MessageToAccount[] queryMessages() throws APIException {
		IP_TRADESERV5061 ip = new IP_TRADESERV5061();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_TRADESERV5061 op = (OP_TRADESERV5061) opfather;
		return op.getMessages();
	}

	public MessageToAccount queryMessage(String messageGuid)
			throws APIException {
		IP_TRADESERV5062 ip = new IP_TRADESERV5062();
		ip.setMessageGuid(messageGuid);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_TRADESERV5062 op = (OP_TRADESERV5062) opfather;
		return op.getMessage();
	}

	public PriceWarning[] queryPriceWarning() throws APIException {
		IP_TRADESERV5026 ip = new IP_TRADESERV5026();
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_TRADESERV5026 op = (OP_TRADESERV5026) opfather;
		return op.getPriceWarningVec();
	}

	public PriceWarning addPriceWarning(long account, String instrument,
			double price, int priceType, int compareWay) throws APIException {
		IP_TRADESERV5106 ip = new IP_TRADESERV5106();
		ip.setOperateType(IP_TRADESERV5106.OPERATETYPE_ADD);
		ip.setUserName(ClientAPI.getUserName());
		PriceWarning pw = new PriceWarning();
		pw.setAccount(account);
		pw.setCompareWay(compareWay);
		pw.setInstrument(instrument);
		pw.setPrice(price);
		pw.setPriceType(priceType);
		ip.setToAddPW(pw);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_TRADESERV5106 op = (OP_TRADESERV5106) opfather;
		return op.getAddedPriceWarning();
	}

	public void deletePriceWarning(String guid) {
		IP_TRADESERV5106 ip = new IP_TRADESERV5106();
		ip.setOperateType(IP_TRADESERV5106.OPERATETYPE_DELETE);
		ip.setToDeletePWGUID(guid);
		CSTSCaptain.getInstance().trade(ip);
	}

	public HashMap queryWithdrawApplicationHis(long account, String password)
			throws APIException {
		IP_TRADESERV5063 ip = new IP_TRADESERV5063();
		ip.setAccount(account);
		ip.setPassword(password);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			throw new APIException(opfather.getErrCode(),
					opfather.getErrMessage());
		}
		OP_TRADESERV5063 op = (OP_TRADESERV5063) opfather;
		return op.getMap();
	}

	public boolean sendWithdrawApplication(String password,
			WithdrawApplication application) {
		IP_TRADESERV5116 ip = new IP_TRADESERV5116();
		ip.setPassword(password);
		ip.setWithdrawApplication(application);
		OPFather opfather = CSTSCaptain.getInstance().trade(ip);
		if (!opfather.isSucceed()) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 请求行情
	 * 
	 * @param nameSet
	 * @param forceToSend
	 */
	public void requireQuotes(HashSet nameSet, boolean forceToSend) {
		String names[] = DataDoc.getInstance().getBalanceInstrumentNames();
		for (int i = 0; i < names.length; i++) {
			nameSet.add(names[i]);
		}
		int size1 = this.quoteNameSet.size();
		int size2 = nameSet.size();
		if (!forceToSend) {
			if (size2 <= size1 && size2 + 10 > size1) {
				if (quoteNameSet.containsAll(nameSet)) {
					return;
				}
			}
		}
		QuoteRequest request = new QuoteRequest();
		request.setInstruments((String[]) nameSet.toArray(new String[0]));
		CSTSCaptain.getInstance().sendObject(request);
		this.quoteNameSet = nameSet;
	}

	/**
	 * 请求量
	 * 
	 * @param nameSet
	 * @param forceToSend
	 */
	public void requireVolumn(String instrument) {
		VolumnRequest request = new VolumnRequest();
		if (instrument != null) {
			request.setInstruments(new String[] { instrument });
		} else {
			request.setInstruments(new String[0]);
		}
		CSTSCaptain.getInstance().sendObject(request);
	}

	public boolean hasQuoteBeenRequired(String instrument) {
		return quoteNameSet.contains(instrument);
	}

	public static TradeAPI getInstance() {
		return instance;
	}

	// *****************************银行出入金******************************

	/**
	 * 通过账号获取账户信息
	 * 
	 * @param account
	 * @return
	 */
	public BCTradeResult_UserBankProfile getUserBankProfile(long account) {
		IP_BankServ1001 ip = new IP_BankServ1001();
		ip.setBankID(BankIDListInterface.BANK_NONE);
		// System.out.println("没有marketid没有也没有关系:暂时拿到的是为空,拿到的marketid为======="
		// + ClientAPI.getMarketId());
		ip.setMarketId(ClientAPI.getMarketId());// BankAPI.getInstance().getMarketId());
		ip.setAccount(account);
		ip.setNeedNotice(true);
		OPFather oop = BankAPI.getInstance().doTrade(ip);

		BCTradeResult_UserBankProfile result = new BCTradeResult_UserBankProfile();
		if (oop.isSucceed()) {
			OP_BankServ1001 op = (OP_BankServ1001) oop;
			result.setSucceed(true);
			result.setProfile(op.getProfile());
			result.setStream(op.getProfileStream());
			result.setNotice(op.getNotice());
		} else {
			result.setSucceed(false);
			result.setErrCode(oop.getErrCode());
			result.setErrMessage(oop.getErrMessage());
		}
		return result;
	}

	/**
	 * 根据银行ID拿到流水号,2016年8月16日14:29:11
	 * 
	 * @param bankID
	 * @param account
	 * @param orderType
	 * @return
	 */
	public BCTradeResult_DWCheck dwCheck(String bankID, long account,
			String orderType) {
		IP_BankServ2001 ip = new IP_BankServ2001();
		ip.setBankID(bankID);
		ip.setAccount(account);
		ip.setOrderType(orderType);

		OPFather oop = BankAPI.getInstance().doTrade(ip);
		BCTradeResult_DWCheck result = new BCTradeResult_DWCheck();
		if (oop.isSucceed()) {
			OP_BankServ2001 op = (OP_BankServ2001) oop;
			result.setStreamId(op.getStreamID());
			Map<String, String> bankInfoMap = op.getBankInfo();
			Map<String, IBankMetadata> bankMDMap = new HashMap<String, IBankMetadata>();
			for (Map.Entry<String, String> e : bankInfoMap.entrySet()) {
				try {
					String source = e.getValue();
					if (source == null) {
						result.setSucceed(false);
						result.setErrMessage("bankID[" + e.getKey()
								+ "] is null");
						return result;
					}
					IBankMetadata value = BankMetadataBuilder.unmarshall(e
							.getValue());
					bankMDMap.put(e.getKey(), value);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			result.setBankInfoMap(bankMDMap);
		}
		result.setSucceed(oop.isSucceed());
		result.setErrCode(oop.getErrCode());
		result.setErrMessage(oop.getErrMessage());
		return result;
	}

	/**
	 * 出金的功能
	 * 
	 * @param streamID
	 * @param bankID
	 * @param aeid
	 * @param password
	 * @param account
	 * @param amount
	 * @param comment
	 * @param otherInfo
	 * @return
	 */
	public BCTradeResult_Deposit deposit(long streamID, String bankID,
			String aeid, String password, long account, double amount,
			String comment, Map<String, String> otherInfo) {
		IP_BankServ2011 ip = new IP_BankServ2011();
		ip.setStreamID(streamID);
		ip.setBankID(bankID);
		ip.setAeid(aeid);
		if (password != null) {
			ip.setPassword(Crypt.encryptALLONE(password, aeid));
		}
		ip.setAccount(account);
		ip.setAmount(amount);
		ip.setComment(comment);
		if (otherInfo != null) {
			for (Map.Entry<String, String> e : otherInfo.entrySet()) {
				ip.setOtherInfo(e.getKey(), e.getValue());
			}
		}
		OPFather oop = BankAPI.getInstance().doTrade(ip);
		BCTradeResult_Deposit result = new BCTradeResult_Deposit();
		if (oop.isSucceed()) {
			OP_BankServ2011 op = (OP_BankServ2011) oop;
			String depositURL = op.getOtherInfo(BankServCommData.DEPOSIT_URL);
			if (depositURL != null) {
				result.setDepositUrl(depositURL);
			}
		}
		result.setSucceed(oop.isSucceed());
		result.setErrCode(oop.getErrCode());
		result.setErrMessage(oop.getErrMessage());
		return result;
	}

	/**
	 * 入金的功能
	 * 
	 * @param streamID
	 * @param bankID
	 * @param aeid
	 * @param password
	 * @param account
	 * @param amount
	 * @param comment
	 * @param otherInfo
	 * @return
	 */
	public BCTradeResult withdrawal(long streamID, String bankID, String aeid,
			String password, long account, double amount, String comment,
			Map<String, String> otherInfo) {
		BCTradeResult result = new BCTradeResult();
		BCTradeResult_CanWithdraw com = getCanWithdraw(account);
		if (!com.isSucceed()) {
			result.setSucceed(false);
			result.setErrCode(com.getErrCode());
			result.setErrMessage(com.getErrMessage());
			return result;
		}
		int status = com.getResultStatus();
		if (status == OP_TRADESERV3001.RESULT_STATUS_ACCOUNT_NEED_TO_BALANCE) {
			result.setSucceed(false);
			result.setErrCode(errcode("a001"));
			result.setErrMessage("balance first!");
			return result;
		}
		double value = com.getValue();
		if (value < amount) {
			result.setSucceed(false);
			result.setErrCode(errcode("e105"));
			result.setErrMessage("money not enough!");
			return result;
		}

		IP_BankServ2012 ip = new IP_BankServ2012();
		ip.setStreamID(streamID);
		ip.setBankID(bankID);
		ip.setAeid(aeid);
		if (password != null) {
			ip.setPassword(Crypt.encryptALLONE(password, aeid));
		}
		ip.setAccount(account);
		ip.setAmount(amount);
		ip.setComment(comment);
		if (otherInfo != null) {
			for (Map.Entry<String, String> e : otherInfo.entrySet()) {
				ip.setOtherInfo(e.getKey(), e.getValue());
			}
		}
		OPFather oop = BankAPI.getInstance().doTrade(ip);
		result.setSucceed(oop.isSucceed());
		result.setErrCode(oop.getErrCode());
		result.setErrMessage(oop.getErrMessage());
		return result;
	}

	public BCTradeResult_CanWithdraw getCanWithdraw(long account) {
		IP_TRADESERV3001 ip = new IP_TRADESERV3001();
		ip.setAccountID(account);
		ip.setCalculateType(IP_TRADESERV3001.CALCULATE_TYPE_NOMORETHANBALANCE);
		OPFather oop = BankAPI.getInstance().doTrade(ip);
		BCTradeResult_CanWithdraw result = new BCTradeResult_CanWithdraw();
		result.setSucceed(oop.isSucceed());
		result.setErrCode(oop.getErrCode());
		result.setErrMessage(oop.getErrMessage());
		if (oop.isSucceed()) {
			OP_TRADESERV3001 op = (OP_TRADESERV3001) oop;
			result.setResultStatus(op.getResultStatus());
			result.setValue(roundDouble(op.getValue(), 2));
		}
		return result;
	}

	public static double roundDouble(double price, int digits) {
		if (digits < 0) {
			throw new IllegalArgumentException(
					"The digits must be a positive integer or zero");
		}
		double n = Math.pow(10, digits);
		double absV = Math.abs(price);
		if (absV < 1 / (n * 10)) {
			return 0;
		}
		double tempV = absV * n + 0.00000001; // 鑰冭檻double绮剧‘鐨勯棶棰橈紝璁や负0.9999999==1
		return ((long) (tempV + 0.5)) / n;
	}

	private String errcode(String ec) {
		return "BankERR" + ec;
	}

}
