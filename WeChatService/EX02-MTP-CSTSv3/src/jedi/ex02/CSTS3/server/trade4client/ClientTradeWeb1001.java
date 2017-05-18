package jedi.ex02.CSTS3.server.trade4client;

import java.util.HashMap;
import java.util.Locale;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_Web1001;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_Web1001;
import jedi.ex02.CSTS3.comm.struct.C3_Instrument;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.quoteSource.QuoteSourceCaptain;
import jedi.v7.comm.datastruct.DB.InstrumentsAccountCfg;
import jedi.v7.comm.datastruct.DB.InstrumentsGroupCfg;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.ctrl.comm.IPOP.IP_CTRL2001;
import jedi.v7.ctrl.comm.IPOP.IP_CTRL2002;
import jedi.v7.ctrl.comm.IPOP.OP_CTRL2001;
import jedi.v7.ctrl.comm.IPOP.OP_CTRL2002;
import jedi.v7.quote.common.QuoteData;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5030;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5040;
import jedi.v7.trade.comm.IPOP.IP_TRADESERV5041;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5030;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5040;
import jedi.v7.trade.comm.IPOP.OP_TRADESERV5041;

public class ClientTradeWeb1001 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid, String ipaddress) {
		C3_IP_Web1001 ip = (C3_IP_Web1001) _ip;
		C3_OP_Web1001 op = new C3_OP_Web1001(ip);
		HashMap<String, C3_Instrument> instMap = new HashMap<String, C3_Instrument>();
		try {
			// ////////////////
			IP_CTRL2001 ip2001 = new IP_CTRL2001();
			String[] locales = ip.getLocale().split("_");
			if (locales.length == 1) {
				ip2001.setLocale(new Locale(locales[0]));
			} else if (locales.length == 2) {
				ip2001.setLocale(new Locale(locales[0], locales[1]));
			} else if (locales.length == 3) {
				ip2001.setLocale(new Locale(locales[0], locales[1], locales[2]));
			}
			OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(
					ip2001, aeid, ipaddress);
			if (fop.isSucceed()) {
				OP_CTRL2001 op2001 = (OP_CTRL2001) fop;
				op.parseFromSysData(op2001);
				// /////////////
				IP_CTRL2002 ip2002 = new IP_CTRL2002();
				if (ip.getKeySet() != null) {
					ip2002.addKey(ip.getKeySet());
				}
				if (locales.length == 1) {
					ip2002.setLocale(new Locale(locales[0]));
				} else if (locales.length == 2) {
					ip2002.setLocale(new Locale(locales[0], locales[1]));
				} else if (locales.length == 3) {
					ip2002.setLocale(new Locale(locales[0], locales[1],
							locales[2]));
				}
				fop = StaticContext.getClientTradeCaptain().doSysTrade(ip2002,
						aeid, ipaddress);
				if (fop.isSucceed()) {
					OP_CTRL2002 op2002 = (OP_CTRL2002) fop;
					op.parseFromSysData(op2002);
					// ///////////////
					IP_TRADESERV5030 ip5030 = new IP_TRADESERV5030();
					fop = StaticContext.getClientTradeCaptain().doSysTrade(
							ip5030, aeid, ipaddress);
					if (fop.isSucceed()) {
						OP_TRADESERV5030 op5030 = (OP_TRADESERV5030) fop;
						op.parseFromSysData(op5030);
						C3_Instrument[] insts = op.getInstruments();
						for (C3_Instrument inst : insts) {
							instMap.put(inst.getInstrument(), inst);
						}
						// ////////////////
						IP_TRADESERV5040 ip5040 = new IP_TRADESERV5040();
						ip5040.setUserName(aeid);
						fop = StaticContext.getClientTradeCaptain().doSysTrade(
								ip5040, aeid, ipaddress);
						if (fop.isSucceed()) {
							OP_TRADESERV5040 op5040 = (OP_TRADESERV5040) fop;
							if (ip.getAccountId() <= 0) {
								ip.setAccountId(op5040.getAccountStrategyVec()[0]
										.getAccount());
							}
							op.parseFromSysData(op5040, ip.getAccountId());
							for (InstrumentsGroupCfg igc : op5040
									.getInstrumentGroupCfgVec()) {
								if (!igc.getGroupName().equalsIgnoreCase(
										op.getAccount().getGroupName())) {
									continue;
								}
								C3_Instrument inst = instMap.get(igc
										.getInstrument());
								inst.parseFromSysData(igc);
							}
							for (InstrumentsAccountCfg iac : op5040
									.getInstrumentAccountCfgVec()) {
								if (iac.getAccount() != ip.getAccountId()) {
									continue;
								}
								C3_Instrument inst = instMap.get(iac
										.getInstrument());
								inst.parseFromSysData(iac);
							}
							// ///////////////////
							IP_TRADESERV5041 ip5041 = new IP_TRADESERV5041();
							ip5041.setAccountID(ip.getAccountId());
							fop = StaticContext.getClientTradeCaptain()
									.doSysTrade(ip5041, aeid, ipaddress);
							if (fop.isSucceed()) {
								OP_TRADESERV5041 op5041 = (OP_TRADESERV5041) fop;
								op.parseFromSysData(op5041);

								QuoteData[] dataList;
								try {
									dataList = QuoteSourceCaptain.getInstance()
											.getQuoteVec();
									op.parseFromSysData(dataList);
									fop.setSucceed(true);
								} catch (Exception e1) {
									e1.printStackTrace();
									fop.setSucceed(false);
									fop.setErrCode(IPOPErrCodeTable.ERR_Unknown);
									fop.setErrMessage(e1.getMessage());
								}

							}
						}
					}
				}
			}
			op.setSucceed(fop.isSucceed());
			op.setErrCode(fop.getErrCode());
			op.setErrMessage(fop.getErrMessage());
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		return op;
	}
}
