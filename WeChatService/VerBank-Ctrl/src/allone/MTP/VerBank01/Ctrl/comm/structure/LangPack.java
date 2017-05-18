package allone.MTP.VerBank01.Ctrl.comm.structure;

import java.io.Serializable;
import java.util.HashMap;

public class LangPack implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1498538625668679989L;
	
	private HashMap<String, String> treeLangMap=new HashMap<String, String>();
	private HashMap<String, String> instrumentLangMap=new HashMap<String, String>();

	public void setTreeLangMap(HashMap<String, String> treeLangMap) {
		this.treeLangMap = treeLangMap;
	}


	public void setInstrumentLangMap(HashMap<String, String> instrumentLangMap) {
		this.instrumentLangMap = instrumentLangMap;
	}

	public String getInstrumentName(String instrument){
		if(instrumentLangMap.containsKey(instrument)){
			return (String) instrumentLangMap.get(instrument);
		}
		return instrument;
	}
	
	public String getTreeNodeName(String treeNodeType){
		if(treeLangMap.containsKey(treeNodeType)){
			return (String) treeLangMap.get(treeNodeType);
		}
		return treeNodeType;
	}


	public HashMap<String, String> getTreeLangMap() {
		return treeLangMap;
	}


	public HashMap<String, String> getInstrumentLangMap() {
		return instrumentLangMap;
	}

}
