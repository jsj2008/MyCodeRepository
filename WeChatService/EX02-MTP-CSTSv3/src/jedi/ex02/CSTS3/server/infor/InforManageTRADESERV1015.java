package jedi.ex02.CSTS3.server.infor;

import jedi.ex02.CSTS3.comm.info.C3_InfoFather;
import jedi.ex02.CSTS3.comm.info.C3_Info_TRADESERV1015;
import jedi.v7.comm.datastruct.information.InforFather;
import jedi.v7.trade.comm.infor.Info_TRADESERV1015;
import jedi.v7.trade.comm.infor.TradeServInfoFather;

public class InforManageTRADESERV1015 extends InforManageFather {

	@Override
	protected C3_InfoFather formatInfor(InforFather infor) {
		C3_Info_TRADESERV1015 info=new C3_Info_TRADESERV1015((TradeServInfoFather) infor);
		try {
			info.parseFromSysData((Info_TRADESERV1015) infor);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return info;
	}

}