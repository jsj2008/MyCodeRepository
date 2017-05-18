package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;

public class UserMsgNode implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8243626592662621849L;

	private String userName;
	private String userIp;
	private long loginTime;
	private String CSTSName;
	private String userGUID;
	private int roleType;
	private String[] groupNameVec;
	private long lastLoginTime;

	public long getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(long lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String[] getGroupNameVec() {
		return groupNameVec;
	}

	public void setGroupNameVec(String[] groupNameVec) {
		this.groupNameVec = groupNameVec;
	}

	public int getRoleType() {
		return roleType;
	}

	public void setRoleType(int roleType) {
		this.roleType = roleType;
	}

	public String getCSTSName() {
		return CSTSName;
	}

	public void setCSTSName(String name) {
		CSTSName = name;
	}

	public String getUserGUID() {
		return userGUID;
	}

	public void setUserGUID(String userGUID) {
		this.userGUID = userGUID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

	public long getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(long loginTime) {
		this.loginTime = loginTime;
	}

}
