package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl4002 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3063941120253584168L;
	private int checkType;
	
	public OP_Ctrl4002(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getCheckType() {
		return checkType;
	}

	public void setCheckType(int checkType) {
		this.checkType = checkType;
	}

}
