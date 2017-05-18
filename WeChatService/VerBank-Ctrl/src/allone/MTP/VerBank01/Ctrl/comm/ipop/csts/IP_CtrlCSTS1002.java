package allone.MTP.VerBank01.Ctrl.comm.ipop.csts;

/**
 * 用户踢出用户
 * @author admin
 *
 */
public class IP_CtrlCSTS1002 extends CtrlCSTSIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5784446808039453177L;
	private String aeid;
	private String clientId;
	private String newIPAddress;
	public String getAeid() {
		return aeid;
	}
	public void setAeid(String aeid) {
		this.aeid = aeid;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getNewIPAddress() {
		return newIPAddress;
	}
	public void setNewIPAddress(String newIPAddress) {
		this.newIPAddress = newIPAddress;
	}
	
	
	
}
