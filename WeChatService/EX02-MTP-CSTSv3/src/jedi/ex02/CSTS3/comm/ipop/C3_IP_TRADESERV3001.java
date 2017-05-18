package jedi.ex02.CSTS3.comm.ipop;

import jedi.v7.trade.comm.IPOP.IP_TRADESERV3001;

/**
 * 银行出入金2016年8月10日14:16:22
 * 
 * @author ALLONE
 * 
 */
public class C3_IP_TRADESERV3001 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_TRADESERV3001";

	public C3_IP_TRADESERV3001() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_TRADESERV3001 formatIP() {
		IP_TRADESERV3001 ip = new IP_TRADESERV3001();
		ip.setSearchType(getSearchType());
		ip.setAccountVec(getAccountVec());
		ip.setGroupVec(getGroupVec());
		ip.setAccountID(getAccountID());
		ip.setCalculateType(getCalculateType());

		return ip;
	}

	public final static int SEARCHTYPE_ALL = 10;
	public final static int SEARCHTYPE_account = 0;
	public final static int SEARCHTYPE_ACCOUNT = 2;
	public final static int SEARCHTYPE_ACCOUNTVEC = 4;
	public final static int SEARCHTYPE_GROUPVEC = 5;
	public final static int CALCULATE_TYPE_EQUITY = 0;
	public final static int CALCULATE_TYPE_NOMORETHANBALANCE = 1;

	public static final String searchType = "1";
	public static final String accountVec = "2";
	public static final String groupVec = "3";
	public static final String accountID = "4";
	public static final String calculateType = "5";

	// private final int searchType = SEARCHTYPE_ACCOUNT;
	public int getSearchType() {
		try {
			int data = getEntryInt(C3_IP_TRADESERV3001.searchType);
			return data;
		} catch (RuntimeException e) {
			return SEARCHTYPE_ACCOUNT;
		}
	}

	public void setSearchType(int searchType) {
		setEntry(C3_IP_TRADESERV3001.searchType, searchType);
	}

	// private long[] accountVec;

	public long[] getAccountVec() {
		try {
			long[] data = getEntryObject(C3_IP_TRADESERV3001.accountVec);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAccountVec(long[] accountVec) {
		setEntry(C3_IP_TRADESERV3001.accountVec, accountVec);
	}

	// private String groupVec[];

	public String[] getGroupVec() {
		try {
			String[] data = getEntryObject(C3_IP_TRADESERV3001.groupVec);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupVec(String[] groupVec) {
		setEntry(C3_IP_TRADESERV3001.groupVec, groupVec);
	}

	// private long accountID;

	public long getAccountID() {
		try {
			long data = getEntryLong(C3_IP_TRADESERV3001.accountID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccountID(long accountID) {
		setEntry(C3_IP_TRADESERV3001.accountID, accountID);
	}

	// private final int calculateType = CALCULATE_TYPE_EQUITY;

	public int getCalculateType() {
		try {
			int data = getEntryInt(C3_IP_TRADESERV3001.calculateType);
			return data;
		} catch (RuntimeException e) {
			return CALCULATE_TYPE_EQUITY;
		}
	}

	public void setCalculateType(int calculateType) {
		setEntry(C3_IP_TRADESERV3001.calculateType, calculateType);
	}
}