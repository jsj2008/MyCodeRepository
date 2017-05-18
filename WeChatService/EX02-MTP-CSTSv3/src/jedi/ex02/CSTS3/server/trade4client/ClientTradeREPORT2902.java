package jedi.ex02.CSTS3.server.trade4client;

import java.util.ArrayList;
import java.util.HashSet;

import jedi.ex02.CSTS3.comm.ipop.C3_IPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_IP_REPORT2902;
import jedi.ex02.CSTS3.comm.ipop.C3_OPFather;
import jedi.ex02.CSTS3.comm.ipop.C3_OP_REPORT2902;
import jedi.ex02.CSTS3.comm.struct.C3_MoneyAccountStreamDetails;
import jedi.ex02.CSTS3.server.StaticContext;
import jedi.v7.comm.datastruct.IPOP.IPOPErrCodeTable;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.report.server.ipop.IP_REPORT2018;
import jedi.v7.report.server.ipop.OP_REPORT2018;
import jedi.v7.report.server.struct.MoneyAccountStreamDetails;

public class ClientTradeREPORT2902 extends ClientTradeFather {

	@SuppressWarnings("unchecked")
	@Override
	protected C3_OPFather doTrade(C3_IPFather _ip, String aeid, String ipaddress) {
		C3_IP_REPORT2902 ip = (C3_IP_REPORT2902) _ip;
		C3_OP_REPORT2902 op = new C3_OP_REPORT2902(ip);
		IP_REPORT2018 fip = new IP_REPORT2018();
		HashSet<Integer> tableSet = new HashSet<Integer>();
		tableSet.add(IP_REPORT2018.TABLE_ACCOUNTSTREAM);
		fip.setTableSet(tableSet);
		fip.setType(IP_REPORT2018.TYPE_ACCOUNT);
		fip.setAccount(ip.getAccount());
		fip.setFromTradeDay(ip.getFromTradeDay());
		fip.setToTradeDay(ip.getEndTradeDay());
		if(ip.getTypeVec()!=null&&ip.getTypeVec().length>0) {
			int[] accountStreamTypes=new int[ip.getTypeVec().length];
			for (int i = 0; i < accountStreamTypes.length; i++) {
				accountStreamTypes[i]=ip.getTypeVec()[i];
			}
			fip.setAccountStreamTypes(accountStreamTypes);
		}
		OPFather oop = StaticContext.getClientTradeCaptain().doSysTrade(fip, aeid, ipaddress);
		try {
			op.parseFromSysData(oop);
			if (oop.isSucceed()) {
				op.parseFromSysData(oop);
				OP_REPORT2018 fop = (OP_REPORT2018) oop;
				ArrayList list = fop.getTable(IP_REPORT2018.TABLE_ACCOUNTSTREAM);
				ArrayList<C3_MoneyAccountStreamDetails> dataList = new ArrayList<C3_MoneyAccountStreamDetails>();
				for (Object obj : list) {
					MoneyAccountStreamDetails cp = (MoneyAccountStreamDetails) obj;
					C3_MoneyAccountStreamDetails data = new C3_MoneyAccountStreamDetails();
					data.parseFromSysData(cp);
					dataList.add(data);
				}
				op.setAccountStreamVec(dataList.toArray(new C3_MoneyAccountStreamDetails[0]));
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
