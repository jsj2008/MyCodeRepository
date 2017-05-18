package jedi.ex02.CSTS3.server.trade4client;

import java.util.ArrayList;
import java.util.HashSet;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_REPORT2901;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_REPORT2901;
import jedi.ex02.CSTS3.comm.struct.C3_ClosedPositionsDetails;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.report.server.ipop.IP_REPORT2018;
import jedi.v7.report.server.ipop.OP_REPORT2018;
import jedi.v7.report.server.struct.ClosedPositionsDetails;

public class ClientTradeREPORT2901 extends ClientTradeFather {

	@SuppressWarnings("unchecked")
	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid, String ipaddress) {
		C3_IP_REPORT2901 ip = (C3_IP_REPORT2901) _ip;
		C3_OP_REPORT2901 op = new C3_OP_REPORT2901(ip);
		IP_REPORT2018 fip = new IP_REPORT2018();
		HashSet<Integer> tableSet = new HashSet<Integer>();
		tableSet.add(IP_REPORT2018.TABLE_CLOSEDPOSITION);
		fip.setTableSet(tableSet);
		fip.setType(IP_REPORT2018.TYPE_ACCOUNT);
		fip.setAccount(ip.getAccount());
		fip.setFromTradeDay(ip.getFromTradeDay());
		fip.setToTradeDay(ip.getEndTradeDay());
		OPFather oop = StaticContext.getClientTradeCaptain().doSysTrade(fip, aeid, ipaddress);
		try {
			op.parseFromSysData(oop);
			if (oop.isSucceed()) {
				op.parseFromSysData(oop);
				OP_REPORT2018 fop = (OP_REPORT2018) oop;
				ArrayList list = fop.getTable(IP_REPORT2018.TABLE_CLOSEDPOSITION);
				ArrayList<C3_ClosedPositionsDetails> dataList = new ArrayList<C3_ClosedPositionsDetails>();
				for (Object obj : list) {
					ClosedPositionsDetails cp = (ClosedPositionsDetails) obj;
					C3_ClosedPositionsDetails data = new C3_ClosedPositionsDetails();
					data.parseFromSysData(cp);
					dataList.add(data);
				}
				op.setClosedPositionVec(dataList.toArray(new C3_ClosedPositionsDetails[0]));
			} else {
			}
		} catch (Exception e) {
			e.printStackTrace();
			op.setSucceed(false);
			op.setErrCode(IPOPErrCodeTable.ERR_Unknown);
			op.setErrMessage(e.getMessage());
		}
		op.setSucceed(oop.isSucceed());
		op.setErrCode(oop.getErrCode());
		op.setErrMessage(oop.getErrMessage());
		return op;
	}

}
