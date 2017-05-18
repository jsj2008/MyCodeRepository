package jedi.ex01.CSTS3.comm.struct;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import jedi.v7.bankserver.comm.BankServCommData;
import ex.v01.exchange.comm.MemSystemType;

/**
 * 银行出入金使用的类2016年8月2日14:07:17
 * 
 * @author ALLONE
 * 
 */
public class UserBankProfile extends allone.json.AbstractJsonData {

	public static final String jsonId = "35";

	public UserBankProfile() {
		super();
		setEntry("jsonId", jsonId);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 3449505955465417989L;
	/**
	 * 鏈绾?
	 */
	public static final int SIGNUP_STATE_NONE = 0;
	/**
	 * 澶勭悊涓?
	 */
	public static final int SIGNUP_STATE_DOING = 1;
	/**
	 * 宸茬绾?
	 */
	public static final int SIGNUP_STATE_DONE = 2;

	private static final String memberId = "1";
	private static final String account = "2";
	private static final String aeid = "3";
	private static final String userName = "4";
	private static final String userType = "5";
	private static final String currency = "6";
	private static final String bankID = "7";
	private static final String certType = "8";
	private static final String certNo = "9";
	private static final String bankAcctNo = "10";
	private static final String bankAcctName = "11";
	private static final String bankAcctType = "12";
	private static final String bankOpenName = "13";
	private static final String bankCodeName = "14";
	private static final String reserve1 = "15";
	private static final String reserve2 = "16";
	private static final String state = "17";
	private static final String upTime = "18";
	private static final String origin = "19";
	private static final String _bankCodeNameDesc = "20";
	private static final String notified = "21";
	private static final String signUpTime = "22";
	private static final String signOffTime = "23";
	private static final String bankCodeMap = "24";

	// int memberId
	public int getMemberId() {
		try {
			int data = getEntryInt(UserBankProfile.memberId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMemberId(int memberId) {
		setEntry(UserBankProfile.memberId, memberId);
	}

	// long account
	public long getAccount() {
		try {
			long data = getEntryLong(UserBankProfile.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(UserBankProfile.account, account);
	}

	// String aeid
	public String getAeid() {
		try {
			String data = getEntryString(UserBankProfile.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(UserBankProfile.aeid, aeid);
	}

	// String userName
	public String getUserName() {
		try {
			String data = getEntryString(UserBankProfile.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(UserBankProfile.userName, userName);
	}

	// int userType
	public int getUserType() {
		try {
			int data = getEntryInt(UserBankProfile.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(UserBankProfile.userType, userType);
	}

	// String currency
	public String getCurrency() {
		try {
			String data = getEntryString(UserBankProfile.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(UserBankProfile.currency, currency);
	}

	// String bankID
	public String getBankID() {
		try {
			String data = getEntryString(UserBankProfile.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(UserBankProfile.bankID, bankID);
	}

	// int certType
	public int getCertType() {
		try {
			int data = getEntryInt(UserBankProfile.certType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCertType(int certType) {
		setEntry(UserBankProfile.certType, certType);
	}

	// String certNo
	public String getCertNo() {
		try {
			String data = getEntryString(UserBankProfile.certNo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCertNo(String certNo) {
		setEntry(UserBankProfile.certNo, certNo);
	}

	// String bankAcctNo
	public String getBankAcctNo() {
		try {
			String data = getEntryString(UserBankProfile.bankAcctNo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctNo(String bankAcctNo) {
		setEntry(UserBankProfile.bankAcctNo, bankAcctNo);
	}

	// String bankAcctName
	public String getBankAcctName() {
		try {
			String data = getEntryString(UserBankProfile.bankAcctName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctName(String bankAcctName) {
		setEntry(UserBankProfile.bankAcctName, bankAcctName);
	}

	// String bankAcctType
	public String getBankAcctType() {
		try {
			String data = getEntryString(UserBankProfile.bankAcctType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctType(String bankAcctType) {
		setEntry(UserBankProfile.bankAcctType, bankAcctType);
	}

	// String bankOpenName
	public String getBankOpenName() {
		try {
			String data = getEntryString(UserBankProfile.bankOpenName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankOpenName(String bankOpenName) {
		setEntry(UserBankProfile.bankOpenName, bankOpenName);
	}

	// String bankCodeName
	public String getBankCodeName() {
		try {
			String data = getEntryString(UserBankProfile.bankCodeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankCodeName(String bankCodeName) {
		setEntry(UserBankProfile.bankCodeName, bankCodeName);
	}

	// String reserve1
	public String getReserve1() {
		try {
			String data = getEntryString(UserBankProfile.reserve1);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve1(String reserve1) {
		setEntry(UserBankProfile.reserve1, reserve1);
	}

	// String reserve2
	public String getReserve2() {
		try {
			String data = getEntryString(UserBankProfile.reserve2);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve2(String reserve2) {
		setEntry(UserBankProfile.reserve2, reserve2);
	}

	// int state
	public int getState() {
		try {
			int data = getEntryInt(UserBankProfile.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(UserBankProfile.state, state);
	}

	// Date upTime
	public Date getUpTime() {
		try {
			Date data = getEntryDate(UserBankProfile.upTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUpTime(Date upTime) {
		setEntry(UserBankProfile.upTime, upTime);
	}

	// String origin
	public String getOrigin() {
		try {
			String data = getEntryString(UserBankProfile.origin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrigin(String origin) {
		setEntry(UserBankProfile.origin, origin);
	}

	// String _bankCodeNameDesc
	public String get_bankCodeNameDesc() {
		try {
			String data = getEntryString(UserBankProfile._bankCodeNameDesc);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void set_bankCodeNameDesc(String _bankCodeNameDesc) {
		setEntry(UserBankProfile._bankCodeNameDesc, _bankCodeNameDesc);
	}

	// boolean notified

	public boolean isNotified() {
		try {
			boolean data = getEntryBoolean(UserBankProfile.notified);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNotified(boolean notified) {
		setEntry(UserBankProfile.notified, notified);
	}

	// Date signUpTime
	public Date getSignUpTime() {
		try {
			Date data = getEntryDate(UserBankProfile.signUpTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSignUpTime(Date signUpTime) {
		setEntry(UserBankProfile.signUpTime, signUpTime);
	}

	// Date signOffTime
	public Date getSignOffTime() {
		try {
			Date data = getEntryDate(UserBankProfile.signOffTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSignOffTime(Date signOffTime) {
		setEntry(UserBankProfile.signOffTime, signOffTime);
	}

	// Map<String, String> bankCodeMap

	public Map<String, String> getBankCodeMap() {
		try {
			Map<String, String> data = getEntryObject(UserBankProfile.bankCodeMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankCodeMap(Map<String, String> bankCodeMap) {
		setEntry(UserBankProfile.bankCodeMap, bankCodeMap);
	}

}
