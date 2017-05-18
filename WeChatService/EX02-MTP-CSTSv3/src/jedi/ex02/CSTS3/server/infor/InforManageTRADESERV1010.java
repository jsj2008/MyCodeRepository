package jedi.ex02.CSTS3.server.infor;

import allone.Log.simpleLog.log.LogProxy;
import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.info.C3_Info_TRADESERV1010;
import jedi.v7.comm.datastruct.information.InforFather;
import jedi.v7.trade.comm.infor.Info_TRADESERV1010;
import jedi.v7.trade.comm.infor.TradeServInfoFather;

public class InforManageTRADESERV1010 extends InforManageFather {

	@Override
	protected C3_InfoFather formatInfor(InforFather infor) {
		LogProxy.OutPrintln("CSTS v3: InforManageTRADESERV1010 "
				+ infor.getAeid());
		C3_Info_TRADESERV1010 info = new C3_Info_TRADESERV1010(
				(TradeServInfoFather) infor);
		try {
			info.parseFromSysData((Info_TRADESERV1010) infor);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return info;
	}

}
