package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * dealer登陆
 * @author admin
 *
 */
public class IP_Ctrl1002 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8378446761698491157L;
	private String password;
	private String dealerName;
	private String clientId;
	private String ipAddress;
	private boolean isFirstLogin = false;
	private long firstLoginTime = -1;
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDealerName() {
		return dealerName;
	}
	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public boolean isFirstLogin() {
		return isFirstLogin;
	}
	public void setFirstLogin(boolean isFirstLogin) {
		this.isFirstLogin = isFirstLogin;
	}
	public long getFirstLoginTime() {
		return firstLoginTime;
	}
	public void setFirstLoginTime(long firstLoginTime) {
		this.firstLoginTime = firstLoginTime;
	}
	
	
}
