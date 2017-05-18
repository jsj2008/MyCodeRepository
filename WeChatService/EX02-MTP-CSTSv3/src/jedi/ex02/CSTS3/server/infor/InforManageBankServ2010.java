package jedi.ex02.CSTS3.server.infor;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.info.C3_Info_BANKSERV2010;
import jedi.v7.bankserver.comm.infor.client.INFO_BankServ2010;
import jedi.v7.comm.datastruct.information.InforFather;
import allone.Log.simpleLog.log.LogProxy;

public class InforManageBankServ2010 extends InforManageFather {
	@Override
	protected C3_InfoFather formatInfor(InforFather infor) {
		LogProxy.OutPrintln("Info_Bankserv 2010:"+infor.toString());
		C3_Info_BANKSERV2010 info = new C3_Info_BANKSERV2010(infor);
		try {
			info.parseFromSysData((INFO_BankServ2010) infor);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return info;
	}
}
