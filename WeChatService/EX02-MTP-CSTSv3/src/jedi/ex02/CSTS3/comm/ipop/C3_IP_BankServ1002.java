package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.bankserver.comm.ipop.client.IP_BankServ1002;

/**
 * 查询银行信息，并返回操作流水号
 * 
 * @author admin
 * 
 */
public class C3_IP_BankServ1002 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ1002";
	public static final String allBank = "1";

	public C3_IP_BankServ1002() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ1002 formatIP() {
		IP_BankServ1002 ip = new IP_BankServ1002();
		ip.setAllBank(isAllBank());
		return ip;
	}

	public boolean isAllBank() {
		try {
			boolean data = getEntryBoolean(C3_IP_BankServ1002.allBank);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNeedNotice(boolean needNotice) {
		setEntry(C3_IP_BankServ1002.allBank, needNotice);
	}

}