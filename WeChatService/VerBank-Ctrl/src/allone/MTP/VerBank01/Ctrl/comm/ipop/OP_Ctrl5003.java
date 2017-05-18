package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserCertState;

public class OP_Ctrl5003 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9039229938543168713L;

	public OP_Ctrl5003(CtrlServerIPFather ip) {
		super(ip);
	}
	
	private UserCertState state;

	public UserCertState getState() {
		return state;
	}

	public void setState(UserCertState state) {
		this.state = state;
	}

}
