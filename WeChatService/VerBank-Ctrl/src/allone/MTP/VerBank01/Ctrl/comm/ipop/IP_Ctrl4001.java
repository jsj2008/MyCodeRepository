package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl4001 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4140322504612819973L;
	private String aeid;
	private long account;
	private String oldPswd;
	private String newPswd;
	private String realName;
	private String ipAddress;

	public String getAeid() {
		return aeid;
	}

	public void setAeid(String aeid) {
		this.aeid = aeid;
	}

	public String getOldPswd() {
		return oldPswd;
	}

	public void setOldPswd(String oldPswd) {
		this.oldPswd = oldPswd;
	}

	public String getNewPswd() {
		return newPswd;
	}

	public void setNewPswd(String newPswd) {
		this.newPswd = newPswd;
	}

	public long getAccount() {
		return account;
	}

	public void setAccount(long account) {
		this.account = account;
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
