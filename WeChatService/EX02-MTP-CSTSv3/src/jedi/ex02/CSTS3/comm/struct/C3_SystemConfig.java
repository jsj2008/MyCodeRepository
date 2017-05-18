package jedi.ex02.CSTS3.comm.struct;

import jedi.v7.comm.datastruct.DB.SystemConfig;


public class C3_SystemConfig extends allone.json.AbstractJsonData {

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
	
	
	public C3_SystemConfig(){
		super();
		setEntry("jsonId", jsonId);
	}

	public void parseFromSysData(SystemConfig data) throws Exception {
		setCloseStatus(data.getCloseStatus());
		setCloseTimeInMil(data.getCloseTimeInMil());
		setOpenTimeInMil(data.getOpenTimeInMil());
		setAutoClose(data.getAutoClose());
		setBatchCurrency(data.getBatchCurrency());
		setTradeDay(data.getTradeDay());
		setIsTradeable(data.getIsTradeable());
		setIsMarginUsedIncludeComm(data.getIsMarginUsedIncludeComm());
		setMarginType(data.getMarginType());
		setHedgedMarginScale(data.getHedgedMarginScale());
		setLotsDigits(data.getLotsDigits());
		setFirstQuoteStopOrderValidGap(data.getFirstQuoteStopOrderValidGap());
		
		
//		setOrderActiveType(data.getOrderActiveType());
//		setIsOpenTradeable(data.getIsOpenTradeable());
//		setIsCloseTradeable(data.getIsCloseTradeable());
//		setIsCanOrder(data.getIsCanOrder());
//		setIsCanStopOpen(data.getIsCanStopOpen());
//		setIsCanStopClose(data.getIsCanStopClose());
//		setMarginEXPrec(data.getMarginEXPrec());
//		setMarginEXDueDay(data.getMarginEXDueDay());
//		setOrderMarginType(data.getOrderMarginType());
//		setAdjust4LiqType(data.getAdjust4LiqType());
		
		setOrderActiveType(data.getOrderActiveType());
		setIsOpenTradeable(data.getIsOpenTradeable());
		setIsCloseTradeable(data.getIsCloseTradeable());
		setIsCanOrder(data.getIsCanOrder());
		setIsToAdjustToLiquidationMargin(data.getIsToAdjustToLiquidationMargin());
		setMaxTotalAmount(data.getMaxTotalAmount());
	}

	public SystemConfig format(){
		SystemConfig data=new SystemConfig();
		data.setCloseStatus(getCloseStatus());
		data.setCloseTimeInMil(getCloseTimeInMil());
		data.setOpenTimeInMil(getOpenTimeInMil());
		data.setAutoClose(getAutoClose());
		data.setBatchCurrency(getBatchCurrency());
		data.setTradeDay(getTradeDay());
		data.setIsTradeable(getIsTradeable());
		data.setIsMarginUsedIncludeComm(getIsMarginUsedIncludeComm());
		data.setMarginType(getMarginType());
		data.setHedgedMarginScale(getHedgedMarginScale());
		data.setLotsDigits(getLotsDigits());
		data.setFirstQuoteStopOrderValidGap(getFirstQuoteStopOrderValidGap());
//		data.setOrderActiveType(getOrderActiveType());
//		data.setIsOpenTradeable(getIsOpenTradeable());
//		data.setIsCloseTradeable(getIsCloseTradeable());
//		data.setIsCanOrder(getIsCanOrder());
//		data.setIsCanStopOpen(getIsCanStopOpen());
//		data.setIsCanStopClose(getIsCanStopClose());
//		data.setMarginEXPrec(getMarginEXPrec());
//		data.setMarginEXDueDay(getMarginEXDueDay());
//		data.setOrderMarginType(getOrderMarginType());
//		data.setAdjust4LiqType(getAdjust4LiqType());
		
		data.setOrderActiveType(getOrderActiveType());
		data.setIsOpenTradeable(getIsOpenTradeable());
		data.setIsCloseTradeable(getIsCloseTradeable());
		data.setIsCanOrder(getIsCanOrder());
		data.setIsToAdjustToLiquidationMargin(getIsToAdjustToLiquidationMargin());
		data.setMaxTotalAmount(getMaxTotalAmount());
		
		return data;
	}


