package jedi.ex01.CSTS3.comm.ipop;

import java.util.HashMap;

public class IP_REPORT2101 extends jedi.ex01.CSTS3.comm.ipop.IPFather {

	public static final String jsonId = "IP_REPORT2101";

	public static final String reportName = "1";
	public static final String tableVec = "2";
	public static final String conditionMap = "3";
	public static final String locale = "4";

	public IP_REPORT2101(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getReportName() {
		try {
			String data=getEntryString(IP_REPORT2101.reportName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportName(String reportName) {
		setEntry(IP_REPORT2101.reportName, reportName);
	}

	public String[] getTableVec() {
		try {
			String[] data=getEntryObjectVec(IP_REPORT2101.tableVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTableVec(String[] tableVec) {
		setEntry(IP_REPORT2101.tableVec, tableVec);
	}

	@SuppressWarnings("unchecked")
	public HashMap getConditionMap() {
		try {
			HashMap data=getEntryObject(IP_REPORT2101.conditionMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setConditionMap(HashMap conditionMap) {
		setEntry(IP_REPORT2101.conditionMap, conditionMap);
	}

	public String getLocale() {
		try {
			String data=getEntryString(IP_REPORT2101.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(IP_REPORT2101.locale, locale);
	}


}