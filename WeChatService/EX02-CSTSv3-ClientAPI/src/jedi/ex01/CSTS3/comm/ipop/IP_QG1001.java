package jedi.ex01.CSTS3.comm.ipop;


public class IP_QG1001 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_QG1001";

	public static final int SEARCH_TYPE_ALL = 0;
	public static final int SEARCH_TYPE_INSTRUMENTVECTOR = 1;
	public static final String searchType = "3";
	public static final String instruments = "4";

	public IP_QG1001(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getSearchType() {
		try {
			int data=getEntryInt(IP_QG1001.searchType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSearchType(int searchType) {
		setEntry(IP_QG1001.searchType, searchType);
	}

	public String[] getInstruments() {
		try {
			String[] data=getEntryObjectVec(IP_QG1001.instruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstruments(String[] instruments) {
		setEntry(IP_QG1001.instruments, instruments);
	}


}