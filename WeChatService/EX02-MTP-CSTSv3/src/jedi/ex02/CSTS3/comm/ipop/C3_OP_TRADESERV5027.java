package jedi.ex02.CSTS3.comm.ipop;
//package jedi.ex01.CSTS3.comm.ipop;
//
//import jedi.v7.trade.comm.IPOP.OP_TRADESERV5027;
//
//public class C3_OP_TRADESERV5027 extends C3_OPFather{
//	public static final String jsonId = "OP_TRADESERV5027";
//	public static final String groupName = "1";
//	
//	public C3_OP_TRADESERV5027(jedi.ex01.CSTS3.comm.ipop.C3_IPFather ip){
//		super(ip);
//		setEntry("jsonId", jsonId);
////		setGroupName(groupName)
//	}
//	
//	public void parseFromSysData(OP_TRADESERV5027 data) throws Exception {
//		super.parseFromSysData(data);
////		C3_Instrument[] instrumentVec = new C3_Instrument[data.getInstrumentVec().length];
////		for (int i = 0; i < data.getInstrumentVec().length; i++) {
////			instrumentVec[i]=new C3_Instrument();
////			instrumentVec[i].parseFromSysData(data.getInstrumentVec()[i]);
////		}
////		setInstrumentVec(instrumentVec);
//		String groupNameString = data.getGroupName();
//		System.out.println("name is :" + groupNameString);
//		setGroupName(groupNameString);
//	}
//	
//	
//	public void setGroupName(String groupName) {
//		setEntry(C3_OP_TRADESERV5027.groupName, groupName);
//	}
//	
//	public String getGroupName() {
//		try {
//			return super.getEntryString(C3_OP_TRADESERV5027.groupName);
//		} catch (Exception e) {
//			// TODO: handle exception
//			return null;
//		}
//	}
//
//	
//}
// 