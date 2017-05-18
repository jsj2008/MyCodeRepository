package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl4004 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5114535738295880188L;
	private String aeid;
	private long account;
	private String phonePin;

	public long getAccount() {
		return account;
	}

	public void setAccount(long account) {
		this.account = account;
	}

	public String getPhonePin() {
		return phonePin;
	}

	public void setPhonePin(String phonePin) {
		this.phonePin = phonePin;
	}

	public String getAeid() {
		return aeid;
	}

	public void setAeid(String aeid) {
		this.aeid = aeid;
	}

}
