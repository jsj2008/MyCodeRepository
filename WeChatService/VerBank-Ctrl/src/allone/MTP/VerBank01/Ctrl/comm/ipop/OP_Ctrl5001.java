package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl5001 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8560898802046325126L;
	private boolean verify;
	private String failedReason;
	
	public OP_Ctrl5001(CtrlServerIPFather ip) {
		super(ip);
	}

	public boolean isVerify() {
		return verify;
	}

	public void setVerify(boolean verify) {
		this.verify = verify;
	}

	public String getFailedReason() {
		return failedReason;
	}

	public void setFailedReason(String failedReason) {
		this.failedReason = failedReason;
	}

}
