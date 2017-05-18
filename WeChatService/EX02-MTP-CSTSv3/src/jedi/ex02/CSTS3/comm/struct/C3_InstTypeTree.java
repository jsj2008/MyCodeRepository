package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.InstTypeTree;


public class C3_InstTypeTree extends allone.json.AbstractJsonData {

	public static final String jsonId = "10";

	public static final String typeName = "1";
	public static final String parentType = "2";
	public static final String sort = "3";

	public C3_InstTypeTree(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(InstTypeTree data) throws Exception {
		setTypeName(data.getTypeName());
		setParentType(data.getParentType());
		setSort(data.getSort());
	}

	public InstTypeTree format(){
		InstTypeTree data=new InstTypeTree();
		data.setTypeName(getTypeName());
		data.setParentType(getParentType());
		data.setSort(getSort());
		return data;
	}


	public String getTypeName() {
		try {
			String data=getEntryString(C3_InstTypeTree.typeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTypeName(String typeName) {
		setEntry(C3_InstTypeTree.typeName, typeName);
	}

	public String getParentType() {
		try {
			String data=getEntryString(C3_InstTypeTree.parentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setParentType(String parentType) {
		setEntry(C3_InstTypeTree.parentType, parentType);
	}

	public int getSort() {
		try {
			int data=getEntryInt(C3_InstTypeTree.sort);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSort(int sort) {
		setEntry(C3_InstTypeTree.sort, sort);
	}


}