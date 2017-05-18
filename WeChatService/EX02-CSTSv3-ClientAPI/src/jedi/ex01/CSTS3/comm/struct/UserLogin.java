package jedi.ex01.CSTS3.comm.struct;

import java.util.Date;

public class UserLogin extends allone.json.AbstractJsonData {

	public static final String jsonId = "26";

	public static final String aeid = "1";
	public static final String type = "2";
	public static final String realName = "3";
	public static final String userName = "4";
	public static final String callEmail = "5";
	public static final String callPhone = "6";
	public static final String marginCallWay = "7";
	public static final String reckoning = "8";
	public static final String reckoningType = "9";
	public static final String disabled = "10";
	public static final String maxOnlineNum = "11";
	public static final String ipFixed = "12";
	public static final String ipList = "13";
	public static final String regestTime = "14";
	public static final String regestDealer = "15";
	public static final String expireDate = "16";
	public static final String messageRecType = "17";
	public static final String msgLocal = "18";
	public static final String canLoginIBClient = "19";
	public static final String firstLoginTime = "20";
	public static final String lastLoginTime = "21";
	
	public static final String certificationType = "22";
	public static final String certificationId = "23";

	public UserLogin(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getAeid() {
		try {
			String data=getEntryString(UserLogin.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(UserLogin.aeid, aeid);
	}

	public int getType() {
		try {
			int data=getEntryInt(UserLogin.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(UserLogin.type, type);
	}

	public String getRealName() {
		try {
			String data=getEntryString(UserLogin.realName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRealName(String realName) {
		setEntry(UserLogin.realName, realName);
	}

	public String getUserName() {
		try {
			String data=getEntryString(UserLogin.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(UserLogin.userName, userName);
	}

	public String getCallEmail() {
		try {
			String data=getEntryString(UserLogin.callEmail);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallEmail(String callEmail) {
		setEntry(UserLogin.callEmail, callEmail);
	}

	public String getCallPhone() {
		try {
			String data=getEntryString(UserLogin.callPhone);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallPhone(String callPhone) {
		setEntry(UserLogin.callPhone, callPhone);
	}

	public int getMarginCallWay() {
		try {
			int data=getEntryInt(UserLogin.marginCallWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCallWay(int marginCallWay) {
		setEntry(UserLogin.marginCallWay, marginCallWay);
	}

	public int getReckoning() {
		try {
			int data=getEntryInt(UserLogin.reckoning);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReckoning(int reckoning) {
		setEntry(UserLogin.reckoning, reckoning);
	}

	public int getReckoningType() {
		try {
			int data=getEntryInt(UserLogin.reckoningType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReckoningType(int reckoningType) {
		setEntry(UserLogin.reckoningType, reckoningType);
	}

	public int getDisabled() {
		try {
			int data=getEntryInt(UserLogin.disabled);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDisabled(int disabled) {
		setEntry(UserLogin.disabled, disabled);
	}

	public int getMaxOnlineNum() {
		try {
			int data=getEntryInt(UserLogin.maxOnlineNum);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOnlineNum(int maxOnlineNum) {
		setEntry(UserLogin.maxOnlineNum, maxOnlineNum);
	}

	public int getIpFixed() {
		try {
			int data=getEntryInt(UserLogin.ipFixed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIpFixed(int ipFixed) {
		setEntry(UserLogin.ipFixed, ipFixed);
	}

	public String[] getIpList() {
		try {
			String[] data=getEntryObjectVec(UserLogin.ipList,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpList(String[] ipList) {
		setEntry(UserLogin.ipList, ipList);
	}

	public Date getRegestTime() {
		try {
			Date data=getEntryDate(UserLogin.regestTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRegestTime(Date regestTime) {
		setEntry(UserLogin.regestTime, regestTime);
	}

	public String getRegestDealer() {
		try {
			String data=getEntryString(UserLogin.regestDealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRegestDealer(String regestDealer) {
		setEntry(UserLogin.regestDealer, regestDealer);
	}

	public Date getExpireDate() {
		try {
			Date data=getEntryDate(UserLogin.expireDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireDate(Date expireDate) {
		setEntry(UserLogin.expireDate, expireDate);
	}

	public String getMessageRecType() {
		try {
			String data=getEntryString(UserLogin.messageRecType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessageRecType(String messageRecType) {
		setEntry(UserLogin.messageRecType, messageRecType);
	}

	public String getMsgLocal() {
		try {
			String data=getEntryString(UserLogin.msgLocal);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMsgLocal(String msgLocal) {
		setEntry(UserLogin.msgLocal, msgLocal);
	}

	public int getCanLoginIBClient() {
		try {
			int data=getEntryInt(UserLogin.canLoginIBClient);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanLoginIBClient(int canLoginIBClient) {
		setEntry(UserLogin.canLoginIBClient, canLoginIBClient);
	}

	public Date getFirstLoginTime() {
		try {
			Date data=getEntryDate(UserLogin.firstLoginTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstLoginTime(Date firstLoginTime) {
		setEntry(UserLogin.firstLoginTime, firstLoginTime);
	}

	public Date getLastLoginTime() {
		try {
			Date data=getEntryDate(UserLogin.lastLoginTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastLoginTime(Date lastLoginTime) {
		setEntry(UserLogin.lastLoginTime, lastLoginTime);
	}


	public int getCertificationType() {
		try {
			int data=getEntryInt(UserLogin.certificationType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCertificationType(int certificationType) {
		setEntry(UserLogin.certificationType, certificationType);
	}
	
	public String getCertificationId() {
		try {
			String data=getEntryString(UserLogin.certificationId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCertificationId(String certificationId) {
		setEntry(UserLogin.certificationId, certificationId);
	}
}