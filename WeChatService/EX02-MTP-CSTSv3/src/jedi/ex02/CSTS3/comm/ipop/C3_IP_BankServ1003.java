package jedi.ex02.CSTS3.comm.ipop;

import java.util.HashMap;
import java.util.Map;

import jedi.v7.bankserver.comm.BankServCommData;
import jedi.v7.bankserver.comm.ipop.client.IP_BankServ1003;
import jedi.v7.bankserver.comm.type.BankAcctTypeList;
import jedi.v7.bankserver.comm.type.BankCertTypeList;

/**
 * 签约
 * 
 * @author admin
 * 
 */
public class C3_IP_BankServ1003 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_BankServ1003";
	public static final String certType = "1"; // 证件类型
	public static final String certNo = "2"; // 证件number
	public static final String bankAcctNo = "3"; // 银行number
	public static final String bankAcctName = "4";// 名字
	public static final String bankAcctType = "5"; // 银行账号类型
	public static final String bankOpenName = "6"; // 开户行
	public static final String bankCodeName = "7"; // 缩写
	public static final String marketId = "8";
	public static final String vipMktId = "9";
	public static final String bankId = "10";
	// 新添加字段，发起方标识
	public static final String originFlag = "11";
	public static final String streamID = "12";
	public static final String aeid = "13";
	public static final String password = "14";
	public static final String account = "15";
	public static final String otherInfo = "16";

	private String defaultString = "0";
	private String defaultBankId = "OPENEPAY";// 暂时写死在交易里
	public C3_IP_BankServ1003() {
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_BankServ1003 formatIP() {
		IP_BankServ1003 ip = new IP_BankServ1003();
		ip.setCertType(getCertType());
		ip.setCertNo(getCertNo());
		ip.setBankAcctNo(getBankAcctNo());// 必填
		ip.setBankAcctName(getBankAcctName());// 必填
		ip.setBankAcctType(getBankAcctType());
		ip.setBankOpenName(getBankOpenName());// 必填
		ip.setBankCodeName(getBankCodeName());
		ip.setMarketId(getMarketId());
		ip.setVipMktId(getVipMktId());
		ip.setBankID(getBankId());

		ip.setStreamID(getStreamID()); // 必填
		ip.setAeid(getAeid()); // 必填
		ip.setPassword(getPassword()); // 必填
		ip.setAccount(getAccount()); // 必填
		Map<String, String> map = getOtherInfo();
		for (String key : map.keySet()) {
			ip.setOtherInfo(key, map.get(key));
		}
		return ip;
	}

	public int getCertType() {
		try {
			int certType = getEntryInt(C3_IP_BankServ1003.certType);
			if (certType == 0) {
				certType = BankCertTypeList.CHINA_PASSPORT;
			}
			return certType;
		} catch (RuntimeException e) {
			return BankCertTypeList.CHINA_PASSPORT;
		}
	}

	public void setCertType(int certType) {
		setEntry(C3_IP_BankServ1003.certType, certType);
	}

	public int getMarketId() {
		try {
			return getEntryInt(C3_IP_BankServ1003.marketId);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarketId(int marketId) {
		setEntry(C3_IP_BankServ1003.marketId, marketId);
	}

	public String getCertNo() {
		try {
			String certNo = getEntryString(C3_IP_BankServ1003.certNo);
			if (stringIsEmpty(certNo)) {
				certNo = defaultString;
			}
			return certNo;
		} catch (RuntimeException e) {
			return defaultString;
		}
	}

	public void setCertNo(String certNo) {
		setEntry(C3_IP_BankServ1003.certNo, certNo);
	}

	public String getBankAcctNo() {
		try {
			return getEntryString(C3_IP_BankServ1003.bankAcctNo);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctNo(String bankAcctNo) {
		setEntry(C3_IP_BankServ1003.bankAcctNo, bankAcctNo);
	}

	public String getBankId() {
		try {
			String bankId = getEntryString(C3_IP_BankServ1003.bankId);
			if (stringIsEmpty(bankId)) {
				bankId = defaultBankId;	
			}
			return bankId;
		} catch (RuntimeException e) {
			return bankId;
		}
	}

	public void setBankId(String bankId) {
		setEntry(C3_IP_BankServ1003.bankId, bankId);
	}

	public String getBankAcctName() {
		try {
			return getEntryString(C3_IP_BankServ1003.bankAcctName);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankAcctName(String bankAcctName) {
		setEntry(C3_IP_BankServ1003.bankAcctName, bankAcctName);
	}

	public String getBankAcctType() {
		try {
			String bankAccountType = getEntryString(C3_IP_BankServ1003.bankAcctType);
			if (stringIsEmpty(bankAccountType)) {
				bankAccountType = BankAcctTypeList.DEBIT_ACCT;
			}
			return bankAccountType;
		} catch (RuntimeException e) {
			return BankAcctTypeList.DEBIT_ACCT;
		}
	}

	public void setBankAcctType(String bankAcctType) {
		setEntry(C3_IP_BankServ1003.bankAcctType, bankAcctType);
	}

	public String getBankOpenName() {
		try {
			return getEntryString(C3_IP_BankServ1003.bankOpenName);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBankOpenName(String bankOpenName) {
		setEntry(C3_IP_BankServ1003.bankOpenName, bankOpenName);
	}

	public String getBankCodeName() {
		try {
			String bankCodeName = getEntryString(C3_IP_BankServ1003.bankCodeName);
			if (stringIsEmpty(bankCodeName)) {
				bankCodeName = defaultString;
			}
			return bankCodeName;
		} catch (RuntimeException e) {
			return defaultString;
		}
	}

	public void setBankCodeName(String bankCodeName) {
		setEntry(C3_IP_BankServ1003.bankCodeName, bankCodeName);
	}

	public int getVipMktId() {
		try {
			return getEntryInt(C3_IP_BankServ1003.vipMktId);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setVipMktId(int vipMktId) {
		setEntry(C3_IP_BankServ1003.vipMktId, vipMktId);
	}

	public String getOriginFlag() {
		try {
			return getEntryString(C3_IP_BankServ1003.originFlag);
		} catch (RuntimeException e) {
			return BankServCommData.ORIGIN_MTP;
		}
	}

	public void setOriginFlag(String originFlag) {
		setEntry(C3_IP_BankServ1003.originFlag, originFlag);
	}

	public long getStreamID() {
		try {
			return getEntryLong(C3_IP_BankServ1003.streamID);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setStramID(long streamID) {
		setEntry(C3_IP_BankServ1003.streamID, streamID);
	}

	public String getAeid() {
		try {
			return getEntryString(C3_IP_BankServ1003.aeid);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_IP_BankServ1003.aeid, aeid);
	}

	public String getPassword() {
		try {
			return getEntryString(C3_IP_BankServ1003.password);
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setPassword(String password) {
		setEntry(C3_IP_BankServ1003.password, password);
	}

	public long getAccount() {
		try {
			return getEntryLong(C3_IP_BankServ1003.account);
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_BankServ1003.account, account);
	}

	public HashMap getOtherInfo() {
		try {
			HashMap data = getEntryObject(C3_IP_BankServ1003.otherInfo);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setOtherInfo(HashMap otherInfo) {
		setEntry(C3_IP_BankServ1003.otherInfo, otherInfo);
	}

	private boolean stringIsEmpty(String string) {
		if (string == null || string.equalsIgnoreCase("")) {
			return true;
		}
		return false;
	}
}
