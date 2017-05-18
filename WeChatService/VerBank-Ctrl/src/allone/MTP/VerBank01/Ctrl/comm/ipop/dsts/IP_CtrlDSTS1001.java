package allone.MTP.VerBank01.Ctrl.comm.ipop.dsts;

/**
 * 系统踢出Dealer
 * @author admin
 *
 */
public class IP_CtrlDSTS1001 extends CtrlDSTSIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4582051347921514928L;
	private String dealerName;
	private long forbiddenGapInMs;
	public String getDealerName() {
		return dealerName;
	}
	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}
	public long getForbiddenGapInMs() {
		return forbiddenGapInMs;
	}
	public void setForbiddenGapInMs(long forbiddenGapInMs) {
		this.forbiddenGapInMs = forbiddenGapInMs;
	}
	
	
}
