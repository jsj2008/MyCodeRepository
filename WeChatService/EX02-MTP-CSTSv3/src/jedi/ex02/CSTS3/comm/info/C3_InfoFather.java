package jedi.ex02.CSTS3.comm.info;

import jedi.v7.comm.datastruct.information.InforFather;
import jedi.v7.trade.comm.infor.TradeServInfoFather;
import allone.Log.simpleLog.log.LogProxy;
import allone.json.AbstractJsonData;

public class C3_InfoFather extends AbstractJsonData {

	public static final String jsonId = "ipf";

	public static final String id = "-1";
	public static final String infoTime = "-2";
	public static final String aeid = "-3";

	public C3_InfoFather(InforFather father) {
		super();
		setEntry("jsonId", jsonId);

		String classname = getClass().getName();
		if (classname.indexOf("_") >= 0) {
			setEntry(C3_InfoFather.id, classname.substring(classname.lastIndexOf("_") + 1));
		} else {
			setEntry(C3_InfoFather.id, "InfoFather");
		}

		if (father != null) {
			try {
				parseFromSysData(father);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void parseFromSysData(InforFather father) throws Exception {
		LogProxy.printTrade(aeid, father, father, true);
		if (father instanceof TradeServInfoFather) {
			setEntry(C3_InfoFather.infoTime, ((TradeServInfoFather)father).get_infoTime());
		}
		setEntry(C3_InfoFather.aeid, father.getAeid());
	}

	public String getID() {
		try {
			String data = getEntryString(C3_InfoFather.id);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public long getInfoTime() {
		try {
			long data = getEntryLong(C3_InfoFather.infoTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public String getAeid() {
		try {
			String data = getEntryString(C3_InfoFather.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

}
