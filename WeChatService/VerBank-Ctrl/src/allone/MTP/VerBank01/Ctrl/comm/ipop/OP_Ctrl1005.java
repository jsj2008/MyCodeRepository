package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl1005 extends CtrlServerOPFather {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5767052341496770207L;
	private String[] ipList;
	
	public OP_Ctrl1005(CtrlServerIPFather ip) {
		super(ip);
	}

	public String[] getIpList() {
		return ipList;
	}

	public void setIpList(String[] ipList) {
		this.ipList = ipList;
	}
}
