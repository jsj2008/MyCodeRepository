package jedi.ex01.CSTS3.comm.struct;


public class SystemConfig extends allone.json.AbstractJsonData {

	public static final String jsonId = "20";

	public static final String closeStatus = "1";
	public static final String closeTimeInMil = "2";
	public static final String openTimeInMil = "3";
	public static final String autoClose = "4";
	public static final String batchCurrency = "5";
	public static final String tradeDay = "6";
	public static final String isTradeable = "7";
	public static final String isMarginUsedIncludeComm = "8";
	public static final String marginType = "9";
	public static final String HedgedMarginScale = "10";
	public static final String lotsDigits = "11";
	public static final String firstQuoteStopOrderValidGap = "12";
//	public static final String orderActiveType = "13";
//	public static final String isOpenTradeable = "14";
//	public static final String isCloseTradeable = "15";
//	public static final String isCanOrder = "16";
//	public static final String isCanStopOpen = "17";
//	public static final String isCanStopClose = "18";
//	public static final String marginEXPrec = "19";
//	public static final String marginEXDueDay = "20";
//	public static final String OrderMarginType = "21";
//	public static final String adjust4LiqType = "22";
	
	public static final String  orderActiveType = "23";
	public static final String  isOpenTradeable = "24";
	public static final String  isCloseTradeable = "25";
	public static final String  isCanOrder = "26";
	public static final String  isToAdjustToLiquidationMargin = "27";
	public static final String  maxTotalAmount = "28";

