package jedi.ex02.CSTS3.comm.ipop;
//package jedi.ex01.CSTS3.comm.ipop;
//
//import jedi.v7.trade.comm.IPOP.IP_TRADESERV5027;
//
//public class C3_IP_TRADESERV5027 extends C3_IPFather{
//	
//	public static final String jsonId = "IP_TRADESERV5027";
//	public static final String accountID = "1";
//	public static final String aeid = "2";
//	public static final String type = "3";
//
//	public C3_IP_TRADESERV5027() {
//		super();
//		setEntry("jsonId", jsonId);
//		System.out.println("tesssss");
//	}
//	
//	public IP_TRADESERV5027 formatIP() {
//		IP_TRADESERV5027 ip = new IP_TRADESERV5027();
//		ip.setAccount(getAccountID());
//		ip.setAeid(getAeid());
//		return ip;
//	}
//	
//	public void setAccountID(long accountID) {
//		super.setEntry(C3_IP_TRADESERV5027.accountID, accountID);
//	}
//	
//	public long getAccountID() {
//		try {
//			return super.getEntryLong(C3_IP_TRADESERV5027.accountID);
//		} catch (Exception e) {
//			// TODO: handle exception
//			return 0;
//		}
//	}
//	
//	public void setAeid(String aeid) {
//		super.setEntry(C3_IP_TRADESERV5027.aeid, aeid);
//	}
//	
//	public String getAeid() {
//		try {
//			return super.getEntryString(C3_IP_TRADESERV5027.aeid);
//		} catch (Exception e) {
//			// TODO: handle exception
//			return null;
//		}
//	}
//	
//	public void setType(int type) {
//		super.setEntry(C3_IP_TRADESERV5027.type, type);
//	}
//	
//	public int getType() {
//		try {
//			return super.getEntryInt(C3_IP_TRADESERV5027.type);
//		} catch (Exception e) {
//			// TODO: handle exception
//			return 0;
//		}
//	}
//
//}
