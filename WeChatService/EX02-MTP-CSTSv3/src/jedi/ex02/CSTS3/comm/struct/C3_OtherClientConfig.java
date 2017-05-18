package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.OtherClientConfig;


public class C3_OtherClientConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "16";

	public static final String key = "1";
	public static final String locale = "2";
	public static final String type = "3";
	public static final String link = "4";
	public static final String value = "6";

	public C3_OtherClientConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OtherClientConfig data) throws Exception {
		setKey(data.getKey());
		setLocale(data.getLocale());
		setType(data.getType());
		setLink(data.getLink());
		setValue(data.getValue());
	}

	public OtherClientConfig format(){
		OtherClientConfig data=new OtherClientConfig();
		data.setKey(getKey());
		data.setLocale(getLocale());
		data.setType(getType());
		data.setLink(getLink());
		data.setValue(getValue());
		return data;
	}


	public String getKey() {
		try {
			String data=getEntryString(C3_OtherClientConfig.key);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKey(String key) {
		setEntry(C3_OtherClientConfig.key, key);
	}

	public String getLocale() {
		try {
			String data=getEntryString(C3_OtherClientConfig.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(C3_OtherClientConfig.locale, locale);
	}

	public int getType() {
		try {
			int data=getEntryInt(C3_OtherClientConfig.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(C3_OtherClientConfig.type, type);
	}

	public String getLink() {
		try {
			String data=getEntryString(C3_OtherClientConfig.link);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLink(String link) {
		setEntry(C3_OtherClientConfig.link, link);
	}

	public String getValue() {
		try {
			String data=getEntryString(C3_OtherClientConfig.value);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setValue(String value) {
		setEntry(C3_OtherClientConfig.value, value);
	}

}