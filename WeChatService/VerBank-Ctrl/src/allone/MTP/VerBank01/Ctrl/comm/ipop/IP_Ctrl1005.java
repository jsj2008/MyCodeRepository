package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class IP_Ctrl1005 extends CtrlServerIPFather {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8738237843212315655L;
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
