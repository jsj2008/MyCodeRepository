package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.OP_TRADESERV5001;


public class C3_OP_TRADESERV5001 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV5001";

	public static final String result = "1";
	public static final String loginTime = "2";
	public static final String fixedIPVector = "3";
	public static final String maxOnlineNumber = "4";
	
	public static final String passwordNeedChange = "6";
	public static final String groupVec = "7";
	
	public static final String accounts = "5";

	public C3_OP_TRADESERV5001(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_TRADESERV5001 data) throws Exception {
		super.parseFromSysData(data);
		setResult(data.getResult());
		setLoginTime(data.getLoginTime());
		setFixedIPVector(data.getFixedIPVector());
		setMaxOnlineNumber(data.getMaxOnlineNumber());
		
		setPasswordNeedChange(data.isPasswordNeedChange());
		setGroupVec(data.getGroupVec());
//		setAccounts(data.getAccounts());
	}


	public int getResult() {
		try {
			int data=getEntryInt(C3_OP_TRADESERV5001.result);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResult(int result) {
		setEntry(C3_OP_TRADESERV5001.result, result);
	}

	public long getLoginTime() {
		try {
			long data=getEntryLong(C3_OP_TRADESERV5001.loginTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLoginTime(long loginTime) {
		setEntry(C3_OP_TRADESERV5001.loginTime, loginTime);
	}

	public String[] getFixedIPVector() {
		try {
			String[] data=getEntryObjectVec(C3_OP_TRADESERV5001.fixedIPVector,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixedIPVector(String[] fixedIPVector) {
		setEntry(C3_OP_TRADESERV5001.fixedIPVector, fixedIPVector);
	}

	public int getMaxOnlineNumber() {
		try {
			int data=getEntryInt(C3_OP_TRADESERV5001.maxOnlineNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOnlineNumber(int maxOnlineNumber) {
		setEntry(C3_OP_TRADESERV5001.maxOnlineNumber, maxOnlineNumber);
	}

	public Long[] getAccounts() {
		try {
			Long[] data=getEntryObjectVec(C3_OP_TRADESERV5001.accounts,new Long[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccounts(Long[] accounts) {
		setEntry(C3_OP_TRADESERV5001.accounts, accounts);
	}

	public String[] getGroupVec() {
		try {
			String[] data=getEntryObjectVec(C3_OP_TRADESERV5001.groupVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupVec(String[] groupVec) {
		setEntry(C3_OP_TRADESERV5001.groupVec, groupVec);
	}
	
	public boolean getPasswordNeedChange() {
		try {
			boolean data=getEntryBoolean(C3_OP_TRADESERV5001.groupVec);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setPasswordNeedChange(Boolean passwordNeedChange) {
		setEntry(C3_OP_TRADESERV5001.passwordNeedChange, passwordNeedChange);
	}

}