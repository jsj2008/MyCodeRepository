package jedi.ex02.CSTS3.comm.ipop;

import java.util.HashMap;
import java.util.Locale;

import jedi.v7.report.server.ipop.IP_REPORT2101;

public class C3_IP_REPORT2101 extends jedi.ex02.CSTS3.comm.ipop.C3_IPFather {

	public static final String jsonId = "IP_REPORT2101";

	public static final String reportName = "1";
	public static final String tableVec = "2";
	public static final String conditionMap = "3";
	public static final String locale = "4";

	public C3_IP_REPORT2101(){
		super();
		setEntry("jsonId", jsonId);
	}

	public IP_REPORT2101 formatIP() {
		IP_REPORT2101 ip=new IP_REPORT2101();
		ip.setReportName(getReportName());
		ip.setTableVec(getTableVec());
		ip.setConditionMap(getConditionMap());
		String[] locales=getLocale().split("_");
		if(locales.length==1){
			ip.setLocale(new Locale(locales[0]));
		}else if(locales.length==2){
			ip.setLocale(new Locale(locales[0],locales[1]));
		}else if(locales.length==3){
			ip.setLocale(new Locale(locales[0],locales[1],locales[2]));
		}
		return ip;
	}

	public String getReportName() {
		try {
			String data=getEntryString(C3_IP_REPORT2101.reportName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setReportName(String reportName) {
		setEntry(C3_IP_REPORT2101.reportName, reportName);
	}

	public String[] getTableVec() {
		try {
			String[] data=getEntryObjectVec(C3_IP_REPORT2101.tableVec,new String[0]);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTableVec(String[] tableVec) {
		setEntry(C3_IP_REPORT2101.tableVec, tableVec);
	}

	@SuppressWarnings("unchecked")
	public HashMap getConditionMap() {
		try {
			HashMap data=getEntryObject(C3_IP_REPORT2101.conditionMap);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public void setConditionMap(HashMap conditionMap) {
		setEntry(C3_IP_REPORT2101.conditionMap, conditionMap);
	}

	public String getLocale() {
		try {
			String data=getEntryString(C3_IP_REPORT2101.locale);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setLocale(String locale) {
		setEntry(C3_IP_REPORT2101.locale, locale);
	}


}