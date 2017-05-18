package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl5201 extends CtrlServerIPFather {

	private static final long serialVersionUID = 4419827076935277842L;

	private String accountID; // 没用到
	private String aeid;
	private String groupName;
	private int deviceType;
	private String deviceToken;

	public String getAeid() {
		return aeid;
	}

	public void setAeid(String aeid) {
		this.aeid = aeid;
	}

	public int getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(int deviceType) {
		this.deviceType = deviceType;
	}

	public String getDeviceToken() {
		return deviceToken;
	}

	public void setDeviceToken(String deviceToken) {
		this.deviceToken = deviceToken;
	}

	public String getAccountID() {
		return accountID;
	}

	public void setAccountID(String accountID) {
		this.accountID = accountID;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

}
