package jedi.ex02.CSTS3.server.trade4client;
//package jedi.ex01.CSTS3.server.trade4client;
//
//import jedi.ex01.CSTS3.comm.ipop.C3_IPFather;
//import jedi.ex01.CSTS3.comm.ipop.C3_IP_TRADESERV5027;
//import jedi.ex01.CSTS3.comm.ipop.C3_OPFather;
//import jedi.ex01.CSTS3.comm.ipop.C3_OP_TRADESERV5027;
//import jedi.ex01.CSTS3.server.StaticContext;
//import jedi.v7.comm.datastruct.IPOP.IPFather;
//import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
//import jedi.v7.comm.datastruct.IPOP.OPFather;
//import jedi.v7.trade.comm.IPOP.OP_TRADESERV5027;
//
//public class ClientTradeTRADESERV5027 extends ClientTradeFather{
//	public C3_OPFather doTrade(C3_IPFather _ip, String aeid,
//			String ipaddress) {
//		System.out.println("test...5027");
//		C3_IP_TRADESERV5027 ip = (C3_IP_TRADESERV5027) _ip;
//		C3_OP_TRADESERV5027 op = new C3_OP_TRADESERV5027(ip);
////		HashMap<String, C3_Instrument> instMap=new HashMap<String, C3_Instrument>();
//		IPFather fip = ip.formatIP();
//		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip,
//				aeid, ipaddress);
//		try {
//			op.parseFromSysData(fop);
//			if (fop.isSucceed()) {
//				OP_TRADESERV5027 op5027 = (OP_TRADESERV5027) fop;
//				op.parseFromSysData(op5027);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			op.setSucceed(false);
//			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
//			op.setErrMessage(e.getMessage());
//		}
//		op.setSucceed(fop.isSucceed());
//		op.setErrCode(fop.getErrCode());
//		op.setErrMessage(fop.getErrMessage());
//		return op;
//	}
//}
