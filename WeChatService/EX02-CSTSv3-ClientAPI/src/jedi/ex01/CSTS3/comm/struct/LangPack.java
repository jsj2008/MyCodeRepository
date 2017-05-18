package jedi.ex01.CSTS3.comm.struct;

import java.util.HashMap;

public class LangPack extends allone.json.AbstractJsonData {

	public static final String jsonId = "12";

	public static final String treeLangMap = "1";
	public static final String instrumentLangMap = "2";

	public LangPack() {
		super();
		setEntry("jsonId", jsonId);
	}

	@SuppressWarnings("unchecked")
	public HashMap getTreeLangMap() {
		try {
			HashMap data = getEntryObject(LangPack.treeLangMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setTreeLangMap(HashMap treeLangMap) {
		setEntry(LangPack.treeLangMap, treeLangMap);
	}

	@SuppressWarnings("unchecked")
	public HashMap getInstrumentLangMap() {
		try {
			HashMap data = getEntryObject(LangPack.instrumentLangMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setInstrumentLangMap(HashMap instrumentLangMap) {
		setEntry(LangPack.instrumentLangMap, instrumentLangMap);
	}

	@SuppressWarnings("unchecked")
	public String getInstrumentName(String instrument) {
		HashMap map = getInstrumentLangMap();
		if (map.containsKey(instrument))
			return (String) map.get(instrument);

		else
			return instrument;
	}

	@SuppressWarnings("unchecked")
	public String getTreeNodeName(String treeNodeType) {
		HashMap map = getTreeLangMap();
		if (map.containsKey(treeNodeType))
			return (String) map.get(treeNodeType);

		else
			return treeNodeType;
	}

}