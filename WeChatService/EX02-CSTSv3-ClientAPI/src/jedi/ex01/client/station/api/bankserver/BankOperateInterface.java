package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;

public interface BankOperateInterface {

	int getMarketId();

	OPFather doTrade(IPFather ip);

	boolean onResInfo(InfoFather info);

	void fireEventChanged(String eventName, Object eventData,
			boolean eventResult, String eventSourceID);
}