	public int getCloseStatus() {
		try {
			int data=getEntryInt(C3_SystemConfig.closeStatus);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseStatus(int closeStatus) {
		setEntry(C3_SystemConfig.closeStatus, closeStatus);
	}

	public int getCloseTimeInMil() {
		try {
			int data=getEntryInt(C3_SystemConfig.closeTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setCloseTimeInMil(int closeTimeInMil) {
		setEntry(C3_SystemConfig.closeTimeInMil, closeTimeInMil);
	}

	public int getOpenTimeInMil() {
		try {
			int data=getEntryInt(C3_SystemConfig.openTimeInMil);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOpenTimeInMil(int openTimeInMil) {
		setEntry(C3_SystemConfig.openTimeInMil, openTimeInMil);
	}

	public int getAutoClose() {
		try {
			int data=getEntryInt(C3_SystemConfig.autoClose);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setAutoClose(int autoClose) {
		setEntry(C3_SystemConfig.autoClose, autoClose);
	}

	public String getBatchCurrency() {
		try {
			String data=getEntryString(C3_SystemConfig.batchCurrency);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setBatchCurrency(String batchCurrency) {
		setEntry(C3_SystemConfig.batchCurrency, batchCurrency);
	}

	public String getTradeDay() {
		try {
			String data=getEntryString(C3_SystemConfig.tradeDay);
			return data;
		} catch (RuntimeException e) {
			return null;
		}
	}

	public void setTradeDay(String tradeDay) {
		setEntry(C3_SystemConfig.tradeDay, tradeDay);
	}

	public int getIsTradeable() {
		try {
			int data=getEntryInt(C3_SystemConfig.isTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsTradeable(int isTradeable) {
		setEntry(C3_SystemConfig.isTradeable, isTradeable);
	}

	public int getIsMarginUsedIncludeComm() {
		try {
			int data=getEntryInt(C3_SystemConfig.isMarginUsedIncludeComm);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsMarginUsedIncludeComm(int isMarginUsedIncludeComm) {
		setEntry(C3_SystemConfig.isMarginUsedIncludeComm, isMarginUsedIncludeComm);
	}

	public int getMarginType() {
		try {
			int data=getEntryInt(C3_SystemConfig.marginType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMarginType(int marginType) {
		setEntry(C3_SystemConfig.marginType, marginType);
	}

	public double getHedgedMarginScale() {
		try {
			double data=getEntryDouble(C3_SystemConfig.HedgedMarginScale);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setHedgedMarginScale(double HedgedMarginScale) {
		setEntry(C3_SystemConfig.HedgedMarginScale, HedgedMarginScale);
	}

	public int getLotsDigits() {
		try {
			int data=getEntryInt(C3_SystemConfig.lotsDigits);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setLotsDigits(int lotsDigits) {
		setEntry(C3_SystemConfig.lotsDigits, lotsDigits);
	}

	public double getFirstQuoteStopOrderValidGap() {
		try {
			double data=getEntryDouble(C3_SystemConfig.firstQuoteStopOrderValidGap);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setFirstQuoteStopOrderValidGap(double firstQuoteStopOrderValidGap) {
		setEntry(C3_SystemConfig.firstQuoteStopOrderValidGap, firstQuoteStopOrderValidGap);
	}

//	public int getOrderActiveType() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.orderActiveType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setOrderActiveType(int orderActiveType) {
//		setEntry(C3_SystemConfig.orderActiveType, orderActiveType);
//	}
//
//	public int getIsOpenTradeable() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.isOpenTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsOpenTradeable(int isOpenTradeable) {
//		setEntry(C3_SystemConfig.isOpenTradeable, isOpenTradeable);
//	}
//
//	public int getIsCloseTradeable() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.isCloseTradeable);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCloseTradeable(int isCloseTradeable) {
//		setEntry(C3_SystemConfig.isCloseTradeable, isCloseTradeable);
//	}
//
//	public int getIsCanOrder() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.isCanOrder);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanOrder(int isCanOrder) {
//		setEntry(C3_SystemConfig.isCanOrder, isCanOrder);
//	}
//
//	public int getIsCanStopOpen() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.isCanStopOpen);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanStopOpen(int isCanStopOpen) {
//		setEntry(C3_SystemConfig.isCanStopOpen, isCanStopOpen);
//	}
//
//	public int getIsCanStopClose() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.isCanStopClose);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setIsCanStopClose(int isCanStopClose) {
//		setEntry(C3_SystemConfig.isCanStopClose, isCanStopClose);
//	}
//
//	public double getMarginEXPrec() {
//		try {
//			double data=getEntryDouble(C3_SystemConfig.marginEXPrec);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setMarginEXPrec(double marginEXPrec) {
//		setEntry(C3_SystemConfig.marginEXPrec, marginEXPrec);
//	}
//
//	public int getMarginEXDueDay() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.marginEXDueDay);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setMarginEXDueDay(int marginEXDueDay) {
//		setEntry(C3_SystemConfig.marginEXDueDay, marginEXDueDay);
//	}
//
//	public int getOrderMarginType() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.OrderMarginType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setOrderMarginType(int OrderMarginType) {
//		setEntry(C3_SystemConfig.OrderMarginType, OrderMarginType);
//	}
//
//	public int getAdjust4LiqType() {
//		try {
//			int data=getEntryInt(C3_SystemConfig.adjust4LiqType);
//			return data;
//		} catch (RuntimeException e) {
//			return 0;
//		}
//	}
//
//	public void setAdjust4LiqType(int adjust4LiqType) {
//		setEntry(C3_SystemConfig.adjust4LiqType, adjust4LiqType);
//	}

	public int getOrderActiveType() {
		try {
			int data=getEntryInt(C3_SystemConfig.orderActiveType);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setOrderActiveType(int orderActiveType) {
		setEntry(C3_SystemConfig.orderActiveType, orderActiveType);
	}
	
	public int getIsOpenTradeable() {
		try {
			int data=getEntryInt(C3_SystemConfig.isOpenTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsOpenTradeable(int isOpenTradeable) {
		setEntry(C3_SystemConfig.isOpenTradeable, isOpenTradeable);
	}
	
	public int getIsCloseTradeable() {
		try {
			int data=getEntryInt(C3_SystemConfig.isCloseTradeable);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCloseTradeable(int isCloseTradeable) {
		setEntry(C3_SystemConfig.isCloseTradeable, isCloseTradeable);
	}
	
	public int getIsCanOrder() {
		try {
			int data=getEntryInt(C3_SystemConfig.isCanOrder);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsCanOrder(int lotsDigits) {
		setEntry(C3_SystemConfig.isCanOrder, isCanOrder);
	}
	
	public int getIsToAdjustToLiquidationMargin() {
		try {
			int data=getEntryInt(C3_SystemConfig.isToAdjustToLiquidationMargin);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setIsToAdjustToLiquidationMargin(int isToAdjustToLiquidationMargin) {
		setEntry(C3_SystemConfig.isToAdjustToLiquidationMargin, isToAdjustToLiquidationMargin);
	}

	public double getMaxTotalAmount() {
		try {
			double data=getEntryDouble(C3_SystemConfig.maxTotalAmount);
			return data;
		} catch (RuntimeException e) {
			return 0;
		}
	}

	public void setMaxTotalAmount(double maxTotalAmount) {
		setEntry(C3_SystemConfig.maxTotalAmount, maxTotalAmount);
	}
}