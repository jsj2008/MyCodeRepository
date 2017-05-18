package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl4001 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5812442825138810988L;
	private int result;
	
	public OP_Ctrl4001(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	
}
