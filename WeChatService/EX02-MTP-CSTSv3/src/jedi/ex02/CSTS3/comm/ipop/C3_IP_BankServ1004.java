package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.IP_BankServ1004;

/**
 * 解约
 * 
 * @author admin
 * 
 */
public class C3_IP_BankServ1004 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ1004";

	public C3_IP_BankServ1004() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ1004 formatIP() {
		IP_BankServ1004 ip = new IP_BankServ1004();
		return ip;
	}


}