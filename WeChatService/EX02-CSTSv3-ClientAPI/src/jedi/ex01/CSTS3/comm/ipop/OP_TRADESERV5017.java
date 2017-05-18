package jedi.ex01.CSTS3.comm.ipop;

import jedi.ex01.CSTS3.comm.struct.GroupConfig;


public class OP_TRADESERV5017 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV5017";

	public static final String groupConfigVec = "1";

	public OP_TRADESERV5017(){
		super();
		setEntry("jsonId", jsonId);
	}

	public GroupConfig[] getGroupConfigVec() {
		try {
			GroupConfig[] data=getEntryObjectVec(OP_TRADESERV5017.groupConfigVec,new GroupConfig[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setGroupConfigVec(GroupConfig[] groupConfigVec) {
		setEntry(OP_TRADESERV5017.groupConfigVec, groupConfigVec);
	}


}