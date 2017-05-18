package allone.MTP.VerBank01.Ctrl.comm.ipop.dsts;

/**
 * dealer踢出dealer
 * @author admin
 *
 */
public class IP_CtrlDSTS1002 extends CtrlDSTSIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4105252814744741990L;
	private String dealerName;
	private String clientId;
	private String newIPAddress;
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
	public String getNewIPAddress() {
		return newIPAddress;
	}
	public void setNewIPAddress(String newIPAddress) {
		this.newIPAddress = newIPAddress;
	}
	
	
}
