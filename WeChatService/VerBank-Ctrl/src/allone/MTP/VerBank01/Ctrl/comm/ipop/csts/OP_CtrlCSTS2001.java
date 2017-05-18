package allone.MTP.VerBank01.Ctrl.comm.ipop.csts;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserMsgNode;

public class OP_CtrlCSTS2001 extends CtrlCSTSOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2694643742680829977L;
	private UserMsgNode[] userList;
	
	public OP_CtrlCSTS2001(CtrlCSTSIPFather ip) {
		super(ip);
	}

	public UserMsgNode[] getUserList() {
		return userList;
	}

	public void setUserList(UserMsgNode[] userList) {
		this.userList = userList;
	}
	
}
