package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl4002 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5114535738295880188L;
	private String aeid;
	private long account;
	private String oldPhonePin;
	private String newPhonePin;
	private String realName;
	private String ipAddress;

	public long getAccount() {
		return account;
	}

	public void setAccount(long account) {
		this.account = account;
	}

	public String getOldPhonePin() {
		return oldPhonePin;
	}

	public void setOldPhonePin(String oldPhonePin) {
		this.oldPhonePin = oldPhonePin;
	}

	public String getNewPhonePin() {
		return newPhonePin;
	}

	public void setNewPhonePin(String newPhonePin) {
		this.newPhonePin = newPhonePin;
	}

	public String getAeid() {
		return aeid;
	}

	public void setAeid(String aeid) {
		this.aeid = aeid;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

}
