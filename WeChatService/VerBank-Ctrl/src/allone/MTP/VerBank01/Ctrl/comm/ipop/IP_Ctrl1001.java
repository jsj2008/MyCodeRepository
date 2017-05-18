package allone.MTP.VerBank01.Ctrl.comm.ipop;

/**
 * 客户登陆
 * @author admin
 *
 */
public class IP_Ctrl1001 extends CtrlServerIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7839412709949836481L;
	private boolean isFirstLogin = false;
	private String password;
	private String aeid;
	private String userName;
	private String ipAddress;
	private String clientId;
	private long firstLoginTime = -1;
	private String version;
	
	public boolean isFirstLogin() {
		return isFirstLogin;
	}
	public void setFirstLogin(boolean isFirstLogin) {
		this.isFirstLogin = isFirstLogin;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAeid() {
		return aeid;
	}
	public void setAeid(String aeid) {
		this.aeid = aeid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public long getFirstLoginTime() {
		return firstLoginTime;
	}
	public void setFirstLoginTime(long firstLoginTime) {
		this.firstLoginTime = firstLoginTime;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}

	
}
