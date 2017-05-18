package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5061;


public class C3_IP_TRADESERV5061 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5061";


	public C3_IP_TRADESERV5061(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5061 formatIP() {
		IP_TRADESERV5061 ip=new IP_TRADESERV5061();
		return ip;
	}


}