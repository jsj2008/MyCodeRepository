package jedi.ex02.CSTS3.comm.struct;

import java.util.Date;

import jedi.v7.comm.datastruct.DB.UserLogin;

public class C3_UserLogin extends allone.json.AbstractJsonData {

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

	public C3_UserLogin(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(UserLogin data) throws Exception {
		setAeid(data.getAeid());
		setType(data.getType());
		setRealName(data.getRealName());
		setUserName(data.getUserName());
		setCallEmail(data.getCallEmail());
		setCallPhone(data.getCallPhone());
		setMarginCallWay(data.getMarginCallWay());
		setReckoning(data.getReckoning());
		setReckoningType(data.getReckoningType());
		setDisabled(data.getDisabled());
		setMaxOnlineNum(data.getMaxOnlineNum());
		setIpFixed(data.getIpFixed());
		setIpList(data.getIpList().toArray(new String[0]));
		setRegestTime(data.getRegestTime());
		setRegestDealer(data.getRegestDealer());
		setExpireDate(data.getExpireDate());
		setMessageRecType(data.getMessageRecType());
		setMsgLocal(data.getMsgLocal());
		setCanLoginIBClient(data.getCanLoginIBClient());
		setFirstLoginTime(data.getFirstLoginTime());
		setLastLoginTime(data.getLastLoginTime());
		
		setCertificationType(data.getCertificationType());
		setCertificationId(data.getCertificationId());
	}

	public UserLogin format(){
		UserLogin data=new UserLogin();
		data.setAeid(getAeid());
		data.setType(getType());
		data.setRealName(getRealName());
		data.setUserName(getUserName());
		data.setCallEmail(getCallEmail());
		data.setCallPhone(getCallPhone());
		data.setMarginCallWay(getMarginCallWay());
		data.setReckoning(getReckoning());
		data.setReckoningType(getReckoningType());
		data.setDisabled(getDisabled());
		data.setMaxOnlineNum(getMaxOnlineNum());
		data.setIpFixed(getIpFixed());
//		data.setIpList(getIpList());
		data.setRegestTime(getRegestTime());
		data.setRegestDealer(getRegestDealer());
		data.setExpireDate(getExpireDate());
		data.setMessageRecType(getMessageRecType());
		data.setMsgLocal(getMsgLocal());
		data.setCanLoginIBClient(getCanLoginIBClient());
		data.setFirstLoginTime(getFirstLoginTime());
		data.setLastLoginTime(getLastLoginTime());
		return data;
	}


	public String getAeid() {
		try {
			String data=getEntryString(C3_UserLogin.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAeid(String aeid) {
		setEntry(C3_UserLogin.aeid, aeid);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_UserLogin.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_UserLogin.type, type);
	}

	public String getRealName() {
		try {
			String data=getEntryString(C3_UserLogin.realName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRealName(String realName) {
		setEntry(C3_UserLogin.realName, realName);
	}

	public String getUserName() {
		try {
			String data=getEntryString(C3_UserLogin.userName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setUserName(String userName) {
		setEntry(C3_UserLogin.userName, userName);
	}

	public String getCallEmail() {
		try {
			String data=getEntryString(C3_UserLogin.callEmail);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallEmail(String callEmail) {
		setEntry(C3_UserLogin.callEmail, callEmail);
	}

	public String getCallPhone() {
		try {
			String data=getEntryString(C3_UserLogin.callPhone);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCallPhone(String callPhone) {
		setEntry(C3_UserLogin.callPhone, callPhone);
	}

	public int getMarginCallWay() {
		try {
			int data=getEntryInt(C3_UserLogin.marginCallWay);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginCallWay(int marginCallWay) {
		setEntry(C3_UserLogin.marginCallWay, marginCallWay);
	}

	public int getReckoning() {
		try {
			int data=getEntryInt(C3_UserLogin.reckoning);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReckoning(int reckoning) {
		setEntry(C3_UserLogin.reckoning, reckoning);
	}

	public int getReckoningType() {
		try {
			int data=getEntryInt(C3_UserLogin.reckoningType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setReckoningType(int reckoningType) {
		setEntry(C3_UserLogin.reckoningType, reckoningType);
	}

	public int getDisabled() {
		try {
			int data=getEntryInt(C3_UserLogin.disabled);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setDisabled(int disabled) {
		setEntry(C3_UserLogin.disabled, disabled);
	}

	public int getMaxOnlineNum() {
		try {
			int data=getEntryInt(C3_UserLogin.maxOnlineNum);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOnlineNum(int maxOnlineNum) {
		setEntry(C3_UserLogin.maxOnlineNum, maxOnlineNum);
	}

	public int getIpFixed() {
		try {
			int data=getEntryInt(C3_UserLogin.ipFixed);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIpFixed(int ipFixed) {
		setEntry(C3_UserLogin.ipFixed, ipFixed);
	}

	public String[] getIpList() {
		try {
			String[] data=getEntryObjectVec(C3_UserLogin.ipList,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setIpList(String[] ipList) {
		setEntry(C3_UserLogin.ipList, ipList);
	}

	public Date getRegestTime() {
		try {
			Date data=getEntryDate(C3_UserLogin.regestTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRegestTime(Date regestTime) {
		setEntry(C3_UserLogin.regestTime, regestTime);
	}

	public String getRegestDealer() {
		try {
			String data=getEntryString(C3_UserLogin.regestDealer);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setRegestDealer(String regestDealer) {
		setEntry(C3_UserLogin.regestDealer, regestDealer);
	}

	public Date getExpireDate() {
		try {
			Date data=getEntryDate(C3_UserLogin.expireDate);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setExpireDate(Date expireDate) {
		setEntry(C3_UserLogin.expireDate, expireDate);
	}

	public String getMessageRecType() {
		try {
			String data=getEntryString(C3_UserLogin.messageRecType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMessageRecType(String messageRecType) {
		setEntry(C3_UserLogin.messageRecType, messageRecType);
	}

	public String getMsgLocal() {
		try {
			String data=getEntryString(C3_UserLogin.msgLocal);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setMsgLocal(String msgLocal) {
		setEntry(C3_UserLogin.msgLocal, msgLocal);
	}

	public int getCanLoginIBClient() {
		try {
			int data=getEntryInt(C3_UserLogin.canLoginIBClient);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCanLoginIBClient(int canLoginIBClient) {
		setEntry(C3_UserLogin.canLoginIBClient, canLoginIBClient);
	}

	public Date getFirstLoginTime() {
		try {
			Date data=getEntryDate(C3_UserLogin.firstLoginTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFirstLoginTime(Date firstLoginTime) {
		setEntry(C3_UserLogin.firstLoginTime, firstLoginTime);
	}

	public Date getLastLoginTime() {
		try {
			Date data=getEntryDate(C3_UserLogin.lastLoginTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLastLoginTime(Date lastLoginTime) {
		setEntry(C3_UserLogin.lastLoginTime, lastLoginTime);
	}


	public int getCertificationType() {
		try {
			int data=getEntryInt(C3_UserLogin.certificationType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCertificationType(int certificationType) {
		setEntry(C3_UserLogin.certificationType, certificationType);
	}
	
	public String getCertificationId() {
		try {
			String data=getEntryString(C3_UserLogin.certificationId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setCertificationId(String certificationId) {
		setEntry(C3_UserLogin.certificationId, certificationId);
	}
}