package allone.MTP.VerBank01.Ctrl.doc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import allone.MTP.VerBank01.Ctrl.captain.StaticContext;
import allone.MTP.VerBank01.comm.datastruct.DB.OtherClientConfig;

public class DocCaptain {

	private DocOperator docOperator = new DocOperator();

	private volatile Map<String, Map<String, OtherClientConfig>> otherCfgConfigMap;

	public boolean init() {
		initClientConfig();
		return true;
	}

	public void destroy() {
		otherCfgConfigMap.clear();
	}
	
	private void initClientConfig() {
		for (; StaticContext.isStillRunning();) {
			if (refreshOtherClientConfig()) {
				break;
			}
			
			try {
				Thread.sleep(5000);
			} catch (Exception e) {
			}
		}
	}
	
	public boolean refreshOtherClientConfig() {
		OtherClientConfig[] configs = docOperator.loadOtherConfig();
		if (configs == null) {
			return false;
		}
		
		Map<String, Map<String, OtherClientConfig>> tmp = new HashMap<String, Map<String, OtherClientConfig>>();
		for (OtherClientConfig occ : configs) {
			Map<String, OtherClientConfig> occMap = tmp.get(occ.getKey());
			if (occMap == null) {
				occMap = new HashMap<String, OtherClientConfig>();
				tmp.put(occ.getKey(), occMap);
			}
			
			occMap.put(occ.getLocale().toString(), occ);
		}
		
		otherCfgConfigMap = tmp;
		return true;
	}

	public OtherClientConfig getOtherClientConfig(String key, Locale locale) {
		Map<String, OtherClientConfig> tempMap = otherCfgConfigMap.get(key);
		if (tempMap == null || tempMap.size() == 0) {
			return null;
		}
		String locVec[] = getSubLocaleVec(locale);
		OtherClientConfig occ = null;
		for (int i = locVec.length - 1; i >= 0; i--) {
			occ = tempMap.get(locVec[i]);
			if (occ != null) {
				return occ;
			}
		}
		Iterator<OtherClientConfig> it = tempMap.values().iterator();
		if (it.hasNext()) {
			return it.next();
		}
		return null;
	}

	public OtherClientConfig[] getOtherClientConfig(String keys[], Locale locale) {
		ArrayList<OtherClientConfig> list = new ArrayList<OtherClientConfig>();
		for (int i = 0; i < keys.length; i++) {
			OtherClientConfig ooc = getOtherClientConfig(keys[i], locale);
			if (ooc != null) {
				list.add(ooc);
			}
		}
		return list.toArray(new OtherClientConfig[0]);
	}

	private static String[] getSubLocaleVec(Locale locale) {
		ArrayList<String> list = new ArrayList<String>();
		String lang = locale.getLanguage();
		String country = locale.getCountry();
		String var = locale.getVariant();
		if (!lang.equals(Locale.ENGLISH.getLanguage())) {
			list.add(Locale.ENGLISH.toString());
		}
		list.add(lang);
		if (country.length() != 0) {
			list.add(lang + "_" + country);
			if (var.length() != 0) {
				list.add(lang + "_" + country + "_" + var);
			}
		}
		return list.toArray(new String[0]);
	}
}