	public SystemConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public int getCloseStatus() {
		try {
			int data=getEntryInt(SystemConfig.closeStatus);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseStatus(int closeStatus) {
		setEntry(SystemConfig.closeStatus, closeStatus);
	}

	public int getCloseTimeInMil() {
		try {
			int data=getEntryInt(SystemConfig.closeTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseTimeInMil(int closeTimeInMil) {
		setEntry(SystemConfig.closeTimeInMil, closeTimeInMil);
	}

	public int getOpenTimeInMil() {
		try {
			int data=getEntryInt(SystemConfig.openTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenTimeInMil(int openTimeInMil) {
		setEntry(SystemConfig.openTimeInMil, openTimeInMil);
	}

	public int getAutoClose() {
		try {
			int data=getEntryInt(SystemConfig.autoClose);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoClose(int autoClose) {
		setEntry(SystemConfig.autoClose, autoClose);
	}

	public String getBatchCurrency() {
		try {
			String data=getEntryString(SystemConfig.batchCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchCurrency(String batchCurrency) {
		setEntry(SystemConfig.batchCurrency, batchCurrency);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(SystemConfig.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(SystemConfig.tradeDay, tradeDay);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(SystemConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(SystemConfig.isTradeable, isTradeable);
	}

	public int getIsMarginUsedIncludeComm() {
		try {
			int data=getEntryInt(SystemConfig.isMarginUsedIncludeComm);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsMarginUsedIncludeComm(int isMarginUsedIncludeComm) {
		setEntry(SystemConfig.isMarginUsedIncludeComm, isMarginUsedIncludeComm);
	}

	public int getMarginType() {
		try {
			int data=getEntryInt(SystemConfig.marginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginType(int marginType) {
		setEntry(SystemConfig.marginType, marginType);
	}

	public double getHedgedMarginScale() {
		try {
			double data=getEntryDouble(SystemConfig.HedgedMarginScale);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHedgedMarginScale(double HedgedMarginScale) {
		setEntry(SystemConfig.HedgedMarginScale, HedgedMarginScale);
	}

	public int getLotsDigits() {
		try {
			int data=getEntryInt(SystemConfig.lotsDigits);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLotsDigits(int lotsDigits) {
		setEntry(SystemConfig.lotsDigits, lotsDigits);
	}

	public double getFirstQuoteStopOrderValidGap() {
		try {
			double data=getEntryDouble(SystemConfig.firstQuoteStopOrderValidGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFirstQuoteStopOrderValidGap(double firstQuoteStopOrderValidGap) {
		setEntry(SystemConfig.firstQuoteStopOrderValidGap, firstQuoteStopOrderValidGap);
	}

//	public int getOrderActiveType() {
//		try {
//			int data=getEntryInt(SystemConfig.orderActiveType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setOrderActiveType(int orderActiveType) {
//		setEntry(SystemConfig.orderActiveType, orderActiveType);
//	}
//
//	public int getIsOpenTradeable() {
//		try {
//			int data=getEntryInt(SystemConfig.isOpenTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsOpenTradeable(int isOpenTradeable) {
//		setEntry(SystemConfig.isOpenTradeable, isOpenTradeable);
//	}
//
//	public int getIsCloseTradeable() {
//		try {
//			int data=getEntryInt(SystemConfig.isCloseTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCloseTradeable(int isCloseTradeable) {
//		setEntry(SystemConfig.isCloseTradeable, isCloseTradeable);
//	}
//
//	public int getIsCanOrder() {
//		try {
//			int data=getEntryInt(SystemConfig.isCanOrder);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanOrder(int isCanOrder) {
//		setEntry(SystemConfig.isCanOrder, isCanOrder);
//	}

//	public int getIsCanStopOpen() {
//		try {
//			int data=getEntryInt(SystemConfig.isCanStopOpen);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanStopOpen(int isCanStopOpen) {
//		setEntry(SystemConfig.isCanStopOpen, isCanStopOpen);
//	}
//
//	public int getIsCanStopClose() {
//		try {
//			int data=getEntryInt(SystemConfig.isCanStopClose);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanStopClose(int isCanStopClose) {
//		setEntry(SystemConfig.isCanStopClose, isCanStopClose);
//	}
//
//	public double getMarginEXPrec() {
//		try {
//			double data=getEntryDouble(SystemConfig.marginEXPrec);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setMarginEXPrec(double marginEXPrec) {
//		setEntry(SystemConfig.marginEXPrec, marginEXPrec);
//	}
//
//	public int getMarginEXDueDay() {
//		try {
//			int data=getEntryInt(SystemConfig.marginEXDueDay);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setMarginEXDueDay(int marginEXDueDay) {
//		setEntry(SystemConfig.marginEXDueDay, marginEXDueDay);
//	}
//
//	public int getOrderMarginType() {
//		try {
//			int data=getEntryInt(SystemConfig.OrderMarginType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setOrderMarginType(int OrderMarginType) {
//		setEntry(SystemConfig.OrderMarginType, OrderMarginType);
//	}
//
//	public int getAdjust4LiqType() {
//		try {
//			int data=getEntryInt(SystemConfig.adjust4LiqType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setAdjust4LiqType(int adjust4LiqType) {
//		setEntry(SystemConfig.adjust4LiqType, adjust4LiqType);
//	}
	
	public int getOrderActiveType() {
		try {
			int data=getEntryInt(SystemConfig.orderActiveType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderActiveType(int orderActiveType) {
		setEntry(SystemConfig.orderActiveType, orderActiveType);
	}
	
	public int getIsOpenTradeable() {
		try {
			int data=getEntryInt(SystemConfig.isOpenTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsOpenTradeable(int isOpenTradeable) {
		setEntry(SystemConfig.isOpenTradeable, isOpenTradeable);
	}
	
	public int getIsCloseTradeable() {
		try {
			int data=getEntryInt(SystemConfig.isCloseTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCloseTradeable(int isCloseTradeable) {
		setEntry(SystemConfig.isCloseTradeable, isCloseTradeable);
	}
	
	public int getIsCanOrder() {
		try {
			int data=getEntryInt(SystemConfig.isCanOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCanOrder(int lotsDigits) {
		setEntry(SystemConfig.isCanOrder, isCanOrder);
	}
	
	public int getIsToAdjustToLiquidationMargin() {
		try {
			int data=getEntryInt(SystemConfig.isToAdjustToLiquidationMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToAdjustToLiquidationMargin(int isToAdjustToLiquidationMargin) {
		setEntry(SystemConfig.isToAdjustToLiquidationMargin, isToAdjustToLiquidationMargin);
	}

	public double getMaxTotalAmount() {
		try {
			double data=getEntryDouble(SystemConfig.maxTotalAmount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxTotalAmount(double maxTotalAmount) {
		setEntry(SystemConfig.maxTotalAmount, maxTotalAmount);
	}


}