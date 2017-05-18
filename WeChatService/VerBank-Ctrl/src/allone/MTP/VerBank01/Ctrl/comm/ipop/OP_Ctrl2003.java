package allone.MTP.VerBank01.Ctrl.comm.ipop;

import java.util.List;

import allone.MTP.VerBank01.Ctrl.comm.structure.UserMsgNode;

public class OP_Ctrl2003 extends CtrlServerOPFather {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6712041513166033742L;
	private List<UserMsgNode> userList;
	public OP_Ctrl2003(CtrlServerIPFather ip) {
		super(ip);
	}

	public List<UserMsgNode> getUserList() {
		return userList;
	}

	public void setUserList(List<UserMsgNode> userList) {
		this.userList = userList;
	}

}
