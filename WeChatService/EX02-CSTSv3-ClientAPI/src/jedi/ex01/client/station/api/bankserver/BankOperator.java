package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;
import jedi.ex01.client.station.api.ClientAPI;
import jedi.ex01.client.station.api.CSTS.CSTSCaptain;
import jedi.ex01.client.station.api.event.API_IDEvent;
import jedi.ex01.client.station.api.event.API_IDEventCaptain;

public class BankOperator implements BankOperateInterface {

	private static BankOperator instance = new BankOperator();

	public static BankOperator getInstance() {
		return instance;
	}

	public boolean init() {
		return BankAPI.getInstance().init(this);
	}

	@Override
	public int getMarketId() {
		return ClientAPI.getMarketId();
	}

	@Override
	public OPFather doTrade(IPFather arg0) {
		return CSTSCaptain.getInstance().trade(arg0);
	}

	@Override
	public boolean onResInfo(InfoFather infor) {
		return BankAPI.getInstance().recInfor(infor);
	}

	@Override
	public void fireEventChanged(String arg0, Object arg1, boolean arg2,
			String arg3) {
		API_IDEventCaptain.getInstance().fireEventChanged(new API_IDEvent());
	}

}
