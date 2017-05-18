package jedi.ex01.CSTS3.comm.jsondata;

import jedi.ex01.CSTS3.comm.struct.QuoteSizeData;


public class QuoteSizeList extends allone.json.AbstractJsonData {

	public static final String jsonId = "QuoteSizeList";

	public static final String sizes = "1";

	public QuoteSizeList(){
		super();
		setEntry("jsonId", jsonId);
	}

	public QuoteSizeData[] getSizes() {
		try {
			QuoteSizeData[] data=getEntryObjectVec(QuoteSizeList.sizes,new QuoteSizeData[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setSizes(QuoteSizeData[] sizes) {
		setEntry(QuoteSizeList.sizes, sizes);
	}


}