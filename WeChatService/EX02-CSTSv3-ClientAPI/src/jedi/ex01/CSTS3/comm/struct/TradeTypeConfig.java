package jedi.ex01.CSTS3.comm.struct;


public class TradeTypeConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "23";

	public static final String tradeTypeName = "1";
	public static final String instrumentType = "2";
	public static final String maxOpenedOrderNumber = "3";
	public static final String maxOpenedPositionNumber = "4";
	public static final String isTradeable = "5";
	public static final String description = "6";
	public static final String tradeCtrlStrategyId = "7";

	public TradeTypeConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public String getTradeTypeName() {
		try {
			String data=getEntryString(TradeTypeConfig.tradeTypeName);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeTypeName(String tradeTypeName) {
		setEntry(TradeTypeConfig.tradeTypeName, tradeTypeName);
	}

	public String getInstrumentType() {
		try {
			String data=getEntryString(TradeTypeConfig.instrumentType);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setInstrumentType(String instrumentType) {
		setEntry(TradeTypeConfig.instrumentType, instrumentType);
	}

	public int getMaxOpenedOrderNumber() {
		try {
			int data=getEntryInt(TradeTypeConfig.maxOpenedOrderNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOpenedOrderNumber(int maxOpenedOrderNumber) {
		setEntry(TradeTypeConfig.maxOpenedOrderNumber, maxOpenedOrderNumber);
	}

	public int getMaxOpenedPositionNumber() {
		try {
			int data=getEntryInt(TradeTypeConfig.maxOpenedPositionNumber);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxOpenedPositionNumber(int maxOpenedPositionNumber) {
		setEntry(TradeTypeConfig.maxOpenedPositionNumber, maxOpenedPositionNumber);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(TradeTypeConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(TradeTypeConfig.isTradeable, isTradeable);
	}

	public String getDescription() {
		try {
			String data=getEntryString(TradeTypeConfig.description);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setDescription(String description) {
		setEntry(TradeTypeConfig.description, description);
	}

	public String getTradeCtrlStrategyId() {
		try {
			String data=getEntryString(TradeTypeConfig.tradeCtrlStrategyId);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeCtrlStrategyId(String tradeCtrlStrategyId) {
		setEntry(TradeTypeConfig.tradeCtrlStrategyId, tradeCtrlStrategyId);
	}


}