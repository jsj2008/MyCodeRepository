package allone.MTP.VerBank01.Ctrl.comm.ipop.dsts;

import allone.MTP.VerBank01.Ctrl.comm.structure.DealerMsgNode;

public class OP_CtrlDSTS2001 extends CtrlDSTSOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3242483887683033069L;
	private DealerMsgNode[] dealer;
	
	public OP_CtrlDSTS2001(CtrlDSTSIPFather ip) {
		super(ip);
	}

	public DealerMsgNode[] getDealer() {
		return dealer;
	}

	public void setDealer(DealerMsgNode[] dealer) {
		this.dealer = dealer;
	}

	
}
