package jedi.ex01.CSTS3.proxy.client.ping;

import jedi.ex01.CSTS3.comm.jsondata.CSTSPing;


public interface PingDealerable {
	public boolean sendPing(CSTSPing ping);
	public void onPingResult(PingResult pingResult);
}
