package jedi.ex01.client.station.api.bankserver;

import jedi.ex01.client.station.api.info.InfoCaptain;
import jedi.ex01.CSTS3.comm.info.InfoFather;
import jedi.ex01.CSTS3.comm.ipop.IPFather;
import jedi.ex01.CSTS3.comm.ipop.OPFather;

public class BankAPI {

	public static BankAPI instance = new BankAPI();

	private BankAPI() {
	}

	public static BankAPI getInstance() {
		return instance;
	}

	private BankOperateInterface opt;

	public boolean init(BankOperateInterface opt) {
		this.opt = opt;
		return true;
	}

	public int getMarketId() {
		return opt.getMarketId();
	}

	public OPFather doTrade(IPFather ip) {
		if (ip instanceof BankServIPFather) {
			BankServIPFather svrIp = (BankServIPFather) ip;
			// svrIp.setMarketId(this.getMarketId());
		}
		return opt.doTrade(ip);
	}

	public void fireEventChanged(String eventName, Object eventData,
			boolean eventResult, String eventSourceID) {
		opt.fireEventChanged(eventName, eventData, eventResult, eventSourceID);
	}

	public boolean recInfor(InfoFather infor) {

		if (infor == null) {
			return false;
		}

		return InfoCaptain.getInstance().onInfo(infor);
	}
}
