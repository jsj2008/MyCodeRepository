package jedi.ex01.CSTS3.comm.ipop;


public class OP_TRADESERV5001 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5001";

	public static final String result = "1";
	public static final String loginTime = "2";
	public static final String fixedIPVector = "3";
	public static final String maxOnlineNumber = "4";
	public static final String accounts = "5";
	
	public static final String passwordNeedChange = "6";
	public static final String groupVec = "7";

	public OP_TRADESERV5001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getResult() {
		try {
			int data=getEntryInt(OP_TRADESERV5001.result);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResult(int result) {
		setEntry(OP_TRADESERV5001.result, result);
	}

	public long getLoginTime() {
		try {
			long data=getEntryLong(OP_TRADESERV5001.loginTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLoginTime(long loginTime) {
		setEntry(OP_TRADESERV5001.loginTime, loginTime);
	}

	public String[] getFixedIPVector() {
		try {
			String[] data=getEntryObjectVec(OP_TRADESERV5001.fixedIPVector,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFixedIPVector(String[] fixedIPVector) {
		setEntry(OP_TRADESERV5001.fixedIPVector, fixedIPVector);
	}

	public int getMaxOnlineNumber() {
		try {
			int data=getEntryInt(OP_TRADESERV5001.maxOnlineNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOnlineNumber(int maxOnlineNumber) {
		setEntry(OP_TRADESERV5001.maxOnlineNumber, maxOnlineNumber);
	}

	public Long[] getAccounts() {
		try {
			Long[] data=getEntryObjectVec(OP_TRADESERV5001.accounts,new Long[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccounts(Long[] accounts) {
		setEntry(OP_TRADESERV5001.accounts, accounts);
	}

	
	public String[] getGroupVec() {
		try {
			String[] data=getEntryObjectVec(OP_TRADESERV5001.groupVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupVec(String[] groupVec) {
		setEntry(OP_TRADESERV5001.groupVec, groupVec);
	}
	
	public boolean getPasswordNeedChange() {
		try {
			boolean data=getEntryBoolean(OP_TRADESERV5001.groupVec);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setPasswordNeedChange(Boolean passwordNeedChange) {
		setEntry(OP_TRADESERV5001.passwordNeedChange, passwordNeedChange);
	}

}