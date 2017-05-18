package jedi.ex02.CSTS3.comm.struct;

import java.util.HashMap;

import jedi.v7.ctrl.comm.LangPack;

public class C3_LangPack extends allone.json.AbstractJsonData {

	public static final String jsonId = "12";

	public static final String treeLangMap = "1";
	public static final String instrumentLangMap = "2";

	public C3_LangPack(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(LangPack data) throws Exception {
		setTreeLangMap(data.getTreeLangMap());
		setInstrumentLangMap(data.getInstrumentLangMap());
	}

	public LangPack format(){
		LangPack data=new LangPack();
		data.setTreeLangMap(getTreeLangMap());
		data.setInstrumentLangMap(getInstrumentLangMap());
		return data;
	}


	@SuppressWarnings("unchecked")
	public HashMap getTreeLangMap() {
		try {
			HashMap data=getEntryObject(C3_LangPack.treeLangMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setTreeLangMap(HashMap treeLangMap) {
		setEntry(C3_LangPack.treeLangMap, treeLangMap);
	}

	@SuppressWarnings("unchecked")
	public HashMap getInstrumentLangMap() {
		try {
			HashMap data=getEntryObject(C3_LangPack.instrumentLangMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setInstrumentLangMap(HashMap instrumentLangMap) {
		setEntry(C3_LangPack.instrumentLangMap, instrumentLangMap);
	}


}