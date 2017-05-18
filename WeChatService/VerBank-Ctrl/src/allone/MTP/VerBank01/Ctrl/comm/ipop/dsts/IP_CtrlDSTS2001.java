package allone.MTP.VerBank01.Ctrl.comm.ipop.dsts;

public class IP_CtrlDSTS2001 extends CtrlDSTSIPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 862332857493267883L;
	public final static int TYPE_ALL = 0;
	public final static int TYPE_ONE = 1;
	
	private int type;
	private String dealerName;

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getDealerName() {
		return dealerName;
	}

	public void setDealerName(String dealerName) {
		this.dealerName = dealerName;
	}
	
	
}
