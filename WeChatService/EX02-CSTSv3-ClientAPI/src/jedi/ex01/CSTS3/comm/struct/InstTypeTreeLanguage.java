package jedi.ex01.CSTS3.comm.struct;


public class InstTypeTreeLanguage extends allone.json.AbstractJsonData {

	public static final String jsonId = "11";

	public static final String typeName = "1";
	public static final String local = "2";
	public static final String showName = "3";
	public static final String description = "4";

	public InstTypeTreeLanguage(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTypeName() {
		try {
			String data=getEntryString(InstTypeTreeLanguage.typeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTypeName(String typeName) {
		setEntry(InstTypeTreeLanguage.typeName, typeName);
	}

	public String getLocal() {
		try {
			String data=getEntryString(InstTypeTreeLanguage.local);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocal(String local) {
		setEntry(InstTypeTreeLanguage.local, local);
	}

	public String getShowName() {
		try {
			String data=getEntryString(InstTypeTreeLanguage.showName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShowName(String showName) {
		setEntry(InstTypeTreeLanguage.showName, showName);
	}

	public String getDescription() {
		try {
			String data=getEntryString(InstTypeTreeLanguage.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(InstTypeTreeLanguage.description, description);
	}


}