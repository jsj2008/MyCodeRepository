//package jedi.ex02.CSTS3.comm.ipop;
//package jedi.ex01.CSTS3.comm.ipop;
//
//import allone.quote.terminal.v01.comm.ipop.IP_QG1001;
//
//
//public class C3_IP_QG1001 extends jedi.ex01.CSTS3.comm.ipop.C3_IPFather {
//
//	public static final String jsonId = "IP_QG1001";
//
//	public static final int SEARCH_TYPE_ALL = 0;
//	public static final int SEARCH_TYPE_INSTRUMENTVECTOR = 1;
//	public static final String searchType = "3";
//	public static final String instruments = "4";
//
//	public C3_IP_QG1001(){
//		super();
//		setEntry("jsonId", jsonId);
//	}
//
//	public IP_QG1001 formatIP() {
//		IP_QG1001 ip=new IP_QG1001();
////		ip.setSearchType(getSearchType());
////		ip.setInstruments(getInstruments());
//		return ip;
//	}
//
//	public int getSearchType() {
//		try {
//			int data=getEntryInt(C3_IP_QG1001.searchType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setSearchType(int searchType) {
//		setEntry(C3_IP_QG1001.searchType, searchType);
//	}
//
//	public String[] getInstruments() {
//		try {
//			String[] data=getEntryObjectVec(C3_IP_QG1001.instruments,new String[0]);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setInstruments(String[] instruments) {
//		setEntry(C3_IP_QG1001.instruments, instruments);
//	}
//
//
//}