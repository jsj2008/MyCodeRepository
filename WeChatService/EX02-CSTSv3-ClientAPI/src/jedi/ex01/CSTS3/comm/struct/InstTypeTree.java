package jedi.ex01.CSTS3.comm.struct;


public class InstTypeTree extends allone.json.AbstractJsonData {

	public static final String jsonId = "10";

	public static final String typeName = "1";
	public static final String parentType = "2";
	public static final String sort = "3";

	public InstTypeTree(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTypeName() {
		try {
			String data=getEntryString(InstTypeTree.typeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTypeName(String typeName) {
		setEntry(InstTypeTree.typeName, typeName);
	}

	public String getParentType() {
		try {
			String data=getEntryString(InstTypeTree.parentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setParentType(String parentType) {
		setEntry(InstTypeTree.parentType, parentType);
	}

	public int getSort() {
		try {
			int data=getEntryInt(InstTypeTree.sort);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setSort(int sort) {
		setEntry(InstTypeTree.sort, sort);
	}


}