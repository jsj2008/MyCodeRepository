package jedi.ex01.CSTS3.comm.struct;


public class OtherClientConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "16";

	public static final String key = "1";
	public static final String locale = "2";
	public static final String type = "3";
	public static final String link = "4";
	public static final String value = "6";

	public OtherClientConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getKey() {
		try {
			String data=getEntryString(OtherClientConfig.key);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setKey(String key) {
		setEntry(OtherClientConfig.key, key);
	}

	public String getLocale() {
		try {
			String data=getEntryString(OtherClientConfig.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(OtherClientConfig.locale, locale);
	}

	public int getType() {
		try {
			int data=getEntryInt(OtherClientConfig.type);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setType(int type) {
		setEntry(OtherClientConfig.type, type);
	}

	public String getLink() {
		try {
			String data=getEntryString(OtherClientConfig.link);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLink(String link) {
		setEntry(OtherClientConfig.link, link);
	}

	public String getValue() {
		try {
			String data=getEntryString(OtherClientConfig.value);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setValue(String value) {
		setEntry(OtherClientConfig.value, value);
	}


}