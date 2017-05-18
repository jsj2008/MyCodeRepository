package jedi.ex02.CSTS3.server.trade4client;

import java.util.ArrayList;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_QDB1003;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_QDB1003;
import jedi.ex02.CSTS3.server.quoteSource.QuoteSourceCaptain;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.quote.common.HistoricData;
import jedi.v7.quoteDB.comm.IPOP.OP_QDB1003;

public class ClientTradeQDB1003 extends ClientTradeFather {

	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid, String ipaddress) {
		C3_IP_QDB1003 ip = (C3_IP_QDB1003) _ip;
		C3_OP_QDB1003 op = new C3_OP_QDB1003(ip);
		IPFather fip = ip.formatIP();
//		OPFather fop = StaticContext.getClientTradeCaptain().doSysTrade(fip, aeid, ipaddress);

		ArrayList<HistoricData> List = new ArrayList<HistoricData>();
		
		OP_QDB1003 fop = new OP_QDB1003(fip);
		
		HistoricData[] dataList;
		try {
			dataList = QuoteSourceCaptain.getInstance().getHistoricalData(ip.getInstrument(), ip.getCycle());
			for (int i = 0; i < dataList.length; i++) {
				List.add(dataList[i]);
			}
			fop.setList(List);
			fop.setSucceed(true);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			fop.setSucceed(false);
			fop.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			fop.setErrMessage(e1.getMessage());
		}
		
		//////
		
		try {
			if (fop.isSucceed()) {
				op.parseFromSysData((OP_QDB1003) fop);
			} else {
				op.parseFromSysData(fop);
			}
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		op.setSucceed(fop.isSucceed());
		op.setErrCode(fop.getErrCode());
		op.setErrMessage(fop.getErrMessage());
		return op;
	}

}
