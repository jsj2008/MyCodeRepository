package jedi.ex01.CSTS3.comm.info;


public class Info_TRADESERV1016 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1016";

	public static final String timedoutInstruments = "1";
	public static final String closedInstruments = "2";

	public Info_TRADESERV1016(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String[] getTimedoutInstruments() {
		try {
			String[] data=getEntryObjectVec(Info_TRADESERV1016.timedoutInstruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTimedoutInstruments(String[] timedoutInstruments) {
		setEntry(Info_TRADESERV1016.timedoutInstruments, timedoutInstruments);
	}

	public String[] getClosedInstruments() {
		try {
			String[] data=getEntryObjectVec(Info_TRADESERV1016.closedInstruments,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setClosedInstruments(String[] closedInstruments) {
		setEntry(Info_TRADESERV1016.closedInstruments, closedInstruments);
	}


}