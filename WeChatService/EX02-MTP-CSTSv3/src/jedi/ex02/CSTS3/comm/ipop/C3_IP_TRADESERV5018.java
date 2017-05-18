package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV5018;


public class C3_IP_TRADESERV5018 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV5018";


	public C3_IP_TRADESERV5018(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV5018 formatIP() {
		IP_TRADESERV5018 ip=new IP_TRADESERV5018();
		return ip;
	}


}