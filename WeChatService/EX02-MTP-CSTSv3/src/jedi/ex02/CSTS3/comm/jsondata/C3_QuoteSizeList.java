package jedi.ex02.CSTS3.comm.jsondata;

import jedi.ex02.CSTS3.comm.struct.C3_QuoteSizeData;


public class C3_QuoteSizeList extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteSizeList";

	public static final String sizes = "1";

	public C3_QuoteSizeList(){
		super();
		setEntry("jsonId", jsonId);
	}

	public C3_QuoteSizeData[] getSizes() {
		try {
			C3_QuoteSizeData[] data=getEntryObjectVec(C3_QuoteSizeList.sizes,new C3_QuoteSizeData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSizes(C3_QuoteSizeData[] sizes) {
		setEntry(C3_QuoteSizeList.sizes, sizes);
	}


}