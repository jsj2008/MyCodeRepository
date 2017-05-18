package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.TradeTypeConfig;


public class C3_TradeTypeConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "23";

	public static final String tradeTypeName = "1";
	public static final String instrumentType = "2";
	public static final String maxOpenedOrderNumber = "3";
	public static final String maxOpenedPositionNumber = "4";
	public static final String isTradeable = "5";
	public static final String description = "6";
	public static final String tradeCtrlStrategyId = "7";

	public C3_TradeTypeConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(TradeTypeConfig data) throws Exception {
		setTradeTypeName(data.getTradeTypeName());
		setInstrumentType(data.getInstrumentType());
		setMaxOpenedOrderNumber(data.getMaxOpenedOrderNumber());
		setMaxOpenedPositionNumber(data.getMaxOpenedPositionNumber());
		setIsTradeable(data.getIsTradeable());
		setDescription(data.getDescription());
		setTradeCtrlStrategyId(data.getTradeCtrlStrategyId());
	}

	public TradeTypeConfig format(){
		TradeTypeConfig data=new TradeTypeConfig();
		data.setTradeTypeName(getTradeTypeName());
		data.setInstrumentType(getInstrumentType());
		data.setMaxOpenedOrderNumber(getMaxOpenedOrderNumber());
		data.setMaxOpenedPositionNumber(getMaxOpenedPositionNumber());
		data.setIsTradeable(getIsTradeable());
		data.setDescription(getDescription());
		data.setTradeCtrlStrategyId(getTradeCtrlStrategyId());
		return data;
	}


	public String getTradeTypeName() {
		try {
			String data=getEntryString(C3_TradeTypeConfig.tradeTypeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeTypeName(String tradeTypeName) {
		setEntry(C3_TradeTypeConfig.tradeTypeName, tradeTypeName);
	}

	public String getInstrumentType() {
		try {
			String data=getEntryString(C3_TradeTypeConfig.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(C3_TradeTypeConfig.instrumentType, instrumentType);
	}

	public int getMaxOpenedOrderNumber() {
		try {
			int data=getEntryInt(C3_TradeTypeConfig.maxOpenedOrderNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOpenedOrderNumber(int maxOpenedOrderNumber) {
		setEntry(C3_TradeTypeConfig.maxOpenedOrderNumber, maxOpenedOrderNumber);
	}

	public int getMaxOpenedPositionNumber() {
		try {
			int data=getEntryInt(C3_TradeTypeConfig.maxOpenedPositionNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOpenedPositionNumber(int maxOpenedPositionNumber) {
		setEntry(C3_TradeTypeConfig.maxOpenedPositionNumber, maxOpenedPositionNumber);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(C3_TradeTypeConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(C3_TradeTypeConfig.isTradeable, isTradeable);
	}

	public String getDescription() {
		try {
			String data=getEntryString(C3_TradeTypeConfig.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(C3_TradeTypeConfig.description, description);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data=getEntryString(C3_TradeTypeConfig.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(C3_TradeTypeConfig.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}


}