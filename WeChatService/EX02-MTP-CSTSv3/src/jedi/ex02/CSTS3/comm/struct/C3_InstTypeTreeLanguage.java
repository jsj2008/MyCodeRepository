package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.InstTypeTreeLanguage;


public class C3_InstTypeTreeLanguage extends allone.json.AbstractJsonData {

	public static final String jsonId = "11";

	public static final String typeName = "1";
	public static final String local = "2";
	public static final String showName = "3";
	public static final String description = "4";

	public C3_InstTypeTreeLanguage(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(InstTypeTreeLanguage data) throws Exception {
		setTypeName(data.getTypeName());
		setLocal(data.getLocal());
		setShowName(data.getShowName());
		setDescription(data.getDescription());
	}

	public InstTypeTreeLanguage format(){
		InstTypeTreeLanguage data=new InstTypeTreeLanguage();
		data.setTypeName(getTypeName());
		data.setLocal(getLocal());
		data.setShowName(getShowName());
		data.setDescription(getDescription());
		return data;
	}


	public String getTypeName() {
		try {
			String data=getEntryString(C3_InstTypeTreeLanguage.typeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTypeName(String typeName) {
		setEntry(C3_InstTypeTreeLanguage.typeName, typeName);
	}

	public String getLocal() {
		try {
			String data=getEntryString(C3_InstTypeTreeLanguage.local);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocal(String local) {
		setEntry(C3_InstTypeTreeLanguage.local, local);
	}

	public String getShowName() {
		try {
			String data=getEntryString(C3_InstTypeTreeLanguage.showName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setShowName(String showName) {
		setEntry(C3_InstTypeTreeLanguage.showName, showName);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_InstTypeTreeLanguage.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_InstTypeTreeLanguage.description, description);
	}


}