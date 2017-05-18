package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl1004 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7414417097372176125L;
	private String[] ipList;
	
	public OP_Ctrl1004(CtrlServerIPFather ip) {
		super(ip);
	}

	public String[] getIpList() {
		return ipList;
	}

	public void setIpList(String[] ipList) {
		this.ipList = ipList;
	}

	
}
