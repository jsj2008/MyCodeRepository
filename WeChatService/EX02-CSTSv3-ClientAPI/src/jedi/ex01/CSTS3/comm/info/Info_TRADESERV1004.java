package jedi.ex01.CSTS3.comm.info;


public class Info_TRADESERV1004 extends jedi.ex01.CSTS3.comm.info.InfoFather {

	public static final String jsonId = "Info_TRADESERV1004";

	public static final int ATTRID_SYSTEMCONFIG = 0;
	public static final int ATTRID_INSTRUMENT = 1;
	public static final int ATTRID_TRADETYPE = 2;
	public static final int ATTRID_ROLLOVER = 3;
	public static final int ATTRID_HOLIDAY = 4;
	public static final int ATTRID_BATCHRATEGAP = 5;
	public static final int ATTRID_GROUPCONFIG = 6;
	public static final int ATTRID_INSTRUMENTTYPE = 7;
	public static final int ATTRID_INSTRUMENTDEAD = 9;
	public static final int ATTRID_GROUPDELETE = 13;
	public static final String changedAttrID = "12";
	public static final String attriName = "13";
	
	public static final int ATTRID_BASICCURRENCY = 8;
	public static final int ATTRID_IBCHARGESTRATEGY = 10;
	public static final int ATTRID_ABNORMALTRADECHECKCONFIG = 11;
	public static final int ATTRID_TRADECTRLSTRATEGY = 12;

	public Info_TRADESERV1004(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getChangedAttrID() {
		try {
			int data=getEntryInt(Info_TRADESERV1004.changedAttrID);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setChangedAttrID(int changedAttrID) {
		setEntry(Info_TRADESERV1004.changedAttrID, changedAttrID);
	}

	public String getAttriName() {
		try {
			String data=getEntryString(Info_TRADESERV1004.attriName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setAttriName(String attriName) {
		setEntry(Info_TRADESERV1004.attriName, attriName);
	}


}