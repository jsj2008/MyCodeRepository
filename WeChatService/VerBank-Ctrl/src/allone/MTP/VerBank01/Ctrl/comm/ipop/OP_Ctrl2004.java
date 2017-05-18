package allone.MTP.VerBank01.Ctrl.comm.ipop;

import java.util.List;

import allone.MTP.VerBank01.Ctrl.comm.structure.DealerMsgNode;

public class OP_Ctrl2004 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6467863656355870136L;
	private List<DealerMsgNode> dealerList;
	public OP_Ctrl2004(CtrlServerIPFather ip) {
		super(ip);
	}
	public List<DealerMsgNode> getDealerList() {
		return dealerList;
	}
	public void setDealerList(List<DealerMsgNode> dealerList) {
		this.dealerList = dealerList;
	}

	
}
