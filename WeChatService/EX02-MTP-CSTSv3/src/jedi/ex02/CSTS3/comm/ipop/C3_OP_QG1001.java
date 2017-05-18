//package jedi.ex02.CSTS3.comm.ipop;
//
//import jedi.ex02.CSTS3.comm.struct.C3_QuoteData;
//import jedi.v7.quote.common.QuoteData;
//import allone.quote.terminal.v01.comm.ipop.OP_QG1001;
//
//
//public class C3_OP_QG1001 extends jedi.ex01.CSTS3.comm.ipop.C3_OPFather {
//
//	public static final String jsonId = "OP_QG1001";
//
//	public static final String quoteList = "1";
//
//	public C3_OP_QG1001(jedi.ex01.CSTS3.comm.ipop.C3_IPFather ip){
//		super(ip);
//		setEntry("jsonId", jsonId);
//	}
//
//	public void parseFromSysData(OP_QG1001 data) throws Exception {
//		super.parseFromSysData(data);
//		C3_QuoteData[] quoteList = new C3_QuoteData[data.getQuoteList().size()];
//		for (int i = 0; i < data.getQuoteList().size(); i++) {
//			quoteList[i]=new C3_QuoteData();
//			quoteList[i].parseFromSysData((QuoteData) data.getQuoteList().get(i));
//		}
//		setQuoteList(quoteList);
//	}
//
//
//	public C3_QuoteData[] getQuoteList() {
//		try {
//			C3_QuoteData[] data=getEntryObjectVec(C3_OP_QG1001.quoteList,new C3_QuoteData[0]);
//			return data;
//		} catch (RuntimeException e) {
//			return null;
//		}
//	}
//
//	public void setQuoteList(C3_QuoteData[] quoteList) {
//		setEntry(C3_OP_QG1001.quoteList, quoteList);
//	}
//
//
//}