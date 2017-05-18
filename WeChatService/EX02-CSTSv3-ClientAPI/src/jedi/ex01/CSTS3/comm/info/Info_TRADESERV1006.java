package jedi.ex01.CSTS3.comm.info;


public class Info_TRADESERV1006 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1006";

	public static final String closeState = "1";
	public static final String tradeDay = "2";

	public Info_TRADESERV1006(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getCloseState() {
		try {
			int data=getEntryInt(Info_TRADESERV1006.closeState);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseState(int closeState) {
		setEntry(Info_TRADESERV1006.closeState, closeState);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(Info_TRADESERV1006.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(Info_TRADESERV1006.tradeDay, tradeDay);
	}


}