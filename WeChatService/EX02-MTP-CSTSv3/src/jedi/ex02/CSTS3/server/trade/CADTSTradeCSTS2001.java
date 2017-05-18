package jedi.ex02.CSTS3.server.trade;

import java.util.ArrayList;

import jedi.ex02.CSTS3.server.StaticContext;
import jedi.ex02.CSTS3.server.doc.UserNode;
import jedi.v7.comm.datastruct.IPOP.IPFather;
import jedi.v7.comm.datastruct.IPOP.OPFather;
import jedi.v7.ctrl.csts.comm.IPOP.IP_CSTS2001;
import jedi.v7.ctrl.csts.comm.IPOP.OP_CSTS2001;
import jedi.v7.ctrl.csts.comm.IPOP.UserMsgNode;

public class CADTSTradeCSTS2001 extends CADTSTradeFather {

	@Override
	protected OPFather doTrade(IPFather _ip, String fromServ) {
		IP_CSTS2001 ip = (IP_CSTS2001) _ip;
		OP_CSTS2001 op = new OP_CSTS2001(ip);
		ArrayList<UserMsgNode> userList=new ArrayList<UserMsgNode>();
		if (ip.getType() == IP_CSTS2001.TYPE_ALL) {
			UserNode[] users = StaticContext.getCSTSDoc().getUserList();
			for (int i = 0; i < users.length; i++) {
				UserNode userNode = users[i];
				UserMsgNode[] msgNodes = userNode.getUserMsgNode();
				for (UserMsgNode userMsgNode : msgNodes) {
					userList.add(userMsgNode);
				}
			}
			op.setUserList(userList);
		} else if (ip.getType() == IP_CSTS2001.TYPE_USER) {
			UserNode user = StaticContext.getCSTSDoc().getUserNode(
					ip.getUserName());
			if(user!=null){
				UserMsgNode umnVec[] = user.getUserMsgNode();
				for (int i = 0; i < umnVec.length; i++) {
					userList.add(umnVec[i]);
				}
			}
			op.setUserList(userList);
			op.setSucceed(true);
			return op;
		}
		op.setSucceed(true);
		return op;
	}

}
