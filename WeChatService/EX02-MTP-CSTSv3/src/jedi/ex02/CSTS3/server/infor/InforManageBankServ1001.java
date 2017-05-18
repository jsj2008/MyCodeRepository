package jedi.ex02.CSTS3.server.infor;

import allone.Log.simpleLog.log.LogProxy;
import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.info.C3_Info_BANKSERV1001;
import jedi.v7.bankserver.comm.infor.dealer.INFO_BankServ1001;
import jedi.v7.comm.datastruct.information.InforFather;

public class InforManageBankServ1001 extends InforManageFather {
	@Override
	protected C3_InfoFather formatInfor(InforFather infor) {
		LogProxy.OutPrintln("Info_Bankserv1001:"+infor.toString());
		C3_Info_BANKSERV1001 info = new C3_Info_BANKSERV1001(infor);
		try {
			info.parseFromSysData((INFO_BankServ1001)infor);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return info;
	}

}
