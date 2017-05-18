package allone.MTP.VerBank01.Ctrl.comm.ipop;

import allone.MTP.VerBank01.comm.datastruct.DB.OtherClientConfig;

public class OP_Ctrl2002 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2126607558285960775L;
	private boolean forceToReNew=true;
	private OtherClientConfig[] OtherClientConfigVec;
	public OP_Ctrl2002(CtrlServerIPFather ip) {
		super(ip);
	}
	public boolean isForceToReNew() {
		return forceToReNew;
	}
	public void setForceToReNew(boolean forceToReNew) {
		this.forceToReNew = forceToReNew;
	}
	public OtherClientConfig[] getOtherClientConfigVec() {
		return OtherClientConfigVec;
	}
	public void setOtherClientConfigVec(OtherClientConfig[] otherClientConfigVec) {
		OtherClientConfigVec = otherClientConfigVec;
	}

	
}
