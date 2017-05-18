package jedi.ex01.CSTS3.comm.ipop;

import java.util.Date;
import java.util.HashMap;

public class OP_REPORT2101 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_REPORT2101";

	public static final String reportMap = "1";
	public static final String summaryMap = "2";
	public static final String reportName = "3";
	public static final String conditionMap = "4";
	public static final String tableVec = "5";
	public static final String locale = "6";
	public static final String reportTime = "7";

	public OP_REPORT2101(){
		super();
		setEntry("jsonId", jsonId);
	}

	@SuppressWarnings("unchecked")
	public HashMap getReportMap() {
		try {
			HashMap data=getEntryObject(OP_REPORT2101.reportMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setReportMap(HashMap reportMap) {
		setEntry(OP_REPORT2101.reportMap, reportMap);
	}

	@SuppressWarnings("unchecked")
	public HashMap getSummaryMap() {
		try {
			HashMap data=getEntryObject(OP_REPORT2101.summaryMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setSummaryMap(HashMap summaryMap) {
		setEntry(OP_REPORT2101.summaryMap, summaryMap);
	}

	public String getReportName() {
		try {
			String data=getEntryString(OP_REPORT2101.reportName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportName(String reportName) {
		setEntry(OP_REPORT2101.reportName, reportName);
	}

	@SuppressWarnings("unchecked")
	public HashMap getConditionMap() {
		try {
			HashMap data=getEntryObject(OP_REPORT2101.conditionMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setConditionMap(HashMap conditionMap) {
		setEntry(OP_REPORT2101.conditionMap, conditionMap);
	}

	public String[] getTableVec() {
		try {
			String[] data=getEntryObjectVec(OP_REPORT2101.tableVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTableVec(String[] tableVec) {
		setEntry(OP_REPORT2101.tableVec, tableVec);
	}

	public String getLocale() {
		try {
			String data=getEntryString(OP_REPORT2101.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(OP_REPORT2101.locale, locale);
	}

	public Date getReportTime() {
		try {
			Date data=getEntryDate(OP_REPORT2101.reportTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportTime(Date reportTime) {
		setEntry(OP_REPORT2101.reportTime, reportTime);
	}


}