package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5010;


public class C3_IP_TRADESERV5010 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5010";


	public C3_IP_TRADESERV5010(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5010 formatIP() {
		IP_TRADESERV5010 ip=new IP_TRADESERV5010();
		return ip;
	}


}