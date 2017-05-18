package jedi.ex02.CSTS3.comm.ipop;

import java.util.Date;
import java.util.HashMap;

import jedi.v7.report.server.ipop.OP_REPORT2101;

public class C3_OP_REPORT2101 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_REPORT2101";

	public static final String reportMap = "1";
	public static final String summaryMap = "2";
	public static final String reportName = "3";
	public static final String conditionMap = "4";
	public static final String tableVec = "5";
	public static final String locale = "6";
	public static final String reportTime = "7";

	public C3_OP_REPORT2101(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip){
		super(ip);
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(OP_REPORT2101 data) throws Exception {
		super.parseFromSysData(data);
		setReportMap(data.getReportMap());
		setSummaryMap(data.getSummaryMap());
		setReportName(data.getReportName());
		setConditionMap(data.getConditionMap());
		setTableVec(data.getTableVec());
		setLocale(data.getLocale().toString());
		setReportTime(data.getReportTime());
	}


	@SuppressWarnings("unchecked")
	public HashMap getReportMap() {
		try {
			HashMap data=getEntryObject(C3_OP_REPORT2101.reportMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setReportMap(HashMap reportMap) {
		setEntry(C3_OP_REPORT2101.reportMap, reportMap);
	}

	@SuppressWarnings("unchecked")
	public HashMap getSummaryMap() {
		try {
			HashMap data=getEntryObject(C3_OP_REPORT2101.summaryMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setSummaryMap(HashMap summaryMap) {
		setEntry(C3_OP_REPORT2101.summaryMap, summaryMap);
	}

	public String getReportName() {
		try {
			String data=getEntryString(C3_OP_REPORT2101.reportName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportName(String reportName) {
		setEntry(C3_OP_REPORT2101.reportName, reportName);
	}

	@SuppressWarnings("unchecked")
	public HashMap getConditionMap() {
		try {
			HashMap data=getEntryObject(C3_OP_REPORT2101.conditionMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setConditionMap(HashMap conditionMap) {
		setEntry(C3_OP_REPORT2101.conditionMap, conditionMap);
	}

	public String[] getTableVec() {
		try {
			String[] data=getEntryObjectVec(C3_OP_REPORT2101.tableVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTableVec(String[] tableVec) {
		setEntry(C3_OP_REPORT2101.tableVec, tableVec);
	}

	public String getLocale() {
		try {
			String data=getEntryString(C3_OP_REPORT2101.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(C3_OP_REPORT2101.locale, locale);
	}

	public Date getReportTime() {
		try {
			Date data=getEntryDate(C3_OP_REPORT2101.reportTime);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportTime(Date reportTime) {
		setEntry(C3_OP_REPORT2101.reportTime, reportTime);
	}


}