package jedi.ex02.CSTS3.comm.ipop;

import java.util.HashMap;

import jedi.v7.trade.comm.IPOP.OP_TRADESERV3001;

import org.apache.poi.hssf.record.formula.functions.Setvalue;

/**
 * 银行出入金相关2016年8月9日16:47:59
 * 
 * @author ALLONE
 * 
 */
public class C3_OP_TRADESERV3001 extends jedi.ex02.CSTS3.comm.ipop.C3_OPFather {

	public static final String jsonId = "OP_TRADESERV3001";

	public C3_OP_TRADESERV3001(jedi.ex02.CSTS3.comm.ipop.C3_IPFather ip) {
		super(ip);
		setEntry("jsonId", jsonId);

	}

	public final static int RESULT_STATUS_OK = 0;
	public final static int RESULT_STATUS_ACCOUNT_NEED_TO_BALANCE = -1;

	// private double amount;
	// private String comment;

	public static final String value = "1";
	public static final String resultStatus = "2";

	private final HashMap<Long, Double> valueMap = new HashMap<Long, Double>();

	public void parseFromSysData(OP_TRADESERV3001 data) throws Exception {
		super.parseFromSysData(data);
		setValue(data.getValue());
		setResultStatus(data.getResultStatus());
		// setValueMap(data.getValueMap());
		// setValueMap(null);

	}

	// public static final String valueMap = "3";

	// private double value;
	public double getValue() {
		try {
			double data = getEntryDouble(C3_OP_TRADESERV3001.value);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValue(double value) {
		setEntry(C3_OP_TRADESERV3001.value, value);
	}

	// private int resultStatus;
	public int getResultStatus() {
		try {
			int data = getEntryInt(C3_OP_TRADESERV3001.resultStatus);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResultStatus(int resultStatus) {
		setEntry(C3_OP_TRADESERV3001.resultStatus, resultStatus);
	}

	// // private HashMap<Long, Double> valueMap = new HashMap<Long, Double>();
	// public HashMap<Long, Double> getValueMap() {
	// try {
	// HashMap<Long, Double> data =
	// getEntryObject(C3_OP_TRADESERV3001.valueMap);
	// return data;
	// } catch (RuntimeException e) {
	// return null;
	// }
	// }
	//
	// public void setValueMap(HashMap<Long, Double> valueMap) {
	// setEntry(C3_OP_TRADESERV3001.valueMap, valueMap);
	// }

	public void addValue(long acid, double value) {
		valueMap.put(acid, value);
	}

	public double getValue(long acid) {
		if (valueMap.containsKey(acid)) {
			return valueMap.get(acid);
		}
		return 0;
	}

	public Long[] getAccountVector() {
		return (Long[]) valueMap.keySet().toArray(new Long[0]);
	}

}