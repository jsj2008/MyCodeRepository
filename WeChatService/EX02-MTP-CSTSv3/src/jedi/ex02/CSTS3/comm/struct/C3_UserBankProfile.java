package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;
import java.util.Map;

import allone.json.AbstractJsonData;
import jedi.v7.bankserver.comm.struct.UserBankProfile;

/**
 * 出入金相关14:07:17
 * 
 * @author ALLONE
 * 
 */
public class C3_UserBankProfile extends AbstractJsonData {

	public static final String jsonId = "35";

	public C3_UserBankProfile() {
		super();
		setEntry("jsonId", jsonId);
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 3449505955465417989L;
	/**
	 * 未签�?
	 */
	public static final int SIGNUP_STATE_NONE = 0;
	/**
	 * 处理�?
	 */
	public static final int SIGNUP_STATE_DOING = 1;
	/**
	 * 已签�?
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

	public void parseFromSysData(UserBankProfile data) throws Exception {
		setMemberId(data.getMemberId());
		setAccount(data.getAccount());
		setAeid(data.getAeid());
		setUserName(data.getUserName());
		setUserType(data.getUserType());
		setCurrency(data.getCurrency());
		setBankID(data.getBankID());
		setCertType(data.getCertType());
		setCertNo(data.getCertNo());
		setBankAcctNo(data.getBankAcctNo());
		setBankAcctName(data.getBankAcctName());
		setBankAcctType(data.getBankAcctType());
		setBankOpenName(data.getBankOpenName());
		setBankCodeName(data.getBankCodeName());
		setReserve1(data.getReserve1());
		setReserve2(data.getReserve2());
		setState(data.getState());
		setUpTime(data.getUpTime());
		setOrigin(data.getOrigin());
		set_bankCodeNameDesc(data.get_bankCodeNameDesc());
		setNotified(data.isNotified());
		setSignUpTime(data.getSignUpTime());
		setSignOffTime(data.getSignOffTime());
		setBankCodeMap(data.getBankCodeMap());
	}

	public UserBankProfile format() {
		UserBankProfile data = new UserBankProfile();
		data.setMemberId(getMemberId());
		data.setAccount(getAccount());
		data.setAeid(getAeid());
		data.setUserName(getUserName());
		data.setUserType(getUserType());
		data.setCurrency(getCurrency());
		data.setBankID(getBankID());
		data.setCertType(getCertType());
		data.setCertNo(getCertNo());
		data.setBankAcctNo(getBankAcctNo());
		data.setBankAcctName(getBankAcctName());
		data.setBankAcctType(getBankAcctType());
		data.setBankOpenName(getBankOpenName());
		data.setBankCodeName(getBankCodeName());
		data.setReserve1(getReserve1());
		data.setReserve2(getReserve2());
		data.setState(getState());
		data.setUpTime(getUpTime());
		data.setOrigin(getOrigin());
		data.set_bankCodeNameDesc(get_bankCodeNameDesc());
		data.setNotified(isNotified());
		data.setSignUpTime(getSignUpTime());
		data.setSignOffTime(getSignOffTime());
		data.setBankCodeMap(getBankCodeMap());

		return data;
	}

	// int memberId
	public int getMemberId() {
		try {
			int data = getEntryInt(C3_UserBankProfile.memberId);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMemberId(int memberId) {
		setEntry(C3_UserBankProfile.memberId, memberId);
	}

	// long account
	public long getAccount() {
		try {
			long data = getEntryLong(C3_UserBankProfile.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_UserBankProfile.account, account);
	}

	// String aeid
	public String getAeid() {
		try {
			String data = getEntryString(C3_UserBankProfile.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_UserBankProfile.aeid, aeid);
	}

	// String userName
	public String getUserName() {
		try {
			String data = getEntryString(C3_UserBankProfile.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(C3_UserBankProfile.userName, userName);
	}

	// int userType
	public int getUserType() {
		try {
			int data = getEntryInt(C3_UserBankProfile.userType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setUserType(int userType) {
		setEntry(C3_UserBankProfile.userType, userType);
	}

	// String currency
	public String getCurrency() {
		try {
			String data = getEntryString(C3_UserBankProfile.currency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCurrency(String currency) {
		setEntry(C3_UserBankProfile.currency, currency);
	}

	// String bankID
	public String getBankID() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankID);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankID(String bankID) {
		setEntry(C3_UserBankProfile.bankID, bankID);
	}

	// int certType
	public int getCertType() {
		try {
			int data = getEntryInt(C3_UserBankProfile.certType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCertType(int certType) {
		setEntry(C3_UserBankProfile.certType, certType);
	}

	// String certNo
	public String getCertNo() {
		try {
			String data = getEntryString(C3_UserBankProfile.certNo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCertNo(String certNo) {
		setEntry(C3_UserBankProfile.certNo, certNo);
	}

	// String bankAcctNo
	public String getBankAcctNo() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankAcctNo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctNo(String bankAcctNo) {
		setEntry(C3_UserBankProfile.bankAcctNo, bankAcctNo);
	}

	// String bankAcctName
	public String getBankAcctName() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankAcctName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctName(String bankAcctName) {
		setEntry(C3_UserBankProfile.bankAcctName, bankAcctName);
	}

	// String bankAcctType
	public String getBankAcctType() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankAcctType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctType(String bankAcctType) {
		setEntry(C3_UserBankProfile.bankAcctType, bankAcctType);
	}

	// String bankOpenName
	public String getBankOpenName() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankOpenName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankOpenName(String bankOpenName) {
		setEntry(C3_UserBankProfile.bankOpenName, bankOpenName);
	}

	// String bankCodeName
	public String getBankCodeName() {
		try {
			String data = getEntryString(C3_UserBankProfile.bankCodeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankCodeName(String bankCodeName) {
		setEntry(C3_UserBankProfile.bankCodeName, bankCodeName);
	}

	// String reserve1
	public String getReserve1() {
		try {
			String data = getEntryString(C3_UserBankProfile.reserve1);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve1(String reserve1) {
		setEntry(C3_UserBankProfile.reserve1, reserve1);
	}

	// String reserve2
	public String getReserve2() {
		try {
			String data = getEntryString(C3_UserBankProfile.reserve2);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReserve2(String reserve2) {
		setEntry(C3_UserBankProfile.reserve2, reserve2);
	}

	// int state
	public int getState() {
		try {
			int data = getEntryInt(C3_UserBankProfile.state);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setState(int state) {
		setEntry(C3_UserBankProfile.state, state);
	}

	// Date upTime
	public Date getUpTime() {
		try {
			Date data = getEntryDate(C3_UserBankProfile.upTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUpTime(Date upTime) {
		setEntry(C3_UserBankProfile.upTime, upTime);
	}

	// String origin
	public String getOrigin() {
		try {
			String data = getEntryString(C3_UserBankProfile.origin);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOrigin(String origin) {
		setEntry(C3_UserBankProfile.origin, origin);
	}

	// String _bankCodeNameDesc
	public String get_bankCodeNameDesc() {
		try {
			String data = getEntryString(C3_UserBankProfile._bankCodeNameDesc);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void set_bankCodeNameDesc(String _bankCodeNameDesc) {
		setEntry(C3_UserBankProfile._bankCodeNameDesc, _bankCodeNameDesc);
	}

	// boolean notified

	public boolean isNotified() {
		try {
			boolean data = getEntryBoolean(C3_UserBankProfile.notified);
			return data;
		} catch (RuntimeException e) {
			return false;
		}
	}

	public void setNotified(boolean notified) {
		setEntry(C3_UserBankProfile.notified, notified);
	}

	// Date signUpTime
	public Date getSignUpTime() {
		try {
			Date data = getEntryDate(C3_UserBankProfile.signUpTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSignUpTime(Date signUpTime) {
		setEntry(C3_UserBankProfile.signUpTime, signUpTime);
	}

	// Date signOffTime
	public Date getSignOffTime() {
		try {
			Date data = getEntryDate(C3_UserBankProfile.signOffTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSignOffTime(Date signOffTime) {
		setEntry(C3_UserBankProfile.signOffTime, signOffTime);
	}

	// Map<String, String> bankCodeMap

	public Map<String, String> getBankCodeMap() {
		try {
			Map<String, String> data = getEntryObject(C3_UserBankProfile.bankCodeMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankCodeMap(Map<String, String> bankCodeMap) {
		setEntry(C3_UserBankProfile.bankCodeMap, bankCodeMap);
	}

}
