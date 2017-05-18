package allone.MTP.VerBank01.Ctrl.comm.ipop;

public class OP_Ctrl4004 extends CtrlServerOPFather {

	private static final long serialVersionUID = 582066138558689185L;

	private int checkType;

	public OP_Ctrl4004(CtrlServerIPFather ip) {
		super(ip);
	}

	public int getCheckType() {
		return checkType;
	}

	public void setCheckType(int checkType) {
		this.checkType = checkType;
	}

}
