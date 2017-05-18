package jedi.ex02.CSTS3.comm.ipop;


public class C3_IP_REPORT2902 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_REPORT2902";

	public static final String account = "1";
	public static final String fromTradeDay = "2";
	public static final String endTradeDay = "3";
	public static final String typeVec = "4";

	public C3_IP_REPORT2902(){
		super();
		setEntry("jsonId", jsonId);
	}

	public long getAccount() {
		try {
			long data=getEntryLong(C3_IP_REPORT2902.account);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAccount(long account) {
		setEntry(C3_IP_REPORT2902.account, account);
	}

	public String getFromTradeDay() {
		try {
			String data=getEntryString(C3_IP_REPORT2902.fromTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setFromTradeDay(String fromTradeDay) {
		setEntry(C3_IP_REPORT2902.fromTradeDay, fromTradeDay);
	}

	public String getEndTradeDay() {
		try {
			String data=getEntryString(C3_IP_REPORT2902.endTradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setEndTradeDay(String endTradeDay) {
		setEntry(C3_IP_REPORT2902.endTradeDay, endTradeDay);
	}

	public Integer[] getTypeVec() {
		try {
			Integer[] data=getEntryObjectVec(C3_IP_REPORT2902.typeVec,new Integer[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTypeVec(Integer[] typeVec) {
		setEntry(C3_IP_REPORT2902.typeVec, typeVec);
	}


}