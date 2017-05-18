package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;

public class DealerMsgNode implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = -185148795573805826L;
	private String dealerName;
	private String dealerIp;
	private long loginTime;
	private String DSTSName;
	private String dealerGUID;
	private long lastLoginTime;
	public String getDealerName() {
		return dealerName;
	}
	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}
	public String getDealerIp() {
		return dealerIp;
	}
	public void setDealerIp(String dealerIp) {
		this.dealerIp = dealerIp;
	}
	public long getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(long loginTime) {
		this.loginTime = loginTime;
	}
	public String getDSTSName() {
		return DSTSName;
	}
	public void setDSTSName(String name) {
		DSTSName = name;
	}
	public String getDealerGUID() {
		return dealerGUID;
	}
	public void setDealerGUID(String dealerGUID) {
		this.dealerGUID = dealerGUID;
	}
	public long getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(long lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	
	

}
