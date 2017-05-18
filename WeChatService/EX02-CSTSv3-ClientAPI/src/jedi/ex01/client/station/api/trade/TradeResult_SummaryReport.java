package jedi.ex01.client.station.api.trade;

import java.util.ArrayList;
import java.util.HashMap;

public class TradeResult_SummaryReport {

	private boolean succeed = false;
	private String _errCode = "";
	private String _errMessage = "";
	private String OperateStreamGUID;

	public boolean isSucceed() {
		return succeed;
	}

	public void setSucceed(boolean succeed) {
		this.succeed = succeed;
	}

	public String get_errCode() {
		return _errCode;
	}

	public void set_errCode(String code) {
		_errCode = code;
	}

	public String get_errMessage() {
		return _errMessage;
	}

	public void set_errMessage(String message) {
		_errMessage = message;
	}

	public String getOperateStreamGUID() {
		return OperateStreamGUID;
	}

	public void setOperateStreamGUID(String operateStreamGUID) {
		OperateStreamGUID = operateStreamGUID;
	}

	public final static int TABLE_ACCOUNTSUMMARY = 1;
	public final static int TABLE_CLOSEDPOSITION = 3;
	public final static int TABLE_OPENPOSITION = 4;
	public final static int TABLE_ACCOUNTSTREAM = 5;
	public final static int TABLE_OPENORDER = 6;

	private HashMap<Integer, ArrayList> tableMap = new HashMap<Integer, ArrayList>();

	private HashMap<Integer, HashMap<String, Object>> summaryMap = new HashMap<Integer, HashMap<String, Object>>();

	public HashMap<Integer, ArrayList> getTableMap() {
		return tableMap;
	}

	public void setTableMap(HashMap<Integer, ArrayList> tableMap) {
		this.tableMap = tableMap;
	}

	public void addTable(int tableId, ArrayList tableList) {
		tableMap.put(tableId, tableList);
	}

	public HashMap<Integer, HashMap<String, Object>> getSummaryMap() {
		return summaryMap;
	}

	public void setSummaryMap(
			HashMap<Integer, HashMap<String, Object>> summaryMap) {
		this.summaryMap = summaryMap;
	}

}
