package jedi.ex01.CSTS3.comm.info;

import allone.json.AbstractJsonData;

public class InfoFather extends AbstractJsonData {

	public static final String jsonId = "ipf";

	public static final String id = "-1";
	public static final String infoTime = "-2";
	public static final String aeid = "-3";

	public String getID() {
		try {
			String data = getEntryString(InfoFather.id);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public long getInfoTime() {
		try {
			long data = getEntryLong(InfoFather.infoTime);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public String getAeid() {
		try {
			String data = getEntryString(InfoFather.aeid);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

}
