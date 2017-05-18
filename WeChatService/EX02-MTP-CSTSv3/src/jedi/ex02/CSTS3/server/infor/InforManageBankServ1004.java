package jedi.ex02.CSTS3.server.infor;

import allone.Log.simpleLog.log.LogProxy;
import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.info.C3_Info_BANKSERV1004;
import jedi.v7.bankserver.comm.infor.dealer.INFO_BankServ1004;
import jedi.v7.comm.datastruct.information.InforFather;

public class InforManageBankServ1004 extends InforManageFather {
	@Override
	protected C3_InfoFather formatInfor(InforFather infor) {
		LogProxy.OutPrintln("Info_Bankserv 1004:"+infor.toString());
		C3_Info_BANKSERV1004 info = new C3_Info_BANKSERV1004(infor);
		try {
			info.parseFromSysData((INFO_BankServ1004) infor);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return info;
	}
}
