package jedi.ex02.CSTS3.server.trade4client;

import java.util.HashMap;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.debug.DebugLogCaptain;
import jedi.ex02.CSTS3.server.doc.ClientIPFixer;
import jedi.v7.comm.ServCallNameTable;
import jedi.v7.comm.datastruct.DB.MTP4CommDataInterface;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.report.server.ipop.IPFather4Report;
import jedi.v7.trade.comm.IPOP.TradeServIPFather;
import allone.CADTS.comm.ErrCodeTable;
import allone.CADTS.proxy.exception.CADTSException;
import allone.Log.simpleLog.log.LogProxy;

public class ClientTradeCaptain {

	private final HashMap<String, String> errCodeMap = new HashMap<String, String>();
	{
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_OTHER,
				IPOPErrCodeTable.ERR_CADTS_OTHER);
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_TIMEOUT,
				IPOPErrCodeTable.ERR_CADTS_TIMEOUT);
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_NETERR,
				IPOPErrCodeTable.ERR_CADTS_SERVNOTFIND);
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_FORMATERR,
				IPOPErrCodeTable.ERR_CADTS_NETERR);
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_REMOTEERR,
				IPOPErrCodeTable.ERR_CADTS_FORMATERR);
		errCodeMap.put(allone.CADTS.comm.ErrCodeTable.ERR_BACKDATA_REMOTEERR,
				IPOPErrCodeTable.ERR_CADTS_BACKDATA_REMOTEERR);
	};
	private final HashMap<String, ClientTradeFather> tradeMap = new HashMap<String, ClientTradeFather>();

	// 发送到ClientTrade
	public C3_OPFather doClientTrade(C3_IPFather ip, String aeid,
			String ipaddress) {
		C3_OPFather op = null;
		ClientTradeFather tf = tradeMap.get(ip.getID());
		if (tf == null) {
			// 反射ipop
			try {
				tf = (ClientTradeFather) Class.forName(
						getClass().getPackage().getName() + ".ClientTrade"
								+ ip.getID()).newInstance();
				// System.out.println(getClass().getPackage().getName()+".ClientTrade"+ip.getID());
				tradeMap.put(ip.getID(), tf);
				DebugLogCaptain.getInstance().log(ipaddress,
						"doClientTrade : " + tf);
			} catch (Exception e) {
				op = new C3_OPFather(ip);
				op.setErrCode(ErrCodeTable.ERR_OTHER);
				op.setErrMessage("Trade Code " + ip.getID() + " not find!");
				op.setSucceed(false);
				LogProxy.printTrade(ip.getID(), ip, op, op.isSucceed());
				return op;
			}
		}
		C3_OPFather opfather = tf.call_trade(ip, aeid, ipaddress);
		LogProxy.printTrade(ip.getID(), ip, opfather, opfather.isSucceed());
		return opfather;
	}

	public OPFather doSysTrade(IPFather ip, String aeid, String ipaddress) {
		OPFather op = null;
		// if(ip instanceof IPFather4Report){
		// LogProxy.printTrade(ip.get_ID(), ip, null, true);
		// }
		long startTime = System.currentTimeMillis();
		DebugLogCaptain.getInstance().log(ipaddress, "doSysTrade : " + ip);
		try {
			if (ip instanceof TradeServIPFather) {
				TradeServIPFather tip = (TradeServIPFather) ip;
				tip.set_fromServer(StaticContext.getCSConfigCaptain()
						.getCstsName());
				tip.set_toServer(ServCallNameTable.SERV_MTP4_TRADESERVER);
				tip.setSubmitTradeType(MTP4CommDataInterface.ROLETYPE_USER_WEB);
				tip.setSubmitOperatorName(aeid);
				tip.setIPAddress(ipaddress);
				ClientIPFixer.forcedToFixIP(tip, aeid);
				op = (OPFather) StaticContext.getCADTSCaptain().trade(
						ServCallNameTable.SERV_MTP4_TRADESERVER,
						ServCallNameTable.FUN_MTP4_TRADE,
						ServCallNameTable.DATA_MTP4_DATA, ip);
			} else if (ip instanceof IPFather4Report) {
				IPFather4Report tip = (IPFather4Report) ip;
				tip.set_fromServer(StaticContext.getCSConfigCaptain()
						.getCstsName());
				tip.set_toServer(ServCallNameTable.SERV_MTP4_REPORTSERVER);
				op = (OPFather) StaticContext.getCADTSCaptain().trade(
						ServCallNameTable.SERV_MTP4_REPORTSERVER,
						ServCallNameTable.FUN_MTP4_TRADE,
						ServCallNameTable.DATA_MTP4_DATA, ip);
			} else if (ip.get_ID().startsWith("QG")) {
				// ip.set_fromServer(StaticContext.getConfigCaptain().getCSTSName());
				// ip.set_toServer(ServCallNameTable.SERV_MTP4_QG);
				// op=(OPFather)
				// StaticContext.getCADTSCaptain().trade(ServCallNameTable.SERV_MTP4_QG,
				// ServCallNameTable.FUN_MTP4_TRADE,
				// ServCallNameTable.DATA_MTP4_DATA, ip);
			} else if (ip.get_ID().startsWith("QDB")) {
				// if (ip.get_ID().startsWith("QDB1002")) {
				// IP_QDB1002 qdb1002 = (IP_QDB1002)ip;
				// qdb1002.getInstrument();
				// qdb1002.getCycle();
				// }
				// ip.set_fromServer(StaticContext.getConfigCaptain().getCSTSName());
				// ip.set_toServer(ServCallNameTable.SERV_MTP4_QDB);
				// op=(OPFather)
				// StaticContext.getCADTSCaptain().trade(ServCallNameTable.SERV_MTP4_QDB,
				// ServCallNameTable.FUN_MTP4_TRADE,
				// ServCallNameTable.DATA_MTP4_DATA, ip);
				// op = (OPFather)StaticContext.getQuoteSourceCaptain().
				// QuoteSourceCaptain.getInstance().getHistoricalData(ip.getin,
				// cycle)

				// C3_OPFather opFather = new C3_OPFather(ip);
				// op = new OPFather(ip);

			} else if (ip.get_ID().startsWith("CTRL")) {
				ip.set_fromServer(StaticContext.getCSConfigCaptain()
						.getCstsName());
				ip.set_toServer(ServCallNameTable.SERV_MTP4_CTRL);
				op = (OPFather) StaticContext.getCADTSCaptain().trade(
						ServCallNameTable.SERV_MTP4_CTRL,
						ServCallNameTable.FUN_MTP4_TRADE,
						ServCallNameTable.DATA_MTP4_DATA, ip);
			} else if (ip.get_ID().startsWith("BankServ")) {
				ip.set_fromServer(StaticContext.getCSConfigCaptain()
						.getCstsName());
				ip.set_toServer(ServCallNameTable.SERV_MTP4_BANKSERVER);
				op = (OPFather) StaticContext.getCADTSCaptain().trade(
						ServCallNameTable.SERV_MTP4_BANKSERVER,
						ServCallNameTable.FUN_MTP4_TRADE,
						ServCallNameTable.DATA_MTP4_DATA, ip);
			}

			else {
				op = new OPFather(ip);
				op.setSucceed(false);
				op.setErrCode(ErrCodeTable.ERR_OTHER);
				op.setErrMessage("can not do this trade!");
			}
		} catch (CADTSException e) {
			LogProxy.printException(e);
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(__translateCADTSErrCodeToMTP4ErrCode(e.getErrCode()));
			op.setErrMessage(e.toString() + "   " + e.getErrCode());
			// StaticContext.getMonitorCaptain().sendIPOPInfoToProbe(
			// ip.get_ID(), "", op.getErrCode(), op.getErrMessage());
		} catch (Exception e) {
			LogProxy.printException(e);
			op = new OPFather(ip);
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_CADTS_EXCEPTION);
			op.setErrMessage(e.getMessage());
			// StaticContext.getMonitorCaptain().sendIPOPInfoToProbe(
			// ip.get_ID(), "", op.getErrCode(), op.getErrMessage());
		}
		op.set_tradeUsedTime(System.currentTimeMillis() - startTime);
		LogProxy.printTrade(ip.get_ID(), ip, op, op.isSucceed());
		return op;

	}

	private String __translateCADTSErrCodeToMTP4ErrCode(String cadtsErrCode) {
		if (errCodeMap.containsKey(cadtsErrCode)) {
			return errCodeMap.get(cadtsErrCode);
		}
		if (cadtsErrCode.startsWith(ErrCodeTable.ERR_SERVNOTFIND)) {
			return IPOPErrCodeTable.ERR_CADTS_SERVNOTFIND;
		}
		return cadtsErrCode;
	}

}
