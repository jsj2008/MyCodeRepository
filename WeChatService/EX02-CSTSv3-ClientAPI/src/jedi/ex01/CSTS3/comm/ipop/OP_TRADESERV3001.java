package jedi.ex01.CSTS3.comm.ipop;

import java.util.HashMap;

import jedi.ex01.client.station.api.bankserver.BankServClientIPFather;
import jedi.ex01.client.station.api.bankserver.BankServIPFather;
import jedi.ex01.client.station.api.bankserver.TradeServIPFather;
import jedi.ex01.client.station.api.bankserver.TradeServOPFather;

/**
 * 银行出入金相关
 * 
 * @author ALLONE
 * 
 */
public class OP_TRADESERV3001 extends jedi.ex01.CSTS3.comm.ipop.OPFather {

	public static final String jsonId = "OP_TRADESERV3001";

	public final static int RESULT_STATUS_OK = 0;
	public final static int RESULT_STATUS_ACCOUNT_NEED_TO_BALANCE = -1;
	public static final String value = "1";
	public static final String resultStatus = "2";
	// public static final String valueMap = "3";
	private final HashMap<Long, Double> valueMap = new HashMap<Long, Double>();

	public OP_TRADESERV3001() {
		super();
		setEntry("jsonId", jsonId);
	}

	// private double value;
	public double getValue() {
		try {
			double data = getEntryDouble(OP_TRADESERV3001.value);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setValue(double value) {
		setEntry(OP_TRADESERV3001.value, value);
	}

	// private int resultStatus;
	public int getResultStatus() {
		try {
			int data = getEntryInt(OP_TRADESERV3001.resultStatus);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setResultStatus(int resultStatus) {
		setEntry(OP_TRADESERV3001.resultStatus, resultStatus);
	}

	// private HashMap<Long, Double> valueMap = new HashMap<Long, Double>();
	// public HashMap<Long, Double> getValueMap() {
	// try {
	// HashMap<Long, Double> data = getEntryObject(OP_TRADESERV3001.valueMap);
	// return data;
	// } catch (RuntimeException e) {
	// return null;
	// }
	// }
	//
	// public void setValueMap(HashMap<Long, Double> valueMap) {
	// setEntry(OP_TRADESERV3001.valueMap, valueMap);
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
		return valueMap.keySet().toArray(new Long[0]);
	}

}